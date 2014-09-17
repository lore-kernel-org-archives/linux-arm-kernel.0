From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 17 Sep 2014 09:48:14 +0900
Subject: [PATCH v2 3/5] ARM: shmobile: r7s72100: sort dtsi file by address
In-Reply-To: <1410914896-14395-1-git-send-email-horms+renesas@verge.net.au>
References: <1410914896-14395-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1410914896-14395-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
[horms+renesas at verge.net.au: resolved conflict by updating
  to use SoC-specific compat string for mtu2]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2 [Simon Horman]
* Rebase
---
 arch/arm/boot/dts/r7s72100.dtsi | 202 ++++++++++++++++++++--------------------
 1 file changed, 101 insertions(+), 101 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 801a556..277e73c 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -52,16 +52,6 @@
 			clock-output-names = "usb_x1";
 		};
 
-		/* Special CPG clocks */
-		cpg_clocks: cpg_clocks at fcfe0000 {
-			#clock-cells = <1>;
-			compatible = "renesas,r7s72100-cpg-clocks",
-				     "renesas,rz-cpg-clocks";
-			reg = <0xfcfe0000 0x18>;
-			clocks = <&extal_clk>, <&usb_x1_clk>;
-			clock-output-names = "pll", "i", "g";
-		};
-
 		/* Fixed factor clocks */
 		b_clk: b_clk {
 			#clock-cells = <0>;
@@ -88,6 +78,16 @@
 			clock-output-names = "p0";
 		};
 
+		/* Special CPG clocks */
+		cpg_clocks: cpg_clocks at fcfe0000 {
+			#clock-cells = <1>;
+			compatible = "renesas,r7s72100-cpg-clocks",
+				     "renesas,rz-cpg-clocks";
+			reg = <0xfcfe0000 0x18>;
+			clocks = <&extal_clk>, <&usb_x1_clk>;
+			clock-output-names = "pll", "i", "g";
+		};
+
 		/* MSTP clocks */
 		mstp3_clks: mstp3_clks at fcfe0420 {
 			#clock-cells = <1>;
@@ -148,97 +148,6 @@
 		};
 	};
 
-	gic: interrupt-controller at e8201000 {
-		compatible = "arm,cortex-a9-gic";
-		#interrupt-cells = <3>;
-		#address-cells = <0>;
-		interrupt-controller;
-		reg = <0xe8201000 0x1000>,
-			<0xe8202000 0x1000>;
-	};
-
-	i2c0: i2c at fcfee000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
-		reg = <0xfcfee000 0x44>;
-		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 158 IRQ_TYPE_EDGE_RISING>,
-			     <0 159 IRQ_TYPE_EDGE_RISING>,
-			     <0 160 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 161 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 162 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 163 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 164 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R7S72100_CLK_I2C0>;
-		clock-frequency = <100000>;
-		status = "disabled";
-	};
-
-	i2c1: i2c at fcfee400 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
-		reg = <0xfcfee400 0x44>;
-		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 166 IRQ_TYPE_EDGE_RISING>,
-			     <0 167 IRQ_TYPE_EDGE_RISING>,
-			     <0 168 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 169 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 170 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 171 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 172 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R7S72100_CLK_I2C1>;
-		clock-frequency = <100000>;
-		status = "disabled";
-	};
-
-	i2c2: i2c at fcfee800 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
-		reg = <0xfcfee800 0x44>;
-		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 174 IRQ_TYPE_EDGE_RISING>,
-			     <0 175 IRQ_TYPE_EDGE_RISING>,
-			     <0 176 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 177 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 178 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 179 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 180 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R7S72100_CLK_I2C2>;
-		clock-frequency = <100000>;
-		status = "disabled";
-	};
-
-	i2c3: i2c at fcfeec00 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
-		reg = <0xfcfeec00 0x44>;
-		interrupts = <0 181 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 182 IRQ_TYPE_EDGE_RISING>,
-			     <0 183 IRQ_TYPE_EDGE_RISING>,
-			     <0 184 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 185 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 186 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 187 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 188 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R7S72100_CLK_I2C3>;
-		clock-frequency = <100000>;
-		status = "disabled";
-	};
-
-	mtu2: timer at fcff0000 {
-		compatible = "renesas,mtu2-r7s72100", "renesas,mtu2";
-		reg = <0xfcff0000 0x400>;
-		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "tgi0a";
-		clocks = <&mstp3_clks R7S72100_CLK_MTU2>;
-		clock-names = "fck";
-		status = "disabled";
-	};
-
 	scif0: serial at e8007000 {
 		compatible = "renesas,scif-r7s72100", "renesas,scif";
 		reg = <0xe8007000 64>;
@@ -404,4 +313,95 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	gic: interrupt-controller at e8201000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0xe8201000 0x1000>,
+			<0xe8202000 0x1000>;
+	};
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
+		clocks = <&mstp9_clks R7S72100_CLK_I2C0>;
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
+		clocks = <&mstp9_clks R7S72100_CLK_I2C1>;
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
+		clocks = <&mstp9_clks R7S72100_CLK_I2C2>;
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
+		clocks = <&mstp9_clks R7S72100_CLK_I2C3>;
+		clock-frequency = <100000>;
+		status = "disabled";
+	};
+
+	mtu2: timer at fcff0000 {
+		compatible = "renesas,mtu2-r7s72100", "renesas,mtu2";
+		reg = <0xfcff0000 0x400>;
+		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tgi0a";
+		clocks = <&mstp3_clks R7S72100_CLK_MTU2>;
+		clock-names = "fck";
+		status = "disabled";
+	};
 };
-- 
2.0.1
