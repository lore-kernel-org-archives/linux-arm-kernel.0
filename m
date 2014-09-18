From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 18 Sep 2014 20:23:48 -0300
Subject: [PATCH 1/2] ARM: dts: imx53: Improve SSI clocks description
Message-ID: <1411082629-25860-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

SSI block has 'ipg' clock for internal peripheral access and also 'baud' clock
for generating bit clock when SSI operates in master mode.

Add the extra 'baud' clock so that we can have SSI functional in master mode. 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx53.dtsi | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 6b198c6d..5040dae 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -227,7 +227,9 @@
 							"fsl,imx21-ssi";
 					reg = <0x50014000 0x4000>;
 					interrupts = <30>;
-					clocks = <&clks IMX5_CLK_SSI2_IPG_GATE>;
+					clocks = <&clks IMX5_CLK_SSI2_IPG_GATE>,
+						 <&clks IMX5_CLK_SSI2_ROOT_GATE>;
+					clock-names = "ipg", "baud";
 					dmas = <&sdma 24 1 0>,
 					       <&sdma 25 1 0>;
 					dma-names = "rx", "tx";
@@ -667,7 +669,9 @@
 						"fsl,imx21-ssi";
 				reg = <0x63fcc000 0x4000>;
 				interrupts = <29>;
-				clocks = <&clks IMX5_CLK_SSI1_IPG_GATE>;
+				clocks = <&clks IMX5_CLK_SSI1_IPG_GATE>,
+					 <&clks IMX5_CLK_SSI1_ROOT_GATE>;
+				clock-names = "ipg", "baud";
 				dmas = <&sdma 28 0 0>,
 				       <&sdma 29 0 0>;
 				dma-names = "rx", "tx";
@@ -695,7 +699,9 @@
 						"fsl,imx21-ssi";
 				reg = <0x63fe8000 0x4000>;
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
