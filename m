From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 18 Sep 2014 20:23:49 -0300
Subject: [PATCH 2/2] ARM: dts: imx51: Improve SSI clocks description
In-Reply-To: <1411082629-25860-1-git-send-email-festevam@gmail.com>
References: <1411082629-25860-1-git-send-email-festevam@gmail.com>
Message-ID: <1411082629-25860-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

SSI block has 'ipg' clock for internal peripheral access and also 'baud' clock
for generating bit clock when SSI operates in master mode.

Add the extra 'baud' clock so that we can have SSI functional in master mode.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx51.dtsi | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 92660e1..c0116cf 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -214,7 +214,9 @@
 					compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
 					reg = <0x70014000 0x4000>;
 					interrupts = <30>;
-					clocks = <&clks IMX5_CLK_SSI2_IPG_GATE>;
+					clocks = <&clks IMX5_CLK_SSI2_IPG_GATE>,
+						 <&clks IMX5_CLK_SSI2_ROOT_GATE>;
+					clock-names = "ipg", "baud";
 					dmas = <&sdma 24 1 0>,
 					       <&sdma 25 1 0>;
 					dma-names = "rx", "tx";
@@ -504,7 +506,9 @@
 				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
 				reg = <0x83fcc000 0x4000>;
 				interrupts = <29>;
-				clocks = <&clks IMX5_CLK_SSI1_IPG_GATE>;
+				clocks = <&clks IMX5_CLK_SSI1_IPG_GATE>,
+					 <&clks IMX5_CLK_SSI1_ROOT_GATE>;
+				clock-names = "ipg", "baud";
 				dmas = <&sdma 28 0 0>,
 				       <&sdma 29 0 0>;
 				dma-names = "rx", "tx";
@@ -560,7 +564,9 @@
 				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
 				reg = <0x83fe8000 0x4000>;
 				interrupts = <96>;
-				clocks = <&clks IMX5_CLK_SSI3_IPG_GATE>;
+				clocks = <&clks IMX5_CLK_SSI3_IPG_GATE>,
+					 <&clks IMX5_CLK_SSI3_ROOT_GATE>;
+				clock-names = "ipg", "baud";
 				dmas = <&sdma 46 0 0>,
 				       <&sdma 47 0 0>;
 				dma-names = "rx", "tx";
-- 
1.9.1
