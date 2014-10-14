From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Tue, 14 Oct 2014 16:01:41 +0900
Subject: [PATCH 2/4] ARM: shmobile: r8a7791: Add SGX clock to device tree
In-Reply-To: <1413270103-9517-1-git-send-email-ykaneko0929@gmail.com>
References: <1413270103-9517-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <1413270103-9517-3-git-send-email-ykaneko0929@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kouei Abe <kouei.abe.cp@renesas.com>

Signed-off-by: Kouei Abe <kouei.abe.cp@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---
 arch/arm/boot/dts/r8a7791.dtsi            | 11 ++++++-----
 include/dt-bindings/clock/r8a7791-clock.h |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index d343099..5a26c1a 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1,7 +1,7 @@
 /*
  * Device Tree Source for the r8a7791 SoC
  *
- * Copyright (C) 2013 Renesas Electronics Corporation
+ * Copyright (C) 2013-2014 Renesas Electronics Corporation
  * Copyright (C) 2013-2014 Renesas Solutions Corp.
  * Copyright (C) 2014 Cogent Embedded Inc.
  *
@@ -947,17 +947,18 @@
 		mstp1_clks: mstp1_clks at e6150134 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
-			clocks = <&m2_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
+			clocks = <&m2_clk>, <&p_clk>, <&zg_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
 				 <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7791_CLK_JPU R8A7791_CLK_TMU1 R8A7791_CLK_TMU3 R8A7791_CLK_TMU2
+				R8A7791_CLK_JPU R8A7791_CLK_TMU1 R8A7791_CLK_3DG
+				R8A7791_CLK_TMU3 R8A7791_CLK_TMU2
 				R8A7791_CLK_CMT0 R8A7791_CLK_TMU0 R8A7791_CLK_VSP1_DU1
 				R8A7791_CLK_VSP1_DU0 R8A7791_CLK_VSP1_S
 			>;
 			clock-output-names =
-				"jpu", "tmu1", "tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du1",
-				"vsp1-du0", "vsp1-sy";
+				"jpu", "tmu1", "3dg", "tmu3", "tmu2", "cmt0", "tmu0",
+				"vsp1-du1", "vsp1-du0", "vsp1-sy";
 		};
 		mstp2_clks: mstp2_clks at e6150138 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index 58c3f49..9570b7c 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -27,6 +27,7 @@
 /* MSTP1 */
 #define R8A7791_CLK_JPU		6
 #define R8A7791_CLK_TMU1		11
+#define R8A7791_CLK_3DG			12
 #define R8A7791_CLK_TMU3		21
 #define R8A7791_CLK_TMU2		22
 #define R8A7791_CLK_CMT0		24
-- 
1.9.1
