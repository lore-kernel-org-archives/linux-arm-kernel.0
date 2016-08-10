From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Wed, 10 Aug 2016 13:00:27 -0300
Subject: [PATCH 1/2] ARM: dts: imx7s: Add SAI nodes
Message-ID: <1470844828-12848-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the three SAI ports nodes.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 1e90bdb..29246302 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -723,6 +723,51 @@
 				status = "disabled";
 			};
 
+			sai1: sai at 308a0000 {
+				#sound-dai-cells = <0>;
+				compatible = "fsl,imx7d-sai", "fsl,imx6sx-sai";
+				reg = <0x308a0000 0x10000>;
+				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_SAI1_IPG_CLK>,
+					 <&clks IMX7D_SAI1_ROOT_CLK>,
+					 <&clks IMX7D_CLK_DUMMY>,
+					 <&clks IMX7D_CLK_DUMMY>;
+				clock-names = "bus", "mclk1", "mclk2", "mclk3";
+				dma-names = "rx", "tx";
+				dmas = <&sdma 8 24 0>, <&sdma 9 24 0>;
+				status = "disabled";
+			};
+
+			sai2: sai at 308b0000 {
+				#sound-dai-cells = <0>;
+				compatible = "fsl,imx7d-sai", "fsl,imx6sx-sai";
+				reg = <0x308b0000 0x10000>;
+				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_SAI2_IPG_CLK>,
+					 <&clks IMX7D_SAI2_ROOT_CLK>,
+					 <&clks IMX7D_CLK_DUMMY>,
+					 <&clks IMX7D_CLK_DUMMY>;
+				clock-names = "bus", "mclk1", "mclk2", "mclk3";
+				dma-names = "rx", "tx";
+				dmas = <&sdma 10 24 0>, <&sdma 11 24 0>;
+				status = "disabled";
+			};
+
+			sai3: sai at 308c0000 {
+				#sound-dai-cells = <0>;
+				compatible = "fsl,imx7d-sai", "fsl,imx6sx-sai";
+				reg = <0x308c0000 0x10000>;
+				interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_SAI3_IPG_CLK>,
+					 <&clks IMX7D_SAI3_ROOT_CLK>,
+					 <&clks IMX7D_CLK_DUMMY>,
+					 <&clks IMX7D_CLK_DUMMY>;
+				clock-names = "bus", "mclk1", "mclk2", "mclk3";
+				dma-names = "rx", "tx";
+				dmas = <&sdma 12 24 0>, <&sdma 13 24 0>;
+				status = "disabled";
+			};
+
 			flexcan1: can at 30a00000 {
 				compatible = "fsl,imx7d-flexcan", "fsl,imx6q-flexcan";
 				reg = <0x30a00000 0x10000>;
-- 
1.9.1
