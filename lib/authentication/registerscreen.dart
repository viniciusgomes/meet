import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:talkcoffee/screens/homepage.dart';

import '../variables.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwrodcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height /2, 
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.brown[600], Colors.brown[400]])
            ),
            child: Center(
              child: Image.asset('images/logo.png', height: 100)
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.6,
              margin: EdgeInsets.only(left:30,right:30),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0,3)
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50,),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      style: mystyle(18, Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller ,
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                        hintStyle: mystyle(20, Colors.grey, FontWeight.w700)
                      ),
                    )
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      style: mystyle(18, Colors.black),
                      controller: passwrodcontroller,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        hintStyle: mystyle(20, Colors.grey, FontWeight.w700)
                      ),
                    )
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      style: mystyle(18, Colors.black),
                      controller: usernamecontroller,
                      decoration: InputDecoration(
                        hintText: "Username",
                        prefixIcon: Icon(Icons.person),
                        hintStyle: mystyle(20, Colors.grey, FontWeight.w700)
                      ),
                    )
                  ),
                  SizedBox(height: 40,),
                  InkWell(
                    onTap: (){
                      try {
                        FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailcontroller.text, password: passwrodcontroller.text)
                        .then((signeduser){
                          usercollection.doc(signeduser.user.uid).set({
                            'username': usernamecontroller.text,
                            'email': emailcontroller.text,
                            'password': passwrodcontroller.text,
                            'uid': signeduser.user.uid,
                          });
                          int count = 0;
                          FirebaseAuth.instance
                          .signInWithEmailAndPassword(email: emailcontroller.text, password: passwrodcontroller.text);
                          Navigator.popUntil(context, (route){
                            return count++ == 2;
                          });
                        });
                      } catch (e) {
                        print(e);
                        var snackbar = SnackBar(content:  Text(e.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                      }
                      
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: GradientColors.pink),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Text("SIGN UP", style: mystyle(20, Colors.white),),
                      ),
                    ),
                  ) 
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}