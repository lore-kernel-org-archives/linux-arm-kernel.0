From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Jul 2012 20:08:13 +0800
Subject: [PATCH] ARM: dts: imx: update #interrupt-cells for gpio nodes
In-Reply-To: <20120706075434.GE30009@pengutronix.de>
References: <20120706075434.GE30009@pengutronix.de>
Message-ID: <1341576493-10936-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the value of #interrupt-cells of gpio nodes from 1 to 2, so that
the gpio irq type can be specified in device tree.  Also update binding
document to make it clear.

Reported-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/gpio/fsl-imx-gpio.txt      |    9 +++++++++
 arch/arm/boot/dts/imx27.dtsi                       |   12 ++++++------
 arch/arm/boot/dts/imx51.dtsi                       |    8 ++++----
 arch/arm/boot/dts/imx53.dtsi                       |   14 +++++++-------
 arch/arm/boot/dts/imx6q.dtsi                       |   14 +++++++-------
 5 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
index 5f360e7..4f39297 100644
--- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
@@ -11,6 +11,13 @@ Required properties:
   the second cell is used to specify the gpio polarity:
       0 = active high
       1 = active low
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells : Should be 2.  The first cell is the GPIO number.
+  The second cell bits[3:0] is used to specify trigger type and level flags:
+      1 = low-to-high edge triggered.
+      2 = high-to-low edge triggered.
+      4 = active high level-sensitive.
+      8 = active low level-sensitive.
 
 Example:
 
@@ -20,4 +27,6 @@ gpio0: gpio at 73f84000 {
 	interrupts = <50 51>;
 	gpio-controller;
 	#gpio-cells = <2>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
 };
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 386c769..00bae3a 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -121,7 +121,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio2: gpio at 10015100 {
@@ -131,7 +131,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio3: gpio at 10015200 {
@@ -141,7 +141,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio4: gpio at 10015300 {
@@ -151,7 +151,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio5: gpio at 10015400 {
@@ -161,7 +161,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio6: gpio at 10015500 {
@@ -171,7 +171,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			cspi3: cspi at 10017000 {
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index bfa65ab..922adef 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -133,7 +133,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio2: gpio at 73f88000 {
@@ -143,7 +143,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio3: gpio at 73f8c000 {
@@ -153,7 +153,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio4: gpio at 73f90000 {
@@ -163,7 +163,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			wdog at 73f98000 { /* WDOG1 */
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index e3e8694..4e735ed 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -135,7 +135,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio2: gpio at 53f88000 {
@@ -145,7 +145,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio3: gpio at 53f8c000 {
@@ -155,7 +155,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio4: gpio at 53f90000 {
@@ -165,7 +165,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			wdog at 53f98000 { /* WDOG1 */
@@ -203,7 +203,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio6: gpio at 53fe0000 {
@@ -213,7 +213,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio7: gpio at 53fe4000 {
@@ -223,7 +223,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			i2c at 53fec000 { /* I2C3 */
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 16a3884..bf88fb7 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -283,7 +283,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio2: gpio at 020a0000 {
@@ -293,7 +293,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio3: gpio at 020a4000 {
@@ -303,7 +303,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio4: gpio at 020a8000 {
@@ -313,7 +313,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio5: gpio at 020ac000 {
@@ -323,7 +323,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio6: gpio at 020b0000 {
@@ -333,7 +333,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			gpio7: gpio at 020b4000 {
@@ -343,7 +343,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-				#interrupt-cells = <1>;
+				#interrupt-cells = <2>;
 			};
 
 			kpp at 020b8000 {
-- 
1.7.5.4
