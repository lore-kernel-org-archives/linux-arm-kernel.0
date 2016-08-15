From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Aug 2016 10:55:39 +0200
Subject: [PATCH 20/26] ARM: dts: r8a7794: add MSTP10 clocks
In-Reply-To: <cover.1471251169.git.horms+renesas@verge.net.au>
References: <cover.1471251169.git.horms+renesas@verge.net.au>
Message-ID: <975fb77f874be95e50e653e90bcbcf09c08e66c2.1471251169.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add MSTP10 clocks to the R8A7794 device tree.

This patch is based on the commit ee9141522dcf ("ARM: shmobile: r8a7791:
add MSTP10 support on DTSI").

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 52 +++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7794-clock.h | 24 ++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 1c2d3846d70e..cba41c199fd8 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1267,6 +1267,58 @@
 				"gpio1", "gpio0", "rcan1", "rcan0", "qspi_mod",
 				"i2c5", "i2c4", "i2c3", "i2c2", "i2c1", "i2c0";
 		};
+		mstp10_clks: mstp10_clks at e6150998 {
+			compatible = "renesas,r8a7794-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
+			clocks = <&p_clk>,
+				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
+				 <&p_clk>,
+				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
+				 <&mstp10_clks R8A7794_CLK_SCU_ALL>;
+			#clock-cells = <1>;
+			clock-indices = <R8A7794_CLK_SSI_ALL
+					 R8A7794_CLK_SSI9 R8A7794_CLK_SSI8
+					 R8A7794_CLK_SSI7 R8A7794_CLK_SSI6
+					 R8A7794_CLK_SSI5 R8A7794_CLK_SSI4
+					 R8A7794_CLK_SSI3 R8A7794_CLK_SSI2
+					 R8A7794_CLK_SSI1 R8A7794_CLK_SSI0
+					 R8A7794_CLK_SCU_ALL
+					 R8A7794_CLK_SCU_DVC1
+					 R8A7794_CLK_SCU_DVC0
+					 R8A7794_CLK_SCU_CTU1_MIX1
+					 R8A7794_CLK_SCU_CTU0_MIX0
+					 R8A7794_CLK_SCU_SRC6
+					 R8A7794_CLK_SCU_SRC5
+					 R8A7794_CLK_SCU_SRC4
+					 R8A7794_CLK_SCU_SRC3
+					 R8A7794_CLK_SCU_SRC2
+					 R8A7794_CLK_SCU_SRC1>;
+			clock-output-names = "ssi-all", "ssi9", "ssi8", "ssi7",
+					     "ssi6", "ssi5", "ssi4", "ssi3",
+					     "ssi2", "ssi1", "ssi0",
+					     "scu-all", "scu-dvc1", "scu-dvc0",
+					     "scu-ctu1-mix1", "scu-ctu0-mix0",
+					     "scu-src6", "scu-src5", "scu-src4",
+					     "scu-src3", "scu-src2", "scu-src1";
+		};
 		mstp11_clks: mstp11_clks at e615099c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615099c 0 4>, <0 0xe61509ac 0 4>;
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index f8279eca033e..9d02f5317c7c 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -108,6 +108,30 @@
 #define R8A7794_CLK_I2C1		30
 #define R8A7794_CLK_I2C0		31
 
+/* MSTP10 */
+#define R8A7794_CLK_SSI_ALL		5
+#define R8A7794_CLK_SSI9		6
+#define R8A7794_CLK_SSI8		7
+#define R8A7794_CLK_SSI7		8
+#define R8A7794_CLK_SSI6		9
+#define R8A7794_CLK_SSI5		10
+#define R8A7794_CLK_SSI4		11
+#define R8A7794_CLK_SSI3		12
+#define R8A7794_CLK_SSI2		13
+#define R8A7794_CLK_SSI1		14
+#define R8A7794_CLK_SSI0		15
+#define R8A7794_CLK_SCU_ALL		17
+#define R8A7794_CLK_SCU_DVC1		18
+#define R8A7794_CLK_SCU_DVC0		19
+#define R8A7794_CLK_SCU_CTU1_MIX1	20
+#define R8A7794_CLK_SCU_CTU0_MIX0	21
+#define R8A7794_CLK_SCU_SRC6		25
+#define R8A7794_CLK_SCU_SRC5		26
+#define R8A7794_CLK_SCU_SRC4		27
+#define R8A7794_CLK_SCU_SRC3		28
+#define R8A7794_CLK_SCU_SRC2		29
+#define R8A7794_CLK_SCU_SRC1		30
+
 /* MSTP11 */
 #define R8A7794_CLK_SCIFA3		6
 #define R8A7794_CLK_SCIFA4		7
-- 
2.7.0.rc3.207.g0ac5344
