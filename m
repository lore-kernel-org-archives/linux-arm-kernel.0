From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 20 Jan 2016 11:09:03 +0100
Subject: [PATCHv2 10/16] ARM: dts: imx6ul: add sai support
In-Reply-To: <1453284549-16363-1-git-send-email-LW@KARO-electronics.de>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
 <1453284549-16363-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1453284549-16363-11-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device nodes for the i.MX6UL synchronous audio interfaces (SAI).

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6ul.dtsi | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 9c873a6..e1fda39e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -235,6 +235,51 @@
 					clock-names = "ipg", "per";
 					status = "disabled";
 				};
+
+				sai1: sai at 02028000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx6ul-sai", "fsl,imx6sx-sai";
+					reg = <0x02028000 0x4000>;
+					interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_SAI1_IPG>,
+						 <&clks IMX6UL_CLK_SAI1>,
+						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma 35 24 0>,
+					       <&sdma 36 24 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
+				sai2: sai at 0202c000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx6ul-sai", "fsl,imx6sx-sai";
+					reg = <0x0202c000 0x4000>;
+					interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_SAI2_IPG>,
+						 <&clks IMX6UL_CLK_SAI2>,
+						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma 37 24 0>,
+					       <&sdma 38 24 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
+				sai3: sai at 02030000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx6ul-sai", "fsl,imx6sx-sai";
+					reg = <0x02030000 0x4000>;
+					interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_SAI3_IPG>,
+						 <&clks IMX6UL_CLK_SAI3>,
+						 <&clks IMX6UL_CLK_DUMMY>, <&clks IMX6UL_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma 39 24 0>,
+					       <&sdma 40 24 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 			};
 
 			tsc: tsc at 02040000 {
-- 
2.1.4
