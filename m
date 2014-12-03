From: vishnupatekar0510@gmail.com (vishnupatekar)
Date: Thu,  4 Dec 2014 04:36:03 +0530
Subject: [PATCH 3/3] ARM:dts:sun7i:ps2 added nodes for Sun7i A20 PS2
 controller. added ps2 nodes in lime2 board dts.
Message-ID: <1417647963-28077-1-git-send-email-VishnuPatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts |   10 ++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                |   30 ++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index ed364d5..374897b 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -112,6 +112,16 @@
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
+		ps20: ps2 at 0x01c2a000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&ps2_0_pins>;
+			status = "okay";
+		};
+		ps21: ps2 at 0x01c2a400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&ps2_1_pins>;
+			status = "okay";
+		};
 
 		i2c0: i2c at 01c2ac00 {
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 8605f2b..c77635d 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -357,7 +357,7 @@
 
 		usb_clk: clk at 01c200cc {
 			#clock-cells = <1>;
-		        #reset-cells = <1>;
+			#reset-cells = <1>;
 			compatible = "allwinner,sun4i-a10-usb-clk";
 			reg = <0x01c200cc 0x4>;
 			clocks = <&pll6 1>;
@@ -852,6 +852,19 @@
 				    allwinner,drive = <0>;
 				    allwinner,pull = <0>;
 			};
+			ps2_0_pins: ps2_0 at 0 {
+				    allwinner,pins = "PI20","PI21";
+				    allwinner,function = "ps2";
+				    allwinner,drive = <0>;
+				    allwinner,pull = <0>;
+			};
+			ps2_1_pins: ps2_1 at 0 {
+				    allwinner,pins = "PH12","PH13";
+				    allwinner,function = "ps2";
+				    allwinner,drive = <0>;
+				    allwinner,pull = <0>;
+			};
+
 		};
 
 		timer at 01c20c00 {
@@ -1079,5 +1092,20 @@
 			#interrupt-cells = <3>;
 			interrupts = <1 9 0xf04>;
 		};
+		ps20: ps2 at 0x01c2a000 {
+			compatible = "allwinner,sun7i-a20-ps2";
+			reg = <0x01c2a000 0x400>;
+			interrupts = <0 62 4>;
+			clocks = <&apb1_gates 6>;
+			status = "disabled";
+		};
+		ps21: ps2 at 0x01c2a400 {
+			compatible = "allwinner,sun7i-a20-ps2";
+			reg = <0x01c2a400 0x400>;
+			interrupts = <0 63 4>;
+			clocks = <&apb1_gates 7>;
+			status = "disabled";
+		};
+
 	};
 };
-- 
1.7.9.5
