From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 23 Nov 2014 12:33:24 +0800
Subject: [PATCH v4 5/6] ARM: dts: sun6i: Unify ahb1 clock nodes
In-Reply-To: <1416717205-15406-1-git-send-email-wens@csie.org>
References: <1416717205-15406-1-git-send-email-wens@csie.org>
Message-ID: <1416717205-15406-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock driver has unified support for the ahb1 clock.
Unify the clock nodes so it works.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index f1519a8..17d746e 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -162,19 +162,11 @@
 			clock-output-names = "axi";
 		};
 
-		ahb1_mux: ahb1_mux at 01c20054 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun6i-a31-ahb1-mux-clk";
-			reg = <0x01c20054 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
-			clock-output-names = "ahb1_mux";
-		};
-
 		ahb1: ahb1 at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-ahb-clk";
+			compatible = "allwinner,sun6i-a31-ahb1-clk";
 			reg = <0x01c20054 0x4>;
-			clocks = <&ahb1_mux>;
+			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
 			clock-output-names = "ahb1";
 		};
 
@@ -355,7 +347,7 @@
 			#dma-cells = <1>;
 
 			/* DMA controller requires AHB1 clocked from PLL6 */
-			assigned-clocks = <&ahb1_mux>;
+			assigned-clocks = <&ahb1>;
 			assigned-clock-parents = <&pll6 0>;
 		};
 
-- 
2.1.3
