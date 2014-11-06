From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  6 Nov 2014 11:40:30 +0800
Subject: [PATCH resend 2/4] ARM: dts: sunxi: unify APB1 clock
In-Reply-To: <1415245232-20585-1-git-send-email-wens@csie.org>
References: <1415245232-20585-1-git-send-email-wens@csie.org>
Message-ID: <1415245232-20585-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emilio L?pez <emilio@elopez.com.ar>

With the new factors infrastructure in place, we can unify apb1 and
apb1_mux as a single clock now.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
[wens at csie.org: Change apb1 node label to "apb1"; reword commit title]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 12 ++----------
 arch/arm/boot/dts/sun5i-a10s.dtsi | 12 ++----------
 arch/arm/boot/dts/sun5i-a13.dtsi  | 12 ++----------
 arch/arm/boot/dts/sun7i-a20.dtsi  | 12 ++----------
 4 files changed, 8 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 380f914..5e2ec2d 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -174,19 +174,11 @@
 				"apb0_ir1", "apb0_keypad";
 		};
 
-		apb1_mux: apb1_mux at 01c20058 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-apb1-mux-clk";
-			reg = <0x01c20058 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
-			clock-output-names = "apb1_mux";
-		};
-
-		apb1: apb1 at 01c20058 {
+		apb1: clk at 01c20058 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-apb1-clk";
 			reg = <0x01c20058 0x4>;
-			clocks = <&apb1_mux>;
+			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
 			clock-output-names = "apb1";
 		};
 
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 531272c..d2a8514 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -162,19 +162,11 @@
 				"apb0_ir", "apb0_keypad";
 		};
 
-		apb1_mux: apb1_mux at 01c20058 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-apb1-mux-clk";
-			reg = <0x01c20058 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
-			clock-output-names = "apb1_mux";
-		};
-
-		apb1: apb1 at 01c20058 {
+		apb1: clk at 01c20058 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-apb1-clk";
 			reg = <0x01c20058 0x4>;
-			clocks = <&apb1_mux>;
+			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
 			clock-output-names = "apb1";
 		};
 
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index b131068..c35217e 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -161,19 +161,11 @@
 			clock-output-names = "apb0_codec", "apb0_pio", "apb0_ir";
 		};
 
-		apb1_mux: apb1_mux at 01c20058 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-apb1-mux-clk";
-			reg = <0x01c20058 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
-			clock-output-names = "apb1_mux";
-		};
-
-		apb1: apb1 at 01c20058 {
+		apb1: clk at 01c20058 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-apb1-clk";
 			reg = <0x01c20058 0x4>;
-			clocks = <&apb1_mux>;
+			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
 			clock-output-names = "apb1";
 		};
 
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 45bb916..8605f2b 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -222,19 +222,11 @@
 				"apb0_iis2", "apb0_keypad";
 		};
 
-		apb1_mux: apb1_mux at 01c20058 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-apb1-mux-clk";
-			reg = <0x01c20058 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
-			clock-output-names = "apb1_mux";
-		};
-
-		apb1: apb1 at 01c20058 {
+		apb1: clk at 01c20058 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-apb1-clk";
 			reg = <0x01c20058 0x4>;
-			clocks = <&apb1_mux>;
+			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
 			clock-output-names = "apb1";
 		};
 
-- 
2.1.1
