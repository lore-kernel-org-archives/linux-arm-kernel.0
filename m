From: vishnupatekar0510@gmail.com (vishnupatekar)
Date: Sun,  7 Dec 2014 04:45:19 +0530
Subject: [PATCHv2 3/3] ARM:dts:sunxi:ps2 dt nodes for A10/A20 PS2 controller.
In-Reply-To: <1417907719-26775-1-git-send-email-VishnuPatekar0510@gmail.com>
References: <1417907719-26775-1-git-send-email-VishnuPatekar0510@gmail.com>
Message-ID: <1417907719-26775-4-git-send-email-VishnuPatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Added ps2 nodes in lime2 board dts. By default ps20 and ps21 nodes are
 commented as ps20 pins conflict with HDMI connector
 on Lime2 Board.

Signed-off-by: vishnupatekar <VishnuPatekar0510@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi                |   27 +++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts |   13 ++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                |   29 +++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 5e2ec2d..4726e8d 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -615,6 +615,19 @@
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
@@ -781,5 +794,19 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+		ps20: ps2 at 0x01c2a000 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a000 0x400>;
+			interrupts = <0 62 4>;
+			clocks = <&apb1_gates 6>;
+			status = "disabled";
+		};
+		ps21: ps2 at 0x01c2a400 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a400 0x400>;
+			interrupts = <0 63 4>;
+			clocks = <&apb1_gates 7>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index ed364d5..5624e63 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -112,6 +112,19 @@
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
+		/* PS2 0 and PS2 1 are disabled by default
+		To enable PS2 0 and PS2 1 uncomment below ps20 and ps21 nodes
+		Please note that ps20 pins conflict with HDMI on Lime2 Board*/
+		/*ps20: ps2 at 0x01c2a000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&ps2_0_pins>;
+			status = "okay";
+		};
+		ps21: ps2 at 0x01c2a400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&ps2_1_pins>;
+			status = "okay";
+		};*/
 
 		i2c0: i2c at 01c2ac00 {
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 8605f2b..96fe37d 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
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
@@ -1079,5 +1092,21 @@
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
+
 	};
 };
-- 
1.7.9.5
