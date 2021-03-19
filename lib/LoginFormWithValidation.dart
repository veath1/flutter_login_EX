import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'HomePage.dart';

class LoginFormValidation extends StatefulWidget {
  @override
  _LoginFormValidationState createState() => _LoginFormValidationState();
}


class _LoginFormValidationState extends State<LoginFormValidation> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String _email, _password;
  void _showDialogpwerror() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("error"),
          content: new Text("Password error"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  void _showDialogeaerror() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("error"),
          content: new Text("email error"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  String checkPassword(String value) {

    if (value == "P@ssw0rd") {
      return 'good';
    }
    return 'not';

  }
  String checkemail(String value) {

    if (value == "a@a.a") {
      return 'good';
    }
    return 'not';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidate: true, //check for validation while typing
          key: formkey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      child: Image.asset('asset/images/flutter-logo.png')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                    onChanged: (input) => _email = input,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      EmailValidator(errorText: "Enter valid email id"),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                    onChanged: (input) => _password = input,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(6,
                          errorText: "Password should be atleast 6 characters"),
                      MaxLengthValidator(15,
                          errorText:
                          "Password should not be greater than 15 characters")
                    ])
                  //validatePassword,        //Function to check validation
                ),
              ),
              FlatButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    if (formkey.currentState.validate() ) {
                      if(checkemail(_email)=='good') {
                        if(checkPassword(_password)=='good') {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => HomePage()));
                        }else{
                          _showDialogpwerror();
                        }
                      }else{
                        _showDialogeaerror();
                      }
                      print("Validated");
                    } else {
                      print("Not Validated");
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),

              Text('New User? Create Account'),
            ],
          ),
        ),
      ),
    );
  }
}
