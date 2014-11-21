From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Nov 2014 09:54:52 +0900
Subject: [PATCH 26/29] ARM: shmobile: r8a7794: Add SGX clock to device tree
In-Reply-To: <cover.1416476366.git.horms+renesas@verge.net.au>
References: <cover.1416476366.git.horms+renesas@verge.net.au>
Message-ID: <3e58a5424c8325df8b62f1de175dc95c7373bfe1.1416476366.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kouei Abe <kouei.abe.cp@renesas.com>

Signed-off-by: Kouei Abe <kouei.abe.cp@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 11 +++++------
 include/dt-bindings/clock/r8a7794-clock.h |  1 +
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 95f656d..b6f8f45 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -461,16 +461,15 @@
 		mstp1_clks: mstp1_clks at e6150134 {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
-			clocks = <&p_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
-				 <&cp_clk>,
-				 <&zs_clk>, <&zs_clk>, <&zs_clk>;
+			clocks = <&p_clk>, <&zg_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
+				 <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7794_CLK_TMU1 R8A7794_CLK_TMU3 R8A7794_CLK_TMU2
-				R8A7794_CLK_CMT0 R8A7794_CLK_TMU0
+				R8A7794_CLK_TMU1 R8A7794_CLK_3DG R8A7794_CLK_TMU3
+				R8A7794_CLK_TMU2 R8A7794_CLK_CMT0 R8A7794_CLK_TMU0
 			>;
 			clock-output-names =
-				"tmu1", "tmu3", "tmu2", "cmt0", "tmu0";
+				"tmu1", "3dg", "tmu3", "tmu2", "cmt0", "tmu0";
 		};
 		mstp2_clks: mstp2_clks at e6150138 {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index fd7cdee..9066213 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -27,6 +27,7 @@
 
 /* MSTP1 */
 #define R8A7794_CLK_TMU1		11
+#define R8A7794_CLK_3DG			12
 #define R8A7794_CLK_TMU3		21
 #define R8A7794_CLK_TMU2		22
 #define R8A7794_CLK_CMT0		24
-- 
2.1.1
