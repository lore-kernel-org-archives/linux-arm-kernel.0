From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  3 Feb 2014 09:51:43 +0800
Subject: [PATCH v4 7/8] ARM: dts: sun6i: rename clock node names to clk@N
In-Reply-To: <1391392304-4660-1-git-send-email-wens@csie.org>
References: <1391392304-4660-1-git-send-email-wens@csie.org>
Message-ID: <1391392304-4660-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree naming conventions state that node names should match
node function. Change fully functioning clock nodes to match and
add clock-output-names to all sunxi clock nodes.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 5256ad9..dbc2d29 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -60,17 +60,19 @@
 			clock-frequency = <24000000>;
 		};
 
-		osc32k: osc32k {
+		osc32k: clk at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
+			clock-output-names = "osc32k";
 		};
 
-		pll1: pll1 at 01c20000 {
+		pll1: clk at 01c20000 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun6i-a31-pll1-clk";
 			reg = <0x01c20000 0x4>;
 			clocks = <&osc24M>;
+			clock-output-names = "pll1";
 		};
 
 		/*
@@ -97,6 +99,7 @@
 			 * Allwinner.
 			 */
 			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&pll1>;
+			clock-output-names = "cpu";
 		};
 
 		axi: axi at 01c20050 {
@@ -104,6 +107,7 @@
 			compatible = "allwinner,sun4i-axi-clk";
 			reg = <0x01c20050 0x4>;
 			clocks = <&cpu>;
+			clock-output-names = "axi";
 		};
 
 		ahb1_mux: ahb1_mux at 01c20054 {
@@ -111,6 +115,7 @@
 			compatible = "allwinner,sun6i-a31-ahb1-mux-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6>;
+			clock-output-names = "ahb1_mux";
 		};
 
 		ahb1: ahb1 at 01c20054 {
@@ -118,9 +123,10 @@
 			compatible = "allwinner,sun4i-ahb-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&ahb1_mux>;
+			clock-output-names = "ahb1";
 		};
 
-		ahb1_gates: ahb1_gates at 01c20060 {
+		ahb1_gates: clk at 01c20060 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun6i-a31-ahb1-gates-clk";
 			reg = <0x01c20060 0x8>;
@@ -146,9 +152,10 @@
 			compatible = "allwinner,sun4i-apb0-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&ahb1>;
+			clock-output-names = "apb1";
 		};
 
-		apb1_gates: apb1_gates at 01c20060 {
+		apb1_gates: clk at 01c20068 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun6i-a31-apb1-gates-clk";
 			reg = <0x01c20068 0x4>;
@@ -163,6 +170,7 @@
 			compatible = "allwinner,sun4i-apb1-mux-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
+			clock-output-names = "apb2_mux";
 		};
 
 		apb2: apb2 at 01c20058 {
@@ -170,9 +178,10 @@
 			compatible = "allwinner,sun6i-a31-apb2-div-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&apb2_mux>;
+			clock-output-names = "apb2";
 		};
 
-		apb2_gates: apb2_gates at 01c2006c {
+		apb2_gates: clk at 01c2006c {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun6i-a31-apb2-gates-clk";
 			reg = <0x01c2006c 0x4>;
-- 
1.9.rc1
