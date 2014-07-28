From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 28 Jul 2014 00:49:46 -0300
Subject: [RFC 8/8] ARM: sun7i: Add mod1 clock nodes
In-Reply-To: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
References: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1406519386-4902-9-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds all the mod1 clocks available on A20 to its device
tree. This list was created by looking at the A20 user manual.

Not-signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

As mentioned on an earlier patch, note that this is untested, and I 
only added them to sun7i. It'd be great if actual users of these clocks 
could comment :)

 arch/arm/boot/dts/sun7i-a20.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 5d0265a..c57f7ad 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -335,6 +335,29 @@
 			clock-output-names = "ir1";
 		};
 
+		iis0_clk: clk at 01c200b8 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200b8 0x4>;
+			clocks = <&pll2 0>, <&pll2 1>, <&pll2 2>, <&pll2 3>;
+			clock-output-names = "iis0";
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
+			clocks = <&pll2 0>, <&pll2 1>, <&pll2 2>, <&pll2 3>;
+			clock-output-names = "spdif";
+		};
 		usb_clk: clk at 01c200cc {
 			#clock-cells = <1>;
 		        #reset-cells = <1>;
@@ -352,6 +375,22 @@
 			clock-output-names = "spi3";
 		};
 
+		iis1_clk: clk at 01c200d8 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200d8 0x4>;
+			clocks = <&pll2 0>, <&pll2 1>, <&pll2 2>, <&pll2 3>;
+			clock-output-names = "iis1";
+		};
+
+		iis2_clk: clk at 01c200dc {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200dc 0x4>;
+			clocks = <&pll2 0>, <&pll2 1>, <&pll2 2>, <&pll2 3>;
+			clock-output-names = "iis2";
+		};
+
 		codec_clk: clk at 01c20140 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-codec-clk";
-- 
2.0.3
