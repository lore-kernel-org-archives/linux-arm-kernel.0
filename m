From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 May 2015 22:54:06 +0200
Subject: [PATCH v2 7/7] ARM: sun7i: Add mod1 clock nodes
In-Reply-To: <1432241646-9511-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1432241646-9511-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1432241646-9511-8-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emilio L?pez <emilio@elopez.com.ar>

This commit adds all the mod1 clocks available on A20 to its device
tree. This list was created by looking at the A20 user manual.

Not-signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index b5ecfa5fa0eb..9b85e9a9ca61 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -452,6 +452,39 @@
 			clock-output-names = "ir1";
 		};
 
+		iis0_clk: clk at 01c200b8 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200b8 0x4>;
+			clocks = <&pll2 SUN4I_A10_PLL2_1X>,
+				 <&pll2 SUN4I_A10_PLL2_2X>,
+				 <&pll2 SUN4I_A10_PLL2_4X>,
+				 <&pll2 SUN4I_A10_PLL2_8X>;
+			clock-output-names = "iis0";
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
+		spdif_clk: clk at 01c200c0 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200c0 0x4>;
+			clocks = <&pll2 SUN4I_A10_PLL2_8X>,
+				 <&pll2 SUN4I_A10_PLL2_4X>,
+				 <&pll2 SUN4I_A10_PLL2_2X>,
+				 <&pll2 SUN4I_A10_PLL2_1X>;
+			clock-output-names = "spdif";
+		};
+
 		usb_clk: clk at 01c200cc {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -470,6 +503,28 @@
 			clock-output-names = "spi3";
 		};
 
+		iis1_clk: clk at 01c200d8 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200d8 0x4>;
+			clocks = <&pll2 SUN4I_A10_PLL2_1X>,
+				 <&pll2 SUN4I_A10_PLL2_2X>,
+				 <&pll2 SUN4I_A10_PLL2_4X>,
+				 <&pll2 SUN4I_A10_PLL2_8X>;
+			clock-output-names = "iis1";
+		};
+
+		iis2_clk: clk at 01c200dc {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200dc 0x4>;
+			clocks = <&pll2 SUN4I_A10_PLL2_1X>,
+				 <&pll2 SUN4I_A10_PLL2_2X>,
+				 <&pll2 SUN4I_A10_PLL2_4X>,
+				 <&pll2 SUN4I_A10_PLL2_8X>;
+			clock-output-names = "iis2";
+		};
+
 		codec_clk: clk at 01c20140 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-codec-clk";
-- 
2.4.1
