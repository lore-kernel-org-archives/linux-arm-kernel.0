From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 28 Jul 2014 00:49:45 -0300
Subject: [RFC 7/8] ARM: sunxi: Add codec clock support
In-Reply-To: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
References: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1406519386-4902-8-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the codec clock definition to the sun4i, sun5i and
sun7i device trees. The codec clock is used in the analog codec block.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 8 ++++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi | 8 ++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 8 ++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi  | 8 ++++++++
 4 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 7671e56..6b33eb1 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -339,6 +339,14 @@
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi3";
 		};
+
+		codec_clk: clk at 01c20140 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-codec-clk";
+			reg = <0x01c20140 0x4>;
+			clocks = <&pll2 0>;
+			clock-output-names = "codec";
+		};
 	};
 
 	soc at 01c00000 {
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 75e9632..c0abe24 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -293,6 +293,14 @@
 			clock-output-names = "usb_ohci0", "usb_phy";
 		};
 
+		codec_clk: clk at 01c20140 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-codec-clk";
+			reg = <0x01c20140 0x4>;
+			clocks = <&pll2 0>;
+			clock-output-names = "codec";
+		};
+
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 61c8331..05ce717 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -291,6 +291,14 @@
 			clock-output-names = "usb_ohci0", "usb_phy";
 		};
 
+		codec_clk: clk at 01c20140 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-codec-clk";
+			reg = <0x01c20140 0x4>;
+			clocks = <&pll2 0>;
+			clock-output-names = "codec";
+		};
+
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 766ad81..5d0265a 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -352,6 +352,14 @@
 			clock-output-names = "spi3";
 		};
 
+		codec_clk: clk at 01c20140 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-codec-clk";
+			reg = <0x01c20140 0x4>;
+			clocks = <&pll2 0>;
+			clock-output-names = "codec";
+		};
+
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
-- 
2.0.3
