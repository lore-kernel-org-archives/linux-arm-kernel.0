From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 22 Feb 2016 18:20:47 +0000
Subject: [PATCH v3 02/10] ARM: dts: sunxi: make PLL8 in the H3 a proper clock
In-Reply-To: <1456165255-31013-1-git-send-email-andre.przywara@arm.com>
References: <1456165255-31013-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1456165255-31013-3-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can reuse the A31 PLL6 clock driver for clocks other then
PLL6 itself, describe the PLL8 clock properly.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 3ba65c2..d84ea9b 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -137,12 +137,12 @@
 			clock-output-names = "pll6d2";
 		};
 
-		/* dummy clock until pll6 can be reused */
-		pll8: pll8_clk {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <1>;
-			clock-output-names = "pll8";
+		pll8: clk at c01c20044 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun6i-a31-pll6-clk";
+			reg = <0x01c20044 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll8", "pll8x2";
 		};
 
 		cpu: cpu_clk at 01c20050 {
@@ -243,7 +243,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20088 0x4>;
-			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
+			clocks = <&osc24M>, <&pll6 0>, <&pll8 0>;
 			clock-output-names = "mmc0",
 					     "mmc0_output",
 					     "mmc0_sample";
@@ -253,7 +253,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c2008c 0x4>;
-			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
+			clocks = <&osc24M>, <&pll6 0>, <&pll8 0>;
 			clock-output-names = "mmc1",
 					     "mmc1_output",
 					     "mmc1_sample";
@@ -263,7 +263,7 @@
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
 			reg = <0x01c20090 0x4>;
-			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
+			clocks = <&osc24M>, <&pll6 0>, <&pll8 0>;
 			clock-output-names = "mmc2",
 					     "mmc2_output",
 					     "mmc2_sample";
-- 
2.6.4
