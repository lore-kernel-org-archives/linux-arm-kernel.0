From: xiaoning.wang@nxp.com (Clark Wang)
Date: Tue, 23 Oct 2018 08:36:17 +0000
Subject: [PATCH] ARM: dts: fix imx7d boot spi dma setup error
Message-ID: <20181023083356.17579-1-xiaoning.wang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dmas and dma-names for ecspi1~4 to fix kernel boot error:
"spi_imx 30840000.ecspi: dma setup error -19, use pio".

Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index aa8df7d93b2e..043e39124c43 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -651,6 +651,8 @@
 				clocks = <&clks IMX7D_ECSPI4_ROOT_CLK>,
 					<&clks IMX7D_ECSPI4_ROOT_CLK>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 6 7 1>, <&sdma 7 7 2>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -732,6 +734,8 @@
 					clocks = <&clks IMX7D_ECSPI1_ROOT_CLK>,
 						<&clks IMX7D_ECSPI1_ROOT_CLK>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 0 7 1>, <&sdma 1 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -744,6 +748,8 @@
 					clocks = <&clks IMX7D_ECSPI2_ROOT_CLK>,
 						<&clks IMX7D_ECSPI2_ROOT_CLK>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 2 7 1>, <&sdma 3 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -756,6 +762,8 @@
 					clocks = <&clks IMX7D_ECSPI3_ROOT_CLK>,
 						<&clks IMX7D_ECSPI3_ROOT_CLK>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 4 7 1>, <&sdma 5 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
-- 
2.17.1
