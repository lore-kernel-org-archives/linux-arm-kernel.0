From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 17 Dec 2013 22:44:36 +0100
Subject: [PATCH 3/5] arm: shmobile: r7s72100: add nodes for i2c controllers to
 dtsi
In-Reply-To: <1387316678-10174-1-git-send-email-wsa@the-dreams.de>
References: <1387316678-10174-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1387316678-10174-4-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

I decided to put the pinmuxing into the dtsi file since there is only
one pinmux posiibility which one probably wants to have when using the
bus.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Acked-by: Magnus Damm <damm@opensource.se>
---
 arch/arm/boot/dts/r7s72100.dtsi | 102 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index d396b38..ff0bd6b 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -8,6 +8,8 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/interrupt-controller/irq.h>
+
 / {
 	compatible = "renesas,r7s72100";
 	interrupt-parent = <&gic>;
@@ -15,6 +17,10 @@
 	#size-cells = <1>;
 
 	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
 		gpio0 = &port0;
 		gpio1 = &port1;
 		gpio2 = &port2;
@@ -58,6 +64,26 @@
 			  <0xfcfe7b40 0x04>, /* JPMC */
 			  <0xfcfe7b90 0x04>, /* JPMCSR */
 			  <0xfcfe7f00 0x04>; /* JPIBC */
+
+		riic0_pins: i2c0 {
+			renesas,groups = "riic0_scl_p1_0", "riic0_sda_p1_1";
+			renesas,function = "riic0";
+		};
+
+		riic1_pins: i2c1 {
+			renesas,groups = "riic1_scl_p1_2", "riic1_sda_p1_3";
+			renesas,function = "riic1";
+		};
+
+		riic2_pins: i2c2 {
+			renesas,groups = "riic2_scl_p1_4", "riic2_sda_p1_5";
+			renesas,function = "riic2";
+		};
+
+		riic3_pins: i2c3 {
+			renesas,groups = "riic3_scl_p1_6", "riic3_sda_p1_7";
+			renesas,function = "riic3";
+		};
 	};
 
 	port0: gpio at fcfe3100 {
@@ -187,4 +213,80 @@
 		gpio-controller;
 		gpio-ranges = <&pfc 0 192 2>;
 	};
+
+	i2c0: i2c at fcfee000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
+		reg = <0xfcfee000 0x44>;
+		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 158 IRQ_TYPE_EDGE_RISING>,
+			     <0 159 IRQ_TYPE_EDGE_RISING>,
+			     <0 160 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 161 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 162 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 163 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 164 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&riic0_pins>;
+		pinctrl-names = "default";
+		clock-frequency = <100000>;
+		status = "disabled";
+	};
+
+	i2c1: i2c at fcfee400 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
+		reg = <0xfcfee400 0x44>;
+		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 166 IRQ_TYPE_EDGE_RISING>,
+			     <0 167 IRQ_TYPE_EDGE_RISING>,
+			     <0 168 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 169 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 171 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 172 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&riic1_pins>;
+		pinctrl-names = "default";
+		clock-frequency = <100000>;
+		status = "disabled";
+	};
+
+	i2c2: i2c at fcfee800 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
+		reg = <0xfcfee800 0x44>;
+		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 174 IRQ_TYPE_EDGE_RISING>,
+			     <0 175 IRQ_TYPE_EDGE_RISING>,
+			     <0 176 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 177 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 178 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 179 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 180 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&riic2_pins>;
+		pinctrl-names = "default";
+		clock-frequency = <100000>;
+		status = "disabled";
+	};
+
+	i2c3: i2c at fcfeec00 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
+		reg = <0xfcfeec00 0x44>;
+		interrupts = <0 181 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 182 IRQ_TYPE_EDGE_RISING>,
+			     <0 183 IRQ_TYPE_EDGE_RISING>,
+			     <0 184 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 185 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 186 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 187 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 188 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&riic3_pins>;
+		pinctrl-names = "default";
+		clock-frequency = <100000>;
+		status = "disabled";
+	};
 };
-- 
1.8.4.2
