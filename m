From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  6 Sep 2014 18:47:26 +0800
Subject: [PATCH 5/7] ARM: dts: sun6i: Unify ahb1 clock nodes
In-Reply-To: <1410000448-9999-1-git-send-email-wens@csie.org>
References: <1410000448-9999-1-git-send-email-wens@csie.org>
Message-ID: <1410000448-9999-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock driver has unified support for the ahb1 clock.
Unify the clock nodes so it works.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index c1295bf..8eb2c6d 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -126,19 +126,11 @@
 			clock-output-names = "axi";
 		};
 
-		ahb1_mux: ahb1_mux at 01c20054 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun6i-a31-ahb1-mux-clk";
-			reg = <0x01c20054 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6>;
-			clock-output-names = "ahb1_mux";
-		};
-
 		ahb1: ahb1 at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-ahb-clk";
+			compatible = "allwinner,sun6i-a31-ahb1-clk";
 			reg = <0x01c20054 0x4>;
-			clocks = <&ahb1_mux>;
+			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6>;
 			clock-output-names = "ahb1";
 		};
 
-- 
2.1.0
