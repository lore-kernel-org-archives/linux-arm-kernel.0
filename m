From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 23 May 2014 15:51:14 +0800
Subject: [PATCH 11/22] ARM: sun6i: DT: Add PLL6 multiple outputs
In-Reply-To: <1400831485-28576-1-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
Message-ID: <1400831485-28576-12-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PLL6 on sun6i has multiple outputs, just like the other sunxi platforms.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 0f4ea49..d9643fa 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -95,11 +95,11 @@
 		};
 
 		pll6: clk at 01c20028 {
-			#clock-cells = <0>;
+			#clock-cells = <1>;
 			compatible = "allwinner,sun6i-a31-pll6-clk";
 			reg = <0x01c20028 0x4>;
 			clocks = <&osc24M>;
-			clock-output-names = "pll6";
+			clock-output-names = "pll6_other", "pll6";
 		};
 
 		cpu: cpu at 01c20050 {
@@ -129,7 +129,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun6i-a31-ahb1-mux-clk";
 			reg = <0x01c20054 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6>;
+			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
 			clock-output-names = "ahb1_mux";
 		};
 
@@ -184,7 +184,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-apb1-mux-clk";
 			reg = <0x01c20058 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
+			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
 			clock-output-names = "apb2_mux";
 		};
 
@@ -211,7 +211,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20088 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc0";
 		};
 
@@ -219,7 +219,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2008c 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc1";
 		};
 
@@ -227,7 +227,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20090 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc2";
 		};
 
@@ -235,7 +235,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20094 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc3";
 		};
 
@@ -243,7 +243,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a0 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "spi0";
 		};
 
@@ -251,7 +251,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a4 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "spi1";
 		};
 
@@ -259,7 +259,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a8 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "spi2";
 		};
 
@@ -267,7 +267,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200ac 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "spi3";
 		};
 
@@ -695,7 +695,7 @@
 			ar100: ar100_clk {
 				compatible = "allwinner,sun6i-a31-ar100-clk";
 				#clock-cells = <0>;
-				clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
+				clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
 				clock-output-names = "ar100";
 			};
 
-- 
2.0.0.rc2
