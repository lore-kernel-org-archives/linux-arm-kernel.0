From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:19:39 +0900
Subject: [PATCH 16/21] ARM: shmobile: r8a7790: Add MSIOF clocks in device tree
In-Reply-To: <cover.1387893834.git.horms+renesas@verge.net.au>
References: <cover.1387893834.git.horms+renesas@verge.net.au>
Message-ID: <9d90951a39205206a46609055717af9bfb436e4d.1387893834.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 17 +++++++++++++----
 include/dt-bindings/clock/r8a7790-clock.h |  6 ++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 71ec31c..9c9a992 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -524,6 +524,14 @@
 		};
 
 		/* Gate clocks */
+		mstp0_clks: mstp0_clks at e6150130 {
+			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
+			clocks = <&mp_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <R8A7790_CLK_MSIOF0>;
+			clock-output-names = "msiof0";
+		};
 		mstp1_clks: mstp1_clks at e6150134 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
@@ -544,15 +552,16 @@
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
 			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
-				 <&mp_clk>;
+				 <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7790_CLK_SCIFA2 R8A7790_CLK_SCIFA1 R8A7790_CLK_SCIFA0
-				R8A7790_CLK_SCIFB0 R8A7790_CLK_SCIFB1 R8A7790_CLK_SCIFB2
+				R8A7790_CLK_MSIOF2 R8A7790_CLK_SCIFB0 R8A7790_CLK_SCIFB1
+				R8A7790_CLK_MSIOF1 R8A7790_CLK_MSIOF3 R8A7790_CLK_SCIFB2
 			>;
 			clock-output-names =
-				"scifa2", "scifa1", "scifa0", "scifb0", "scifb1",
-				"scifb2";
+				"scifa2", "scifa1", "scifa0", "msiof2", "scifb0",
+				"scifb1", "msiof1", "msiof3", "scifb2";
 		};
 		mstp3_clks: mstp3_clks at e615013c {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 420f0b0..bbabb8e 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -22,6 +22,9 @@
 #define R8A7790_CLK_SD1			8
 #define R8A7790_CLK_Z			9
 
+/* MSTP0 */
+#define R8A7790_CLK_MSIOF0		0
+
 /* MSTP1 */
 #define R8A7790_CLK_TMU1		11
 #define R8A7790_CLK_TMU3		21
@@ -37,8 +40,11 @@
 #define R8A7790_CLK_SCIFA2		2
 #define R8A7790_CLK_SCIFA1		3
 #define R8A7790_CLK_SCIFA0		4
+#define R8A7790_CLK_MSIOF2		5
 #define R8A7790_CLK_SCIFB0		6
 #define R8A7790_CLK_SCIFB1		7
+#define R8A7790_CLK_MSIOF1		8
+#define R8A7790_CLK_MSIOF3		15
 #define R8A7790_CLK_SCIFB2		16
 #define R8A7790_CLK_SYS_DMAC0		18
 #define R8A7790_CLK_SYS_DMAC1		19
-- 
1.8.4
