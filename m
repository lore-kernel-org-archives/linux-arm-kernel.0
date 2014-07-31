From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Thu, 31 Jul 2014 18:28:10 -0300
Subject: [PATCH 7/9] ARM: sunxi: dt: Add PLL2 support
In-Reply-To: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
References: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1406842092-25207-8-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the PLL2 definition to the sun4i, sun5i and sun7i
device trees. PLL2 is used to clock audio devices.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

Changes from RFC:
 * A10 rev A is now supported via the quirk code

 arch/arm/boot/dts/sun4i-a10.dtsi  | 8 ++++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi | 8 ++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 8 ++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi  | 8 ++++++++
 4 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 459cb63..c4d4c73 100644
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
index 24b0ad3..f35aa4d 100644
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
index bf86e65..38b2d77 100644
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
index 4011628..7a6a18c 100644
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
