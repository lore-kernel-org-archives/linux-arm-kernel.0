From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  1 Jun 2016 19:54:29 +0200
Subject: [PATCH 3/4] ARM: sun7i: Add mod1 clock nodes
In-Reply-To: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
References: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
Message-ID: <20160601175430.11625-4-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emilio L?pez <emilio@elopez.com.ar>

This commit adds all the mod1 clocks available on A20 to its device
tree. This list was created by looking at the A20 user manual.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 48 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index febdf4c72fb0..603fda5b7f94 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -366,9 +366,9 @@
 					<5>, <6>, <7>,
 					<8>, <10>;
 			clock-output-names = "apb0_codec", "apb0_spdif",
-				"apb0_ac97", "apb0_iis0", "apb0_iis1",
+				"apb0_ac97", "apb0_i2s0", "apb0_i2s1",
 				"apb0_pio", "apb0_ir0", "apb0_ir1",
-				"apb0_iis2", "apb0_keypad";
+				"apb0_i2s2", "apb0_keypad";
 		};
 
 		apb1: clk at 01c20058 {
@@ -518,6 +518,28 @@
 			clock-output-names = "ir1";
 		};
 
+		i2s0_clk: clk at 01c200b8 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200b8 0x4>;
+			clocks = <&pll2 SUN4I_A10_PLL2_8X>,
+				 <&pll2 SUN4I_A10_PLL2_4X>,
+				 <&pll2 SUN4I_A10_PLL2_2X>,
+				 <&pll2 SUN4I_A10_PLL2_1X>;
+			clock-output-names = "i2s0";
+		};
+
+		ac97_clk: clk at 01c200bc {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200bc 0x4>;
+			clocks = <&pll2 SUN4I_A10_PLL2_8X>,
+				 <&pll2 SUN4I_A10_PLL2_4X>,
+				 <&pll2 SUN4I_A10_PLL2_2X>,
+				 <&pll2 SUN4I_A10_PLL2_1X>;
+			clock-output-names = "ac97";
+		};
+
 		spdif_clk: clk at 01c200c0 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod1-clk";
@@ -555,6 +577,28 @@
 			clock-output-names = "spi3";
 		};
 
+		i2s1_clk: clk at 01c200d8 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200d8 0x4>;
+			clocks = <&pll2 SUN4I_A10_PLL2_8X>,
+				 <&pll2 SUN4I_A10_PLL2_4X>,
+				 <&pll2 SUN4I_A10_PLL2_2X>,
+				 <&pll2 SUN4I_A10_PLL2_1X>;
+			clock-output-names = "i2s1";
+		};
+
+		i2s2_clk: clk at 01c200dc {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200dc 0x4>;
+			clocks = <&pll2 SUN4I_A10_PLL2_8X>,
+				 <&pll2 SUN4I_A10_PLL2_4X>,
+				 <&pll2 SUN4I_A10_PLL2_2X>,
+				 <&pll2 SUN4I_A10_PLL2_1X>;
+			clock-output-names = "i2s2";
+		};
+
 		dram_gates: clk at 01c20100 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-dram-gates-clk";
-- 
2.8.3
