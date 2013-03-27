From: pankaj.chauhan@gmail.com (Pankaj Chauhan)
Date: Wed, 27 Mar 2013 08:40:58 +0530
Subject: [query] IMX6 DTS : Device node with two interrupt parents
Message-ID: <CAGp-zT7d-=CXTH41hsMgA_bZLoQot+uAAoD4hs5=UU1n__cEaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

I have a query for adding device node in dts of board based on IMX6.
On the board i have a controller whole interrupt lines are connected
to interruptible GPIOs. But problem is out of three interrupt lines
two are connected to gpio4 and one is connected to gpio5, which means
i have two interrupt parents to specify in device node. My node looks
something like this:

queue-group at 0 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					reg-names = "queue-group0";
+					reg = <0x0d480000 0x1000>;
+					interrupts = <11 0 27 0 26 0>;
+                                      interrupt-parent = <&gpio4>;
+				};

here 27 and 26 are on gpio4 but 11 is on gpio5.  Is there a way to
specify multiple interrupt parents? what is the correct way to handle
such configuration.

-pankaj
