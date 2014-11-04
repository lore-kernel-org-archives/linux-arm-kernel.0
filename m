From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:43 +0900
Subject: [PATCH 13/34] ARM: shmobile: r8a7790: Add MMP clock to device tree
In-Reply-To: <cover.1415059587.git.horms+renesas@verge.net.au>
References: <cover.1415059587.git.horms+renesas@verge.net.au>
Message-ID: <4ba8f2468ce346642b4ace3cdf4bdd8d29175011.1415059587.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>

Signed-off-by: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 22 ++++++++++++++--------
 include/dt-bindings/clock/r8a7790-clock.h | 11 ++++++++++-
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 602a46a..050e608 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -977,18 +977,24 @@
 		mstp1_clks: mstp1_clks at e6150134 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
-			clocks = <&m2_clk>, <&p_clk>, <&zg_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
-				 <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>,
-				 <&zs_clk>;
+			clocks = <&zs_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>, <&m2_clk>,
+				 <&zs_clk>, <&p_clk>, <&zg_clk>, <&zs_clk>, <&zs_clk>,
+				 <&zs_clk>, <&zs_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
+				 <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7790_CLK_JPU R8A7790_CLK_TMU1 R8A7790_CLK_3DG
-				R8A7790_CLK_TMU3 R8A7790_CLK_TMU2
-				R8A7790_CLK_CMT0 R8A7790_CLK_TMU0 R8A7790_CLK_VSP1_DU1
-				R8A7790_CLK_VSP1_DU0 R8A7790_CLK_VSP1_R R8A7790_CLK_VSP1_S
+				R8A7790_CLK_VCP1 R8A7790_CLK_VCP0 R8A7790_CLK_VPC1
+				R8A7790_CLK_VPC0 R8A7790_CLK_JPU R8A7790_CLK_SSP1
+				R8A7790_CLK_TMU1 R8A7790_CLK_3DG R8A7790_CLK_2DDMAC
+				R8A7790_CLK_FDP1_2 R8A7790_CLK_FDP1_1 R8A7790_CLK_FDP1_0
+				R8A7790_CLK_TMU3 R8A7790_CLK_TMU2 R8A7790_CLK_CMT0
+				R8A7790_CLK_TMU0 R8A7790_CLK_VSP1_DU1 R8A7790_CLK_VSP1_DU0
+				R8A7790_CLK_VSP1_R R8A7790_CLK_VSP1_S
 			>;
 			clock-output-names =
-				"jpu", "tmu1", "3dg", "tmu3", "tmu2", "cmt0", "tmu0",
+				"vcp1", "vcp0", "vpc1", "vpc0", "jpu", "ssp1",
+				"tmu1", "3dg", "2ddmac", "fdp1-2", "fdp1-1",
+				"fdp1-0", "tmu3", "tmu2", "cmt0", "tmu0",
 				"vsp1-du1", "vsp1-du0", "vsp1-rt", "vsp1-sy";
 		};
 		mstp2_clks: mstp2_clks at e6150138 {
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 14a3f12..e3a3fb8 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -26,9 +26,18 @@
 #define R8A7790_CLK_MSIOF0		0
 
 /* MSTP1 */
-#define R8A7790_CLK_JPU		6
+#define R8A7790_CLK_VCP1		0
+#define R8A7790_CLK_VCP0		1
+#define R8A7790_CLK_VPC1		2
+#define R8A7790_CLK_VPC0		3
+#define R8A7790_CLK_JPU			6
+#define R8A7790_CLK_SSP1		9
 #define R8A7790_CLK_TMU1		11
 #define R8A7790_CLK_3DG			12
+#define R8A7790_CLK_2DDMAC		15
+#define R8A7790_CLK_FDP1_2		17
+#define R8A7790_CLK_FDP1_1		18
+#define R8A7790_CLK_FDP1_0		19
 #define R8A7790_CLK_TMU3		21
 #define R8A7790_CLK_TMU2		22
 #define R8A7790_CLK_CMT0		24
-- 
2.1.1
