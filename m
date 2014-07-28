From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 28 Jul 2014 00:49:44 -0300
Subject: [RFC 6/8] ARM: sunxi: Add PLL2 support
In-Reply-To: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
References: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1406519386-4902-7-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the PLL2 definition to the sun4i, sun5i and sun7i
device trees. PLL2 is used to clock audio devices.

Not-signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

Note that there is no handling of A10 rev A here, this should not go 
in as-is.

 arch/arm/boot/dts/sun4i-a10.dtsi  | 8 ++++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi | 8 ++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 8 ++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi  | 8 ++++++++
 4 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index faf41e3..7671e56 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -81,6 +81,14 @@
 			clock-output-names = "pll1";
 		};
 
+		pll2: clk at 01c20008 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-b-pll2-clk";
+			reg = <0x01c20008 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll2", "pll2x2", "pll2x4", "pll2x8";
+		};
+
 		pll4: clk at 01c20018 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-pll1-clk";
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 92b5d1c..75e9632 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -74,6 +74,14 @@
 			clock-output-names = "pll1";
 		};
 
+		pll2: clk at 01c20008 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-b-pll2-clk";
+			reg = <0x01c20008 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll2", "pll2x2", "pll2x4", "pll2x8";
+		};
+
 		pll4: clk at 01c20018 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-pll1-clk";
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index d8f02ee..61c8331 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -75,6 +75,14 @@
 			clock-output-names = "pll1";
 		};
 
+		pll2: clk at 01c20008 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-b-pll2-clk";
+			reg = <0x01c20008 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll2", "pll2x2", "pll2x4", "pll2x8";
+		};
+
 		pll4: clk at 01c20018 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-pll1-clk";
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index b1f3776..766ad81 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -91,6 +91,14 @@
 			clock-output-names = "pll1";
 		};
 
+		pll2: clk at 01c20008 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-a10-b-pll2-clk";
+			reg = <0x01c20008 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll2", "pll2x2", "pll2x4", "pll2x8";
+		};
+
 		pll4: clk at 01c20018 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun7i-a20-pll4-clk";
-- 
2.0.3
