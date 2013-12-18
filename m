From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Tue, 17 Dec 2013 21:44:55 -0300
Subject: [PATCH v2 03/11] ARM: sunxi: add PLL4 support
In-Reply-To: <1387327503-15651-1-git-send-email-emilio@elopez.com.ar>
References: <1387327503-15651-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1387327503-15651-4-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the PLL4 definition to the sun4i, sun5i and sun7i
device trees. PLL4 is compatible with PLL1.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 7 +++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi | 7 +++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 7 +++++++
 arch/arm/boot/dts/sun7i-a20.dtsi  | 7 +++++++
 4 files changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 5b158d2..3833c14 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -70,6 +70,13 @@
 			clocks = <&osc24M>;
 		};
 
+		pll4: pll4 at 01c20018 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-pll1-clk";
+			reg = <0x01c20018 0x4>;
+			clocks = <&osc24M>;
+		};
+
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index b4764be..3252aa8 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -67,6 +67,13 @@
 			clocks = <&osc24M>;
 		};
 
+		pll4: pll4 at 01c20018 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-pll1-clk";
+			reg = <0x01c20018 0x4>;
+			clocks = <&osc24M>;
+		};
+
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index ce8ef2a..8c4a9c3 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -67,6 +67,13 @@
 			clocks = <&osc24M>;
 		};
 
+		pll4: pll4 at 01c20018 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-pll1-clk";
+			reg = <0x01c20018 0x4>;
+			clocks = <&osc24M>;
+		};
+
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index d62d693..2b2d3847 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -66,6 +66,13 @@
 			clocks = <&osc24M>;
 		};
 
+		pll4: pll4 at 01c20018 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-pll1-clk";
+			reg = <0x01c20018 0x4>;
+			clocks = <&osc24M>;
+		};
+
 		/*
 		 * This is a dummy clock, to be used as placeholder on
 		 * other mux clocks when a specific parent clock is not
-- 
1.8.5.1
