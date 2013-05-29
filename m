From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 29 May 2013 19:19:49 +0200
Subject: [PATCH] ARM: ux500: use symbolic names for interrupt flags
Message-ID: <1369847989-10017-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This switches to including <dt-bindings/interrupt-controller/irq.h>
and referencing the apropriate flags from there instead of
open-coding the flag numerals everywhere in the ux500 device
trees.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi  | 104 +++++++++++++++++++++--------------------
 arch/arm/boot/dts/href.dtsi    |   5 +-
 arch/arm/boot/dts/snowball.dts |   2 +-
 arch/arm/boot/dts/stuib.dtsi   |   4 +-
 4 files changed, 60 insertions(+), 55 deletions(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 663d3de..b4b542b 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -9,6 +9,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "skeleton.dtsi"
 
 / {
@@ -31,33 +32,33 @@
 		L2: l2-cache {
 			compatible = "arm,pl310-cache";
 			reg = <0xa0412000 0x1000>;
-			interrupts = <0 13 4>;
+			interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>;
 			cache-unified;
 			cache-level = <2>;
 		};
 
 		pmu {
 			compatible = "arm,cortex-a9-pmu";
-			interrupts = <0 7 0x4>;
+			interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		timer at a0410600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xa0410600 0x20>;
-			interrupts = <1 13 0x304>;
+			interrupts = <1 13 0x304>; /* IRQ level high per-CPU */
 		};
 
 		rtc at 80154000 {
 			compatible = "arm,rtc-pl031", "arm,primecell";
 			reg = <0x80154000 0x1000>;
-			interrupts = <0 18 0x4>;
+			interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		gpio0: gpio at 8012e000 {
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0x8012e000 0x80>;
-			interrupts = <0 119 0x4>;
+			interrupts = <0 119 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -70,7 +71,7 @@
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0x8012e080 0x80>;
-			interrupts = <0 120 0x4>;
+			interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -83,7 +84,7 @@
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0x8000e000 0x80>;
-			interrupts = <0 121 0x4>;
+			interrupts = <0 121 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -96,7 +97,7 @@
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0x8000e080 0x80>;
-			interrupts = <0 122 0x4>;
+			interrupts = <0 122 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -109,7 +110,7 @@
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0x8000e100 0x80>;
-			interrupts = <0 123 0x4>;
+			interrupts = <0 123 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -122,7 +123,7 @@
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0x8000e180 0x80>;
-			interrupts = <0 124 0x4>;
+			interrupts = <0 124 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -135,7 +136,7 @@
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0x8011e000 0x80>;
-			interrupts = <0 125 0x4>;
+			interrupts = <0 125 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -148,7 +149,7 @@
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0x8011e080 0x80>;
-			interrupts = <0 126 0x4>;
+			interrupts = <0 126 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -161,7 +162,7 @@
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
 			reg =  <0xa03fe000 0x80>;
-			interrupts = <0 127 0x4>;
+			interrupts = <0 127 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			st,supports-sleepmode;
@@ -179,7 +180,7 @@
 			compatible = "stericsson,db8500-musb",
 				"mentor,musb";
 			reg = <0xa03e0000 0x10000>;
-			interrupts = <0 23 0x4>;
+			interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mc";
 
 			dr_mode = "otg";
@@ -215,7 +216,7 @@
 			compatible = "stericsson,db8500-dma40", "stericsson,dma40";
 			reg = <0x801C0000 0x1000 0x40010000 0x800>;
 			reg-names = "base", "lcpa";
-			interrupts = <0 25 0x4>;
+			interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
 
 			#dma-cells = <3>;
 			memcpy-channels = <56 57 58 59 60>;
@@ -225,7 +226,7 @@
 			compatible = "stericsson,db8500-prcmu";
 			reg = <0x80157000 0x2000>, <0x801b0000 0x8000>, <0x801b8000 0x1000>;
 			reg-names = "prcmu", "prcmu-tcpm", "prcmu-tcdm";
-			interrupts = <0 47 0x4>;
+			interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			interrupt-controller;
@@ -240,7 +241,8 @@
 			thermal at 801573c0 {
 				compatible = "stericsson,db8500-thermal";
 				reg = <0x801573c0 0x40>;
-				interrupts = <21 0x4>, <22 0x4>;
+				interrupts = <21 IRQ_TYPE_LEVEL_HIGH>,
+					     <22 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "IRQ_HOTMON_LOW", "IRQ_HOTMON_HIGH";
 				status = "disabled";
 			 };
@@ -354,21 +356,21 @@
 			ab8500 {
 				compatible = "stericsson,ab8500";
 				interrupt-parent = <&intc>;
-				interrupts = <0 40 0x4>;
+				interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
 
 				ab8500-rtc {
 					compatible = "stericsson,ab8500-rtc";
-					interrupts = <17 0x4
-					              18 0x4>;
+					interrupts = <17 IRQ_TYPE_LEVEL_HIGH
+						      18 IRQ_TYPE_LEVEL_HIGH>;
 					interrupt-names = "60S", "ALARM";
 				};
 
 				ab8500-gpadc {
 					compatible = "stericsson,ab8500-gpadc";
-					interrupts = <32 0x4
-						      39 0x4>;
+					interrupts = <32 IRQ_TYPE_LEVEL_HIGH
+						      39 IRQ_TYPE_LEVEL_HIGH>;
 					interrupt-names = "HW_CONV_END", "SW_CONV_END";
 					vddadc-supply = <&ab8500_ldo_tvout_reg>;
 				};
@@ -401,13 +403,13 @@
 
 				ab8500_usb {
 					compatible = "stericsson,ab8500-usb";
-					interrupts = < 90 0x4
-						       96 0x4
-						       14 0x4
-						       15 0x4
-						       79 0x4
-						       74 0x4
-						       75 0x4>;
+					interrupts = < 90 IRQ_TYPE_LEVEL_HIGH
+						       96 IRQ_TYPE_LEVEL_HIGH
+						       14 IRQ_TYPE_LEVEL_HIGH
+						       15 IRQ_TYPE_LEVEL_HIGH
+						       79 IRQ_TYPE_LEVEL_HIGH
+						       74 IRQ_TYPE_LEVEL_HIGH
+						       75 IRQ_TYPE_LEVEL_HIGH>;
 					interrupt-names = "ID_WAKEUP_R",
 							  "ID_WAKEUP_F",
 							  "VBUS_DET_F",
@@ -422,8 +424,8 @@
 
 				ab8500-ponkey {
 					compatible = "stericsson,ab8500-poweron-key";
-					interrupts = <6 0x4
-						      7 0x4>;
+					interrupts = <6 IRQ_TYPE_LEVEL_HIGH
+						      7 IRQ_TYPE_LEVEL_HIGH>;
 					interrupt-names = "ONKEY_DBF", "ONKEY_DBR";
 				};
 
@@ -518,7 +520,7 @@
 		i2c at 80004000 {
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x80004000 0x1000>;
-			interrupts = <0 21 0x4>;
+			interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
 			arm,primecell-periphid = <0x180024>;
 
 			#address-cells = <1>;
@@ -531,7 +533,7 @@
 		i2c at 80122000 {
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x80122000 0x1000>;
-			interrupts = <0 22 0x4>;
+			interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
 			arm,primecell-periphid = <0x180024>;
 
 			#address-cells = <1>;
@@ -544,7 +546,7 @@
 		i2c at 80128000 {
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x80128000 0x1000>;
-			interrupts = <0 55 0x4>;
+			interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>;
 			arm,primecell-periphid = <0x180024>;
 
 			#address-cells = <1>;
@@ -557,7 +559,7 @@
 		i2c at 80110000 {
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x80110000 0x1000>;
-			interrupts = <0 12 0x4>;
+			interrupts = <0 12 IRQ_TYPE_LEVEL_HIGH>;
 			arm,primecell-periphid = <0x180024>;
 
 			#address-cells = <1>;
@@ -570,7 +572,7 @@
 		i2c at 8012a000 {
 			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
 			reg = <0x8012a000 0x1000>;
-			interrupts = <0 51 0x4>;
+			interrupts = <0 51 IRQ_TYPE_LEVEL_HIGH>;
 			arm,primecell-periphid = <0x180024>;
 
 			#address-cells = <1>;
@@ -583,7 +585,7 @@
 		ssp at 80002000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x80002000 0x1000>;
-			interrupts = <0 14 0x4>;
+			interrupts = <0 14 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -597,7 +599,7 @@
 		uart at 80120000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80120000 0x1000>;
-			interrupts = <0 11 0x4>;
+			interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
 
 			dmas = <&dma 13 0 0x2>, /* Logical - DevToMem */
 			       <&dma 13 0 0x0>; /* Logical - MemToDev */
@@ -609,7 +611,7 @@
 		uart at 80121000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80121000 0x1000>;
-			interrupts = <0 19 0x4>;
+			interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
 
 			dmas = <&dma 12 0 0x2>, /* Logical - DevToMem */
 			       <&dma 12 0 0x0>; /* Logical - MemToDev */
@@ -621,7 +623,7 @@
 		uart at 80007000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x80007000 0x1000>;
-			interrupts = <0 26 0x4>;
+			interrupts = <0 26 IRQ_TYPE_LEVEL_HIGH>;
 
 			dmas = <&dma 11 0 0x2>, /* Logical - DevToMem */
 			       <&dma 11 0 0x0>; /* Logical - MemToDev */
@@ -633,7 +635,7 @@
 		sdi0_per1 at 80126000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80126000 0x1000>;
-			interrupts = <0 60 0x4>;
+			interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
 
 			dmas = <&dma 29 0 0x2>, /* Logical - DevToMem */
 			       <&dma 29 0 0x0>; /* Logical - MemToDev */
@@ -645,7 +647,7 @@
 		sdi1_per2 at 80118000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80118000 0x1000>;
-			interrupts = <0 50 0x4>;
+			interrupts = <0 50 IRQ_TYPE_LEVEL_HIGH>;
 
 			dmas = <&dma 32 0 0x2>, /* Logical - DevToMem */
 			       <&dma 32 0 0x0>; /* Logical - MemToDev */
@@ -657,7 +659,7 @@
 		sdi2_per3 at 80005000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80005000 0x1000>;
-			interrupts = <0 41 0x4>;
+			interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
 
 			dmas = <&dma 28 0 0x2>, /* Logical - DevToMem */
 			       <&dma 28 0 0x0>; /* Logical - MemToDev */
@@ -669,14 +671,14 @@
 		sdi3_per2 at 80119000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80119000 0x1000>;
-			interrupts = <0 59 0x4>;
+			interrupts = <0 59 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
 		sdi4_per2 at 80114000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80114000 0x1000>;
-			interrupts = <0 99 0x4>;
+			interrupts = <0 99 IRQ_TYPE_LEVEL_HIGH>;
 
 			dmas = <&dma 42 0 0x2>, /* Logical - DevToMem */
 			       <&dma 42 0 0x0>; /* Logical - MemToDev */
@@ -688,14 +690,14 @@
 		sdi5_per3 at 80008000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80008000 0x1000>;
-			interrupts = <0 100 0x4>;
+			interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
 		msp0: msp at 80123000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80123000 0x1000>;
-			interrupts = <0 31 0x4>;
+			interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
 			v-ape-supply = <&db8500_vape_reg>;
 			status = "disabled";
 		};
@@ -703,7 +705,7 @@
 		msp1: msp at 80124000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80124000 0x1000>;
-			interrupts = <0 62 0x4>;
+			interrupts = <0 62 IRQ_TYPE_LEVEL_HIGH>;
 			v-ape-supply = <&db8500_vape_reg>;
 			status = "disabled";
 		};
@@ -712,7 +714,7 @@
 		msp2: msp at 80117000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80117000 0x1000>;
-			interrupts = <0 98 0x4>;
+			interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
 			v-ape-supply = <&db8500_vape_reg>;
 			status = "disabled";
 		};
@@ -720,7 +722,7 @@
 		msp3: msp at 80125000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80125000 0x1000>;
-			interrupts = <0 62 0x4>;
+			interrupts = <0 62 IRQ_TYPE_LEVEL_HIGH>;
 			v-ape-supply = <&db8500_vape_reg>;
 			status = "disabled";
 		};
@@ -759,7 +761,7 @@
 		cryp at a03cb000 {
 			compatible = "stericsson,ux500-cryp";
 			reg = <0xa03cb000 0x1000>;
-			interrupts = <0 15 0x4>;
+			interrupts = <0 15 IRQ_TYPE_LEVEL_HIGH>;
 
 			v-ape-supply = <&db8500_vape_reg>;
 		};
diff --git a/arch/arm/boot/dts/href.dtsi b/arch/arm/boot/dts/href.dtsi
index 2c21626..0485519 100644
--- a/arch/arm/boot/dts/href.dtsi
+++ b/arch/arm/boot/dts/href.dtsi
@@ -9,6 +9,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "dbx5x0.dtsi"
 
 / {
@@ -45,14 +46,14 @@
 				compatible = "tc3589x";
 				reg = <0x42>;
 				interrupt-parent = <&gpio6>;
-				interrupts = <25 0x1>;
+				interrupts = <25 IRQ_TYPE_EDGE_RISING>;
 
 				interrupt-controller;
 				#interrupt-cells = <2>;
 
 				tc3589x_gpio: tc3589x_gpio {
 					compatible = "tc3589x-gpio";
-					interrupts = <0 0x1>;
+					interrupts = <0 IRQ_TYPE_EDGE_RISING>;
 
 					interrupt-controller;
 					#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index c0a34a6..06982dd 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -105,7 +105,7 @@
 			ethernet at 0 {
 				compatible = "smsc,lan9115";
 				reg = <0 0x10000>;
-				interrupts = <12 0x1>;
+				interrupts = <12 IRQ_TYPE_EDGE_RISING>;
 				interrupt-parent = <&gpio4>;
 				vdd33a-supply = <&en_3v3_reg>;
 				vddvario-supply = <&db8500_vape_reg>;
diff --git a/arch/arm/boot/dts/stuib.dtsi b/arch/arm/boot/dts/stuib.dtsi
index 0fdb259..b47b62a 100644
--- a/arch/arm/boot/dts/stuib.dtsi
+++ b/arch/arm/boot/dts/stuib.dtsi
@@ -9,13 +9,15 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/interrupt-controller/irq.h>
+
 / {
 	soc {
 		i2c at 80004000 {
 			stmpe1601: stmpe1601 at 40 {
 				compatible = "st,stmpe1601";
 				reg = <0x40>;
-				interrupts = <26 0x2>;
+				interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
 				interrupt-parent = <&gpio6>;
 				interrupt-controller;
 
-- 
1.7.11.3
