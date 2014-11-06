From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  6 Nov 2014 11:40:31 +0800
Subject: [PATCH resend 3/4] ARM: dts: sunxi: Use sun4i-a10-apb1-clk for
 sun6i/sun8i apb2 clocks.
In-Reply-To: <1415245232-20585-1-git-send-email-wens@csie.org>
References: <1415245232-20585-1-git-send-email-wens@csie.org>
Message-ID: <1415245232-20585-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The apb2 clocks are actually the same as apb1 clocks on the other sunxi
platforms, hence compatible with "allwinner,sun4i-a10-apb1-clk".

Update the dtsi to use the new unified apb1 clk.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 12 ++----------
 arch/arm/boot/dts/sun8i-a23.dtsi | 12 ++----------
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index e80288e..3a51151 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -217,19 +217,11 @@
 					"apb1_daudio1";
 		};
 
-		apb2_mux: apb2_mux at 01c20058 {
+		apb2: clk at 01c20058 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-apb1-mux-clk";
+			compatible = "allwinner,sun4i-a10-apb1-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
-			clock-output-names = "apb2_mux";
-		};
-
-		apb2: apb2 at 01c20058 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun6i-a31-apb2-div-clk";
-			reg = <0x01c20058 0x4>;
-			clocks = <&apb2_mux>;
 			clock-output-names = "apb2";
 		};
 
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 6086adb..0746cd1 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -189,19 +189,11 @@
 					"apb1_daudio0",	"apb1_daudio1";
 		};
 
-		apb2_mux: apb2_mux_clk at 01c20058 {
+		apb2: clk at 01c20058 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-apb1-mux-clk";
+			compatible = "allwinner,sun4i-a10-apb1-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
-			clock-output-names = "apb2_mux";
-		};
-
-		apb2: apb2_clk at 01c20058 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun6i-a31-apb2-div-clk";
-			reg = <0x01c20058 0x4>;
-			clocks = <&apb2_mux>;
 			clock-output-names = "apb2";
 		};
 
-- 
2.1.1
