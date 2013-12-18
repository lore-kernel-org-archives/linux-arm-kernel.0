From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Tue, 17 Dec 2013 21:44:58 -0300
Subject: [PATCH v2 06/11] ARM: sunxi: add PLL5 and PLL6 support
In-Reply-To: <1387327503-15651-1-git-send-email-emilio@elopez.com.ar>
References: <1387327503-15651-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1387327503-15651-7-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds PLL5 and PLL6 nodes to the sun4i, sun5i and sun7i
device trees.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 19 +++++++++++++++++--
 arch/arm/boot/dts/sun5i-a10s.dtsi | 19 +++++++++++++++++--
 arch/arm/boot/dts/sun5i-a13.dtsi  | 19 +++++++++++++++++--
 arch/arm/boot/dts/sun7i-a20.dtsi  | 28 ++++++++++++++++------------
 4 files changed, 67 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 3833c14..ebacb5d 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -77,6 +77,22 @@
 			clocks = <&osc24M>;
 		};
 
+		pll5: pll5 at 01c20020 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-pll5-clk";
+			reg = <0x01c20020 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll5_ddr", "pll5_other";
+		};
+
+		pll6: pll6 at 01c20028 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-pll6-clk";
+			reg = <0x01c20028 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll6_sata", "pll6_other", "pll6";
+		};
+
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
@@ -142,12 +158,11 @@
 				"apb0_ir1", "apb0_keypad";
 		};
 
-		/* dummy is pll62 */
 		apb1_mux: apb1_mux at 01c20058 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-apb1-mux-clk";
 			reg = <0x01c20058 0x4>;
-			clocks = <&osc24M>, <&dummy>, <&osc32k>;
+			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
 		};
 
 		apb1: apb1 at 01c20058 {
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 3252aa8..86e06e4 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -74,6 +74,22 @@
 			clocks = <&osc24M>;
 		};
 
+		pll5: pll5 at 01c20020 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-pll5-clk";
+			reg = <0x01c20020 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll5_ddr", "pll5_other";
+		};
+
+		pll6: pll6 at 01c20028 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-pll6-clk";
+			reg = <0x01c20028 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll6_sata", "pll6_other", "pll6";
+		};
+
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
@@ -134,12 +150,11 @@
 				"apb0_ir", "apb0_keypad";
 		};
 
-		/* dummy is pll62 */
 		apb1_mux: apb1_mux at 01c20058 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-apb1-mux-clk";
 			reg = <0x01c20058 0x4>;
-			clocks = <&osc24M>, <&dummy>, <&osc32k>;
+			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
 		};
 
 		apb1: apb1 at 01c20058 {
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 8c4a9c3..cded3c7 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -74,6 +74,22 @@
 			clocks = <&osc24M>;
 		};
 
+		pll5: pll5 at 01c20020 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-pll5-clk";
+			reg = <0x01c20020 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll5_ddr", "pll5_other";
+		};
+
+		pll6: pll6 at 01c20028 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-pll6-clk";
+			reg = <0x01c20028 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll6_sata", "pll6_other", "pll6";
+		};
+
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
@@ -132,12 +148,11 @@
 			clock-output-names = "apb0_codec", "apb0_pio", "apb0_ir";
 		};
 
-		/* dummy is pll6 */
 		apb1_mux: apb1_mux at 01c20058 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-apb1-mux-clk";
 			reg = <0x01c20058 0x4>;
-			clocks = <&osc24M>, <&dummy>, <&osc32k>;
+			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
 		};
 
 		apb1: apb1 at 01c20058 {
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 2b2d3847..7949028 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -73,23 +73,27 @@
 			clocks = <&osc24M>;
 		};
 
-		/*
-		 * This is a dummy clock, to be used as placeholder on
-		 * other mux clocks when a specific parent clock is not
-		 * yet implemented. It should be dropped when the driver
-		 * is complete.
-		 */
-		pll6: pll6 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <0>;
+		pll5: pll5 at 01c20020 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-pll5-clk";
+			reg = <0x01c20020 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll5_ddr", "pll5_other";
+		};
+
+		pll6: pll6 at 01c20028 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun4i-pll6-clk";
+			reg = <0x01c20028 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll6_sata", "pll6_other", "pll6";
 		};
 
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-cpu-clk";
 			reg = <0x01c20054 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&pll6>;
+			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&pll6 1>;
 		};
 
 		axi: axi at 01c20054 {
@@ -148,7 +152,7 @@
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-apb1-mux-clk";
 			reg = <0x01c20058 0x4>;
-			clocks = <&osc24M>, <&pll6>, <&osc32k>;
+			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
 		};
 
 		apb1: apb1 at 01c20058 {
-- 
1.8.5.1
