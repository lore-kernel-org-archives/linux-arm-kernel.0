From: plaes@plaes.org (Priit Laes)
Date: Thu,  5 May 2016 20:39:04 +0300
Subject: [PATCH v2] ARM: sun7i: dt: Add pll3 and pll7 clocks
Message-ID: <1462469944-27915-1-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable pll3 and pll7 clocks that are needed by display clocks.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
v2:
 - Fix typos in clocks property (spotted by Alexander Syring)
 - Fix indentation (spotted by Maxime Ripard)

 arch/arm/boot/dts/sun7i-a20.dtsi | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index bf5d056..febdf4c 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -187,6 +187,15 @@
 			clock-output-names = "osc24M";
 		};
 
+		osc3M: osc3M_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clock-div = <8>;
+			clock-mult = <1>;
+			clocks = <&osc24M>;
+			clock-output-names = "osc3M";
+		};
+
 		osc32k: clk at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
@@ -211,6 +220,22 @@
 					     "pll2-4x", "pll2-8x";
 		};
 
+		pll3: clk at 01c20010 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-pll3-clk";
+			reg = <0x01c20010 0x4>;
+			clocks = <&osc3M>;
+			clock-output-names = "pll3";
+		};
+
+		pll3x2: pll3x2_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clock-div = <1>;
+			clock-mult = <2>;
+			clock-output-names = "pll3-2x";
+		};
+
 		pll4: clk at 01c20018 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun7i-a20-pll4-clk";
@@ -236,6 +261,22 @@
 					     "pll6_div_4";
 		};
 
+		pll7: clk at 01c20030 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-pll3-clk";
+			reg = <0x01c20030 0x4>;
+			clocks = <&osc3M>;
+			clock-output-names = "pll7";
+		};
+
+		pll7x2: pll7x2_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clock-div = <1>;
+			clock-mult = <2>;
+			clock-output-names = "pll7-2x";
+		};
+
 		pll8: clk at 01c20040 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun7i-a20-pll4-clk";
-- 
2.8.2
