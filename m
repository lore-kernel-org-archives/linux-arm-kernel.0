From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 22 Jul 2013 22:01:10 -0300
Subject: [PATCH RFC 6/8] ARM: sunxi: add PLL5 and PLL6 support
In-Reply-To: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
References: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1374541272-32173-7-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds PLL5 and PLL6 nodes to the sun4i and sun5i device trees.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 19 +++++++++++++++++--
 arch/arm/boot/dts/sun5i-a10s.dtsi | 19 +++++++++++++++++--
 arch/arm/boot/dts/sun5i-a13.dtsi  | 19 +++++++++++++++++--
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 6d569fd..620290b 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -73,6 +73,22 @@
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
+			clock-output-names = "pll6_sata", "pll6_other";
+		};
+
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
@@ -138,12 +154,11 @@
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
index 9c1a2b9..4d47abc 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -70,6 +70,22 @@
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
+			clock-output-names = "pll6_sata", "pll6_other";
+		};
+
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
@@ -135,12 +151,11 @@
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
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 67889cf..e652b5f 100644
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
+			clock-output-names = "pll6_sata", "pll6_other";
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
-- 
1.8.3.3
