From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Sat, 10 Oct 2015 18:15:07 +0800
Subject: [PATCH V3 2/2] ARM: dts: imx6: change the core clock of spdif
In-Reply-To: <cover.1444471684.git.shengjiu.wang@freescale.com>
References: <cover.1444471684.git.shengjiu.wang@freescale.com>
Message-ID: <2f2656454f7385b575af298d6350269534460a1b.1444471684.git.shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The correct core clock of spdif is SPDIF_GCLK, which is added to
clock tree. So the dts also need to be updated.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++++------
 arch/arm/boot/dts/imx6sl.dtsi  | 16 ++++++++++++++++
 arch/arm/boot/dts/imx6sx.dtsi  |  2 +-
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index e716e6f..2b6cc8b 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -218,16 +218,16 @@
 					dmas = <&sdma 14 18 0>,
 					       <&sdma 15 18 0>;
 					dma-names = "rx", "tx";
-					clocks = <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_OSC>,
-						 <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_DUMMY>,
-						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_DUMMY>,
-						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_DUMMY>,
-						 <&clks IMX6QDL_CLK_DUMMY>;
+					clocks = <&clks IMX6QDL_CLK_SPDIF_GCLK>, <&clks IMX6QDL_CLK_OSC>,
+						 <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_ASRC>,
+						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_ESAI_EXTAL>,
+						 <&clks IMX6QDL_CLK_IPG>, <&clks IMX6QDL_CLK_MLB>,
+						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_SPBA>;
 					clock-names = "core",  "rxtx0",
 						      "rxtx1", "rxtx2",
 						      "rxtx3", "rxtx4",
 						      "rxtx5", "rxtx6",
-						      "rxtx7";
+						      "rxtx7", "dma";
 					status = "disabled";
 				};
 
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index ebe8670..d8ba99f 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -135,8 +135,24 @@
 				ranges;
 
 				spdif: spdif at 02004000 {
+					compatible = "fsl,imx6sl-spdif",
+						"fsl,imx35-spdif";
 					reg = <0x02004000 0x4000>;
 					interrupts = <0 52 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&sdma 14 18 0>,
+						<&sdma 15 18 0>;
+					dma-names = "rx", "tx";
+					clocks = <&clks IMX6SL_CLK_SPDIF_GCLK>, <&clks IMX6SL_CLK_OSC>,
+						 <&clks IMX6SL_CLK_SPDIF>, <&clks IMX6SL_CLK_DUMMY>,
+						 <&clks IMX6SL_CLK_DUMMY>, <&clks IMX6SL_CLK_DUMMY>,
+						 <&clks IMX6SL_CLK_IPG>, <&clks IMX6SL_CLK_DUMMY>,
+						 <&clks IMX6SL_CLK_DUMMY>, <&clks IMX6SL_CLK_SPBA>;
+					clock-names = "core", "rxtx0",
+						"rxtx1", "rxtx2",
+						"rxtx3", "rxtx4",
+						"rxtx5", "rxtx6",
+						"rxtx7", "dma";
+					status = "disabled";
 				};
 
 				ecspi1: ecspi at 02008000 {
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index c94f2ea..167f77b 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -211,7 +211,7 @@
 					dmas = <&sdma 14 18 0>,
 					       <&sdma 15 18 0>;
 					dma-names = "rx", "tx";
-					clocks = <&clks IMX6SX_CLK_SPDIF>,
+					clocks = <&clks IMX6SX_CLK_SPDIF_GCLK>,
 						 <&clks IMX6SX_CLK_OSC>,
 						 <&clks IMX6SX_CLK_SPDIF>,
 						 <&clks 0>, <&clks 0>, <&clks 0>,
-- 
1.9.1
