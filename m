From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Thu,  9 Oct 2014 19:03:05 +0900
Subject: [PATCH 4/4] ARM: shmobile: r8a7791: Add MMP clock to device tree
In-Reply-To: <1412848985-29353-1-git-send-email-ykaneko0929@gmail.com>
References: <1412848985-29353-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <1412848985-29353-5-git-send-email-ykaneko0929@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>

Signed-off-by: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---
 arch/arm/boot/dts/r8a7791.dtsi            | 21 +++++++++++++--------
 include/dt-bindings/clock/r8a7791-clock.h |  8 +++++++-
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index d59d2a8..7a0ca37 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -947,18 +947,23 @@
 		mstp1_clks: mstp1_clks at e6150134 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
-			clocks = <&m2_clk>, <&p_clk>, <&zg_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
-				 <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>;
+			clocks = <&zs_clk>, <&zs_clk>, <&m2_clk>, <&zs_clk>, <&p_clk>,
+				 <&zg_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>, <&p_clk>,
+				 <&p_clk>, <&rclk_clk>, <&cp_clk>, <&zs_clk>, <&zs_clk>,
+				 <&zs_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7791_CLK_JPU R8A7791_CLK_TMU1 R8A7791_CLK_PVRSRVKM
-				R8A7791_CLK_TMU3 R8A7791_CLK_TMU2
-				R8A7791_CLK_CMT0 R8A7791_CLK_TMU0 R8A7791_CLK_VSP1_DU1
-				R8A7791_CLK_VSP1_DU0 R8A7791_CLK_VSP1_S
+				R8A7791_CLK_VCP0 R8A7791_CLK_VPC0 R8A7791_CLK_JPU
+				R8A7791_CLK_SSP1 R8A7791_CLK_TMU1 R8A7791_CLK_PVRSRVKM
+				R8A7791_CLK_2DDMAC R8A7791_CLK_FDP1 R8A7791_CLK_FDP0
+				R8A7791_CLK_TMU3 R8A7791_CLK_TMU2 R8A7791_CLK_CMT0
+				R8A7791_CLK_TMU0 R8A7791_CLK_VSP1_DU1 R8A7791_CLK_VSP1_DU0
+				R8A7791_CLK_VSP1_S
 			>;
 			clock-output-names =
-				"jpu", "tmu1", "pvrsrvkm", "tmu3", "tmu2", "cmt0", "tmu0",
-				"vsp1-du1", "vsp1-du0", "vsp1-sy";
+				"vcp0", "vpc0", "jpu", "ssp1", "tmu1", "pvrsrvkm",
+				"2ddmac", "fdp1", "fdp0", "tmu3", "tmu2", "cmt0",
+				"tmu0", "vsp1-du1", "vsp1-du0", "vsp1-sy";
 		};
 		mstp2_clks: mstp2_clks at e6150138 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index 950250d..4d1617e 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -25,9 +25,15 @@
 #define R8A7791_CLK_MSIOF0		0
 
 /* MSTP1 */
-#define R8A7791_CLK_JPU		6
+#define R8A7791_CLK_VCP0		1
+#define R8A7791_CLK_VPC0		3
+#define R8A7791_CLK_JPU			6
+#define R8A7791_CLK_SSP1		9
 #define R8A7791_CLK_TMU1		11
 #define R8A7791_CLK_PVRSRVKM		12
+#define R8A7791_CLK_2DDMAC		15
+#define R8A7791_CLK_FDP1		18
+#define R8A7791_CLK_FDP0		19
 #define R8A7791_CLK_TMU3		21
 #define R8A7791_CLK_TMU2		22
 #define R8A7791_CLK_CMT0		24
-- 
1.9.1
