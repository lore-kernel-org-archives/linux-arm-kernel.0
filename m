From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Thu, 31 Jul 2014 18:28:12 -0300
Subject: [PATCH 9/9] ARM: sun7i: dt: Add mod1 clock nodes
In-Reply-To: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
References: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1406842092-25207-10-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds all the mod1 clocks available on A20 to its device
tree. This list was created by looking at the A20 user manual.

Not-signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

Changes from RFC:
 * iis -> i2s
 * Reordered parent clocks as reported by Chen-Yu

 arch/arm/boot/dts/sun7i-a20.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index c38ac5e..a6db15d 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -335,6 +335,30 @@
 			clock-output-names = "ir1";
 		};
 
+		i2s0_clk: clk at 01c200b8 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200b8 0x4>;
+			clocks = <&pll2 3>, <&pll2 2>, <&pll2 1>, <&pll2 0>;
+			clock-output-names = "i2s0";
+		};
+
+		ac97_clk: clk at 01c200bc {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200bc 0x4>;
+			clocks = <&pll2 3>, <&pll2 2>, <&pll2 1>, <&pll2 0>;
+			clock-output-names = "ac97";
+		};
+
+		spdif_clk: clk at 01c200c0 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200c0 0x4>;
+			clocks = <&pll2 3>, <&pll2 2>, <&pll2 1>, <&pll2 0>;
+			clock-output-names = "spdif";
+		};
+
 		usb_clk: clk at 01c200cc {
 			#clock-cells = <1>;
 		        #reset-cells = <1>;
@@ -352,6 +376,22 @@
 			clock-output-names = "spi3";
 		};
 
+		i2s1_clk: clk at 01c200d8 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200d8 0x4>;
+			clocks = <&pll2 3>, <&pll2 2>, <&pll2 1>, <&pll2 0>;
+			clock-output-names = "i2s1";
+		};
+
+		i2s2_clk: clk at 01c200dc {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200dc 0x4>;
+			clocks = <&pll2 3>, <&pll2 2>, <&pll2 1>, <&pll2 0>;
+			clock-output-names = "i2s2";
+		};
+
 		codec_clk: clk at 01c20140 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-codec-clk";
-- 
2.0.3
