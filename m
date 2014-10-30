From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Oct 2014 14:58:56 +0900
Subject: [PATCH 3/3] ARM: shmobile: r8a7794: Add MMP and VSP1 clocks to device
 tree
In-Reply-To: <1414648736-31412-1-git-send-email-horms+renesas@verge.net.au>
References: <1414648736-31412-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1414648736-31412-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>

Signed-off-by: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 14 +++++++++-----
 include/dt-bindings/clock/r8a7794-clock.h |  6 ++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 08c50c8..d62589f 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -461,15 +461,19 @@
 		mstp1_clks: mstp1_clks at e6150134 {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
-			clocks = <&p_clk>, <&zg_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
-				 <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>;
+			clocks = <&zs_clk>, <&zs_clk>, <&p_clk>, <&zg_clk>, <&zs_clk>,
+				 <&zs_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>, <&cp_clk>,
+				 <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7794_CLK_TMU1 R8A7794_CLK_PVRSRVKM R8A7794_CLK_TMU3
-				R8A7794_CLK_TMU2 R8A7794_CLK_CMT0 R8A7794_CLK_TMU0
+				R8A7794_CLK_VCP0 R8A7794_CLK_VPC0 R8A7794_CLK_TMU1
+				R8A7794_CLK_PVRSRVKM R8A7794_CLK_2DDMAC R8A7794_CLK_FDP0
+				R8A7794_CLK_TMU3 R8A7794_CLK_TMU2 R8A7794_CLK_CMT0
+				R8A7794_CLK_TMU0 R8A7794_CLK_VSP1_DU0 R8A7794_CLK_VSP1_S
 			>;
 			clock-output-names =
-				"tmu1", "pvrsrvkm", "tmu3", "tmu2", "cmt0", "tmu0";
+				"vcp0", "vpc0", "tmu1", "pvrsrvkm", "tddmac", "fdp0",
+				"tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du0", "vsps";
 		};
 		mstp2_clks: mstp2_clks at e6150138 {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index 7d49531..512ce89 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -26,12 +26,18 @@
 #define R8A7794_CLK_MSIOF0		0
 
 /* MSTP1 */
+#define R8A7794_CLK_VCP0		1
+#define R8A7794_CLK_VPC0		3
 #define R8A7794_CLK_TMU1		11
 #define R8A7794_CLK_PVRSRVKM		12
+#define R8A7794_CLK_2DDMAC		15
+#define R8A7794_CLK_FDP0		19
 #define R8A7794_CLK_TMU3		21
 #define R8A7794_CLK_TMU2		22
 #define R8A7794_CLK_CMT0		24
 #define R8A7794_CLK_TMU0		25
+#define R8A7794_CLK_VSP1_DU0		28
+#define R8A7794_CLK_VSP1_S		31
 
 /* MSTP2 */
 #define R8A7794_CLK_SCIFA2		2
-- 
2.1.1
