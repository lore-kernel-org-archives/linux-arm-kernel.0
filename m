From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Nov 2015 17:05:10 -0800
Subject: [PATCH 03/29] ARM: shmobile: r8a7791 dtsi: Remove bogus imp_clk node
In-Reply-To: <cover.1447981420.git.horms+renesas@verge.net.au>
References: <cover.1447981420.git.horms+renesas@verge.net.au>
Message-ID: <5d2ac865a609ff1c5a5228c8721e7ae06f5f7b72.1447981420.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

R-Car M2-W does not have an IMP core or an IMP clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 3b8e26dde36d..57029d3fe1e5 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1163,14 +1163,6 @@
 			clock-mult = <1>;
 			clock-output-names = "m2";
 		};
-		imp_clk: imp_clk {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7791_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <4>;
-			clock-mult = <1>;
-			clock-output-names = "imp";
-		};
 		rclk_clk: rclk_clk {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7791_CLK_PLL1>;
-- 
2.1.4
