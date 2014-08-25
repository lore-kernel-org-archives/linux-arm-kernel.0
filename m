From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:10:02 +0900
Subject: [PATCH 2/7] ARM: shmobile: r8a7791: Add JPU clock dt and CPG define.
In-Reply-To: <cover.1408928822.git.horms+renesas@verge.net.au>
References: <cover.1408928822.git.horms+renesas@verge.net.au>
Message-ID: <ed48b5d6fd339d145df5a6a1e48cf56ef265cf4f.1408928822.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>

Signed-off-by: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi            | 6 +++---
 include/dt-bindings/clock/r8a7791-clock.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index f26226e..d62c237 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -857,16 +857,16 @@
 		mstp1_clks: mstp1_clks at e6150134 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
-			clocks = <&p_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
+			clocks = <&m2_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
 				 <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7791_CLK_TMU1 R8A7791_CLK_TMU3 R8A7791_CLK_TMU2
+				R8A7791_CLK_JPU R8A7791_CLK_TMU1 R8A7791_CLK_TMU3 R8A7791_CLK_TMU2
 				R8A7791_CLK_CMT0 R8A7791_CLK_TMU0 R8A7791_CLK_VSP1_DU1
 				R8A7791_CLK_VSP1_DU0 R8A7791_CLK_VSP1_S
 			>;
 			clock-output-names =
-				"tmu1", "tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du1",
+				"jpu", "tmu1", "tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du1",
 				"vsp1-du0", "vsp1-sy";
 		};
 		mstp2_clks: mstp2_clks at e6150138 {
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index f0d4d10..58c3f49 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -25,6 +25,7 @@
 #define R8A7791_CLK_MSIOF0		0
 
 /* MSTP1 */
+#define R8A7791_CLK_JPU		6
 #define R8A7791_CLK_TMU1		11
 #define R8A7791_CLK_TMU3		21
 #define R8A7791_CLK_TMU2		22
-- 
2.0.1
