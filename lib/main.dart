import 'package:flutter/material.dart';
import 'package:quiz/questions.dart';

void main() => runApp(const MaterialApp(
      home: Quiz(),
      debugShowCheckedModeBanner: false,
    ));

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int score = 0;
  var step = 0;

  List questionsList = [
    Questions("Vision is a Alien?", false),
    Questions("Iron man died in End game?", true),
    Questions("First Avenger movie is age of ultrons", false),
  ];

  void reset(context) {
    setState(() {
      score = 0;
      step = 0;
    });

    final snackBar = SnackBar(
      content: const Text("Reset Done Successfully"),
      duration: const Duration(milliseconds: 800),
      backgroundColor: Colors.green,
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  void checkAnswer(bool choice, BuildContext context) {
    if (choice == questionsList[step].ans) {
      score = score + 1;

      final snackBar = SnackBar(
        content: const Text("Right !!!"),
        duration: const Duration(milliseconds: 800),
        backgroundColor: Colors.green,
      );

      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: const Text("Wrong"),
        duration: const Duration(milliseconds: 800),
        backgroundColor: Colors.red,
      );

      Scaffold.of(context).showSnackBar(snackBar);
    }

    setState(() {
      if (step < questionsList.length - 1) {
        step = step + 1;
      } else {
        final snackBar = SnackBar(
          content: Text("Quiz Completed $score/3"),
          duration: const Duration(milliseconds: 1500),
          backgroundColor: Colors.blueAccent,
        );

        Scaffold.of(context).showSnackBar(snackBar);
        reset(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quiz",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
          centerTitle: true,
          backgroundColor: Colors.orange[800],
        ),
        body: Builder(builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("score:$score/3"),
                        RaisedButton(
                            onPressed: () => reset(context),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.all(0),
                            color: Colors.orange,
                            child: const Text("Reset",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15)))
                      ],
                    ),
                  ),
                  Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.orange,
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[Text(questionsList[step].question)],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: RaisedButton(
                            padding: const EdgeInsets.all(10),
                            color: Colors.green,
                            onPressed: () => checkAnswer(true, context),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Text("True",
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: RaisedButton(
                            padding: const EdgeInsets.all(10),
                            color: Colors.red[500],
                            onPressed: () => checkAnswer(false, context),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Text("False",
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                      ),
                    ],
                  ),
                ]),
          );
        }));
  }
}
