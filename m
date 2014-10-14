From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Tue, 14 Oct 2014 16:01:40 +0900
Subject: [PATCH 1/4] ARM: shmobile: r8a7790: Add RGX clock to device tree
In-Reply-To: <1413270103-9517-1-git-send-email-ykaneko0929@gmail.com>
References: <1413270103-9517-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <1413270103-9517-2-git-send-email-ykaneko0929@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kouei Abe <kouei.abe.cp@renesas.com>

Signed-off-by: Kouei Abe <kouei.abe.cp@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 9 +++++----
 include/dt-bindings/clock/r8a7790-clock.h | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 2380fd5..1e96705 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -938,18 +938,19 @@
 		mstp1_clks: mstp1_clks at e6150134 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
-			clocks = <&m2_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
+			clocks = <&m2_clk>, <&p_clk>, <&zg_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
 				 <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>,
 				 <&zs_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7790_CLK_JPU R8A7790_CLK_TMU1 R8A7790_CLK_TMU3 R8A7790_CLK_TMU2
+				R8A7790_CLK_JPU R8A7790_CLK_TMU1 R8A7790_CLK_3DG
+				R8A7790_CLK_TMU3 R8A7790_CLK_TMU2
 				R8A7790_CLK_CMT0 R8A7790_CLK_TMU0 R8A7790_CLK_VSP1_DU1
 				R8A7790_CLK_VSP1_DU0 R8A7790_CLK_VSP1_R R8A7790_CLK_VSP1_S
 			>;
 			clock-output-names =
-				"jpu", "tmu1", "tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du1",
-				"vsp1-du0", "vsp1-rt", "vsp1-sy";
+				"jpu", "tmu1", "3dg", "tmu3", "tmu2", "cmt0", "tmu0",
+				"vsp1-du1", "vsp1-du0", "vsp1-rt", "vsp1-sy";
 		};
 		mstp2_clks: mstp2_clks at e6150138 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 8ea7ab0..14a3f12 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -28,6 +28,7 @@
 /* MSTP1 */
 #define R8A7790_CLK_JPU		6
 #define R8A7790_CLK_TMU1		11
+#define R8A7790_CLK_3DG			12
 #define R8A7790_CLK_TMU3		21
 #define R8A7790_CLK_TMU2		22
 #define R8A7790_CLK_CMT0		24
-- 
1.9.1
