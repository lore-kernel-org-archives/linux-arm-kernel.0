From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  3 Feb 2014 09:51:44 +0800
Subject: [PATCH v4 8/8] ARM: dts: sun7i: rename clock node names to clk@N
In-Reply-To: <1391392304-4660-1-git-send-email-wens@csie.org>
References: <1391392304-4660-1-git-send-email-wens@csie.org>
Message-ID: <1391392304-4660-9-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree naming conventions state that node names should match
node function. Change fully functioning clock nodes to match and
add clock-output-names to all sunxi clock nodes.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 119f066..1595e9a 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -46,11 +46,12 @@
 		#size-cells = <1>;
 		ranges;
 
-		osc24M: osc24M at 01c20050 {
+		osc24M: clk at 01c20050 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-osc-clk";
 			reg = <0x01c20050 0x4>;
 			clock-frequency = <24000000>;
+			clock-output-names = "osc24M";
 		};
 
 		osc32k: clk at 0 {
@@ -60,21 +61,23 @@
 			clock-output-names = "osc32k";
 		};
 
-		pll1: pll1 at 01c20000 {
+		pll1: clk at 01c20000 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-pll1-clk";
 			reg = <0x01c20000 0x4>;
 			clocks = <&osc24M>;
+			clock-output-names = "pll1";
 		};
 
-		pll4: pll4 at 01c20018 {
+		pll4: clk at 01c20018 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-pll1-clk";
 			reg = <0x01c20018 0x4>;
 			clocks = <&osc24M>;
+			clock-output-names = "pll4";
 		};
 
-		pll5: pll5 at 01c20020 {
+		pll5: clk at 01c20020 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-pll5-clk";
 			reg = <0x01c20020 0x4>;
@@ -82,7 +85,7 @@
 			clock-output-names = "pll5_ddr", "pll5_other";
 		};
 
-		pll6: pll6 at 01c20028 {
+		pll6: clk at 01c20028 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-pll6-clk";
 			reg = <0x01c20028 0x4>;
@@ -95,6 +98,7 @@
 			compatible = "allwinner,sun4i-cpu-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&pll6 1>;
+			clock-output-names = "cpu";
 		};
 
 		axi: axi at 01c20054 {
@@ -102,6 +106,7 @@
 			compatible = "allwinner,sun4i-axi-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&cpu>;
+			clock-output-names = "axi";
 		};
 
 		ahb: ahb at 01c20054 {
@@ -109,9 +114,10 @@
 			compatible = "allwinner,sun4i-ahb-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&axi>;
+			clock-output-names = "ahb";
 		};
 
-		ahb_gates: ahb_gates at 01c20060 {
+		ahb_gates: clk at 01c20060 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun7i-a20-ahb-gates-clk";
 			reg = <0x01c20060 0x8>;
@@ -136,9 +142,10 @@
 			compatible = "allwinner,sun4i-apb0-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&ahb>;
+			clock-output-names = "apb0";
 		};
 
-		apb0_gates: apb0_gates at 01c20068 {
+		apb0_gates: clk at 01c20068 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun7i-a20-apb0-gates-clk";
 			reg = <0x01c20068 0x4>;
@@ -154,6 +161,7 @@
 			compatible = "allwinner,sun4i-apb1-mux-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
+			clock-output-names = "apb1_mux";
 		};
 
 		apb1: apb1 at 01c20058 {
@@ -161,9 +169,10 @@
 			compatible = "allwinner,sun4i-apb1-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&apb1_mux>;
+			clock-output-names = "apb1";
 		};
 
-		apb1_gates: apb1_gates at 01c2006c {
+		apb1_gates: clk at 01c2006c {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun7i-a20-apb1-gates-clk";
 			reg = <0x01c2006c 0x4>;
-- 
1.9.rc1
