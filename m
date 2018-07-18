From: edgar.righi@lsitec.org.br (Edgar Bernardi Righi)
Date: Wed, 18 Jul 2018 12:54:44 -0300
Subject: [PATCH v1 03/04] arm: dts: actions: Enable clock controller for
 Actions Semi S500 SoC
Message-ID: <CADHB5bDhdXonoSUahgxqV8_rcUwYxvh3t9WDNN4YO8g7KSt07Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable clock controller for Actions Semi S500 SoC on owl-s500 device tree.
Tested on a Lemaker Guitar board.

File(s) updated: "/arch/arm/boot/dts/owl-s500.dtsi"

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>

diff -uprN -X vanilla/Documentation/dontdiff
vanilla/arch/arm/boot/dts/owl-s500.dtsi
linux/arch/arm/boot/dts/owl-s500.dtsi
--- vanilla/arch/arm/boot/dts/owl-s500.dtsi    2018-07-17
13:07:15.675710000 -0300
+++ linux/arch/arm/boot/dts/owl-s500.dtsi    2018-07-18 12:51:07.875364441 -0300
@@ -2,12 +2,14 @@
  * Actions Semi S500 SoC
  *
  * Copyright (c) 2016-2017 Andreas F?rber
+ * Copyright (c) 2018-2018 Edgar Bernardi Righi
  *
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */

 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
+#include <dt-bindings/clock/actions,s500-cmu.h>

 / {
     compatible = "actions,s500";
@@ -71,6 +73,12 @@
         #clock-cells = <0>;
     };

+    losc: losc {
+        compatible = "fixed-clock";
+        clock-frequency = <32678>;
+        #clock-cells = <0>;
+    };
+
     soc {
         compatible = "simple-bus";
         #address-cells = <1>;
@@ -170,6 +178,13 @@
             status = "disabled";
         };

+        cmu: clock-controller at b0160000 {
+            compatible = "actions,s500-cmu";
+            reg = <0xb0160000 0x8000>;
+            clocks = <&hosc>, <&losc>;
+            #clock-cells = <1>;
+        };
+
         timer: timer at b0168000 {
             compatible = "actions,s500-timer";
             reg = <0xb0168000 0x8000>;
