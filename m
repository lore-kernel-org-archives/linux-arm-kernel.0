From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 12 Jan 2016 18:21:28 +0100
Subject: [PATCH 11/14] ARM: dts: imx6ul: add sai support
In-Reply-To: <1452619291-13625-11-git-send-email-LW@KARO-electronics.de>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-2-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-3-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-4-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-5-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-6-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-7-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-8-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-9-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-10-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-11-git-send-email-LW@KARO-electronics.de>
Message-ID: <1452619291-13625-12-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6ul.dtsi | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index f1db53e..3d43321f 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -235,6 +235,51 @@
 					clock-names = "ipg", "per";
 					status = "disabled";
 				};
+
+				sai1: sai at 02028000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx6sx-sai";
+					reg = <0x02028000 0x4000>;
+					interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_SAI1_IPG>,
+						 <&clks IMX6UL_CLK_SAI1>,
+						 <&clks 0>, <&clks 0>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma 35 24 0>,
+					       <&sdma 36 24 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
+				sai2: sai at 0202c000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx6sx-sai";
+					reg = <0x0202c000 0x4000>;
+					interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_SAI2_IPG>,
+						 <&clks IMX6UL_CLK_SAI2>,
+						 <&clks 0>, <&clks 0>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma 37 24 0>,
+					       <&sdma 38 24 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
+				sai3: sai at 02030000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx6sx-sai";
+					reg = <0x02030000 0x4000>;
+					interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_SAI3_IPG>,
+						 <&clks IMX6UL_CLK_SAI3>,
+						 <&clks 0>, <&clks 0>;
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
