From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 23 Nov 2014 12:33:22 +0800
Subject: [PATCH v4 3/6] ARM: sun6i: DT: Add PLL6 multiple outputs
In-Reply-To: <1416717205-15406-1-git-send-email-wens@csie.org>
References: <1416717205-15406-1-git-send-email-wens@csie.org>
Message-ID: <1416717205-15406-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PLL6 on sun6i has multiple outputs, just like the other sunxi platforms.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index a674b0f..f1519a8 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -132,11 +132,11 @@
 		};
 
 		pll6: clk at 01c20028 {
-			#clock-cells = <0>;
+			#clock-cells = <1>;
 			compatible = "allwinner,sun6i-a31-pll6-clk";
 			reg = <0x01c20028 0x4>;
 			clocks = <&osc24M>;
-			clock-output-names = "pll6";
+			clock-output-names = "pll6", "pll6x2";
 		};
 
 		cpu: cpu at 01c20050 {
@@ -166,7 +166,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun6i-a31-ahb1-mux-clk";
 			reg = <0x01c20054 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6>;
+			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
 			clock-output-names = "ahb1_mux";
 		};
 
@@ -221,7 +221,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-apb1-clk";
 			reg = <0x01c20058 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
+			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
 			clock-output-names = "apb2";
 		};
 
@@ -240,7 +240,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20088 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc0";
 		};
 
@@ -248,7 +248,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2008c 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc1";
 		};
 
@@ -256,7 +256,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20090 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc2";
 		};
 
@@ -264,7 +264,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20094 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "mmc3";
 		};
 
@@ -272,7 +272,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a0 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "spi0";
 		};
 
@@ -280,7 +280,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a4 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "spi1";
 		};
 
@@ -288,7 +288,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a8 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "spi2";
 		};
 
@@ -296,7 +296,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200ac 0x4>;
-			clocks = <&osc24M>, <&pll6>;
+			clocks = <&osc24M>, <&pll6 0>;
 			clock-output-names = "spi3";
 		};
 
@@ -356,7 +356,7 @@
 
 			/* DMA controller requires AHB1 clocked from PLL6 */
 			assigned-clocks = <&ahb1_mux>;
-			assigned-clock-parents = <&pll6>;
+			assigned-clock-parents = <&pll6 0>;
 		};
 
 		mmc0: mmc at 01c0f000 {
@@ -836,7 +836,7 @@
 			ar100: ar100_clk {
 				compatible = "allwinner,sun6i-a31-ar100-clk";
 				#clock-cells = <0>;
-				clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
+				clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
 				clock-output-names = "ar100";
 			};
 
-- 
2.1.3
