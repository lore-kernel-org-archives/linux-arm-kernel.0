From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:10:01 +0900
Subject: [PATCH 1/7] ARM: shmobile: r8a7790: Add JPU clock dt and CPG define.
In-Reply-To: <cover.1408928822.git.horms+renesas@verge.net.au>
References: <cover.1408928822.git.horms+renesas@verge.net.au>
Message-ID: <da076a888ab19f13816372796ed231e7d6ff5fed.1408928822.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>

Signed-off-by: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 6 +++---
 include/dt-bindings/clock/r8a7790-clock.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 2278bd0..c11541d 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -836,17 +836,17 @@
 		mstp1_clks: mstp1_clks at e6150134 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
-			clocks = <&p_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
+			clocks = <&m2_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
 				 <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>,
 				 <&zs_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7790_CLK_TMU1 R8A7790_CLK_TMU3 R8A7790_CLK_TMU2
+				R8A7790_CLK_JPU R8A7790_CLK_TMU1 R8A7790_CLK_TMU3 R8A7790_CLK_TMU2
 				R8A7790_CLK_CMT0 R8A7790_CLK_TMU0 R8A7790_CLK_VSP1_DU1
 				R8A7790_CLK_VSP1_DU0 R8A7790_CLK_VSP1_R R8A7790_CLK_VSP1_S
 			>;
 			clock-output-names =
-				"tmu1", "tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du1",
+				"jpu", "tmu1", "tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du1",
 				"vsp1-du0", "vsp1-rt", "vsp1-sy";
 		};
 		mstp2_clks: mstp2_clks at e6150138 {
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index f929a79e..8ea7ab0 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -26,6 +26,7 @@
 #define R8A7790_CLK_MSIOF0		0
 
 /* MSTP1 */
+#define R8A7790_CLK_JPU		6
 #define R8A7790_CLK_TMU1		11
 #define R8A7790_CLK_TMU3		21
 #define R8A7790_CLK_TMU2		22
-- 
2.0.1
