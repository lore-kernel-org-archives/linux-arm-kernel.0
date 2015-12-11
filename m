From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 11 Dec 2015 11:52:42 +0900
Subject: [PATCH/RFC 05/19] ARM: shmobile: r8a7793: add MSTP10 clocks to device
 tree
In-Reply-To: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1449802376-11301-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instantiate MSTP10 clocks in r8a7793 device tree.

Based on similar work for the r8a7791 by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi            | 36 +++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7793-clock.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index cdf40abcc36c..5f953c594395 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -955,6 +955,42 @@
 				"qspi_mod", "i2c5", "iic3", "i2c4",
 				"i2c3", "i2c2", "i2c1", "i2c0";
 		};
+		mstp10_clks: mstp10_clks at e6150998 {
+			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
+			clocks = <&p_clk>,
+				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				<&p_clk>,
+				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>,
+				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>,
+				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>,
+				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>,
+				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>,
+				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>,
+				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>;
+
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7793_CLK_SSI_ALL
+				R8A7793_CLK_SSI9 R8A7793_CLK_SSI8 R8A7793_CLK_SSI7 R8A7793_CLK_SSI6 R8A7793_CLK_SSI5
+				R8A7793_CLK_SSI4 R8A7793_CLK_SSI3 R8A7793_CLK_SSI2 R8A7793_CLK_SSI1 R8A7793_CLK_SSI0
+				R8A7793_CLK_SCU_ALL
+				R8A7793_CLK_SCU_DVC1 R8A7793_CLK_SCU_DVC0
+				R8A7793_CLK_SCU_CTU1_MIX1 R8A7793_CLK_SCU_CTU0_MIX0
+				R8A7793_CLK_SCU_SRC9 R8A7793_CLK_SCU_SRC8 R8A7793_CLK_SCU_SRC7 R8A7793_CLK_SCU_SRC6 R8A7793_CLK_SCU_SRC5
+				R8A7793_CLK_SCU_SRC4 R8A7793_CLK_SCU_SRC3 R8A7793_CLK_SCU_SRC2 R8A7793_CLK_SCU_SRC1 R8A7793_CLK_SCU_SRC0
+			>;
+			clock-output-names =
+				"ssi-all",
+				"ssi9", "ssi8", "ssi7", "ssi6", "ssi5",
+				"ssi4", "ssi3", "ssi2", "ssi1", "ssi0",
+				"scu-all",
+				"scu-dvc1", "scu-dvc0",
+				"scu-ctu1-mix1", "scu-ctu0-mix0",
+				"scu-src9", "scu-src8", "scu-src7", "scu-src6", "scu-src5",
+				"scu-src4", "scu-src3", "scu-src2", "scu-src1", "scu-src0";
+		};
 		mstp11_clks: mstp11_clks at e615099c {
 			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615099c 0 4>, <0 0xe61509ac 0 4>;
diff --git a/include/dt-bindings/clock/r8a7793-clock.h b/include/dt-bindings/clock/r8a7793-clock.h
index 1579e07f96a3..efcbc594fe82 100644
--- a/include/dt-bindings/clock/r8a7793-clock.h
+++ b/include/dt-bindings/clock/r8a7793-clock.h
@@ -145,6 +145,8 @@
 #define R8A7793_CLK_SCU_ALL		17
 #define R8A7793_CLK_SCU_DVC1		18
 #define R8A7793_CLK_SCU_DVC0		19
+#define R8A7793_CLK_SCU_CTU1_MIX1	20
+#define R8A7793_CLK_SCU_CTU0_MIX0	21
 #define R8A7793_CLK_SCU_SRC9		22
 #define R8A7793_CLK_SCU_SRC8		23
 #define R8A7793_CLK_SCU_SRC7		24
-- 
2.1.4
