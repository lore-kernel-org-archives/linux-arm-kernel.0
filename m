From: codekipper@gmail.com (codekipper at gmail.com)
Date: Tue, 28 Apr 2015 20:04:47 +0200
Subject: [PATCH] ARM: sunxi: dts: split IR pins for A10 and A20
Message-ID: <1430244287-29309-1-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Currently none of the target boards nor the driver supports
IR TX. However this pin is used in a few instances as a GPIO.
Split the pin ctrl descriptions so that only the IR RX is
configured to be used.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 18 ++++++++++++++++--
 arch/arm/boot/dts/sun7i-a20.dtsi | 18 ++++++++++++++++--
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 1d7fd68..50df9b7 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -798,14 +798,28 @@
 			};
 
 			ir0_pins_a: ir0 at 0 {
-				allwinner,pins = "PB3","PB4";
+				allwinner,pins = "PB4";
+				allwinner,function = "ir0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			ir0_pins_b: ir0 at 1 {
+				allwinner,pins = "PB3";
 				allwinner,function = "ir0";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			ir1_pins_a: ir1 at 0 {
-				allwinner,pins = "PB22","PB23";
+				allwinner,pins = "PB23";
+				allwinner,function = "ir1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			ir1_pins_b: ir1 at 1 {
+				allwinner,pins = "PB22";
 				allwinner,function = "ir1";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 4163ade..6168a9f 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1001,14 +1001,28 @@
 			};
 
 			ir0_pins_a: ir0 at 0 {
-				    allwinner,pins = "PB3","PB4";
+				    allwinner,pins = "PB4";
+				    allwinner,function = "ir0";
+				    allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				    allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			ir0_pins_b: ir0 at 1 {
+				    allwinner,pins = "PB3";
 				    allwinner,function = "ir0";
 				    allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				    allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			ir1_pins_a: ir1 at 0 {
-				    allwinner,pins = "PB22","PB23";
+				    allwinner,pins = "PB23";
+				    allwinner,function = "ir1";
+				    allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				    allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			ir1_pins_b: ir1 at 1 {
+				    allwinner,pins = "PB22";
 				    allwinner,function = "ir1";
 				    allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				    allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-- 
2.3.6
