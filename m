From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Tue, 9 Sep 2014 17:13:27 +0800
Subject: [PATCH V1 3/3] ARM: dts: imx6sl: add baud clock and clock-names for
 ssi
In-Reply-To: <cover.1410253534.git.shengjiu.wang@freescale.com>
References: <cover.1410253534.git.shengjiu.wang@freescale.com>
Message-ID: <67953db04c71ff8a7530e3457e8937458e1e246c.1410253534.git.shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Baud clock is used for bit clock generation in master mode. Ipg clock
is peripheral clock and peripheral access clock.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 arch/arm/boot/dts/imx6sl.dtsi |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index ba67714..dfd83e6 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -231,7 +231,9 @@
 							"fsl,imx51-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6SL_CLK_SSI1>;
+					clocks = <&clks IMX6SL_CLK_SSI1_IPG>,
+						 <&clks IMX6SL_CLK_SSI1>;
+					clock-names = "ipg", "baud";
 					dmas = <&sdma 37 1 0>,
 					       <&sdma 38 1 0>;
 					dma-names = "rx", "tx";
@@ -245,7 +247,9 @@
 							"fsl,imx51-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6SL_CLK_SSI2>;
+					clocks = <&clks IMX6SL_CLK_SSI2_IPG>,
+						 <&clks IMX6SL_CLK_SSI2>;
+					clock-names = "ipg", "baud";
 					dmas = <&sdma 41 1 0>,
 					       <&sdma 42 1 0>;
 					dma-names = "rx", "tx";
@@ -259,7 +263,9 @@
 							"fsl,imx51-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6SL_CLK_SSI3>;
+					clocks = <&clks IMX6SL_CLK_SSI3_IPG>,
+						 <&clks IMX6SL_CLK_SSI3>;
+					clock-names = "ipg", "baud";
 					dmas = <&sdma 45 1 0>,
 					       <&sdma 46 1 0>;
 					dma-names = "rx", "tx";
-- 
1.7.9.5
