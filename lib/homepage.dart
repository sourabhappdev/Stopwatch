import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Timer t;
  late Stopwatch stopwatch;
  String start = "START";
  List lap = [];

  void handleStartStop() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
      start = "START";
    } else {
      stopwatch.start();

      start = "PAUSE";
    }
  }

  String returnFormattedText() {
    var milli = stopwatch.elapsed.inMilliseconds;
    String milliseconds = (milli % 1000).toString().padLeft(3, "0");
    String seconds = ((milli ~/ 1000) % 60).toString().padLeft(2, "0");
    String minutes = (((milli ~/ 1000) ~/ 60) % 60).toString().padLeft(2, "0");
    return "$minutes:$seconds:$milliseconds";
  }

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();

    t = Timer.periodic(const Duration(microseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5b301),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'TIME WAITS FOR NONE',
              style: TextStyle(
                color: Color(0xff1e2328),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            CupertinoButton(
              onPressed: () {
                handleStartStop();
              },
              padding: const EdgeInsets.all(0),
              child: Container(
                height: 260,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xff1e2328),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: Text(
                  returnFormattedText(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xfff5b301),
                shape: BoxShape.rectangle,
                border: Border.all(
                  width: 2,
                  color: const Color(0xff1e2328),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                itemCount: lap.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "LAP  ${index + 1}",
                          style: const TextStyle(
                            color: Color(0xff1e2328),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,

                          ),
                        ),

                        Text(
                          "${lap[index]}",
                          style: const TextStyle(
                            color: Color(0xff1e2328),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RawMaterialButton(
                    fillColor: const Color(0xff1e2328),
                    onPressed: () {
                      handleStartStop();
                    },
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: Color(0xff1e2328),
                      ),
                    ),
                    child: Text(
                      start,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                IconButton(
                  iconSize: 50,
                  onPressed: () {
                    lap.add(returnFormattedText());
                  },
                  icon: const Icon(Icons.flag),
                  color: const Color(0xff1e2328),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: RawMaterialButton(
                    fillColor: const Color(0xff1e2328),
                    onPressed: () {
                      lap.clear();
                      stopwatch.reset();
                      if (stopwatch.isRunning) {
                        stopwatch.stop();
                        start = "START";
                      }
                    },
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: Color(0xff1e2328),
                      ),
                    ),
                    child: const Text(
                      'RESET',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
