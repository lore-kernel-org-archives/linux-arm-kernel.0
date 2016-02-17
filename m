From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 17 Feb 2016 14:28:59 +0100
Subject: [PATCH 13/13] ARM: dts: imx6: Use correct SDMA script for SPI cores
In-Reply-To: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1455715739-25161-14-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the reference manual the shp_2_mcu / mcu_2_shp
scripts must be used for devices connected through the SPBA.

This fixes an issue we saw with DMA transfers from SPI NOR Flashes.
Sometimes the SPI controller RX FIFO was not empty after a DMA
transfer and the driver got stuck in the next PIO transfer when
it read one word more than expected.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 4f6ae92..06d2c4e 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -261,7 +261,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI1>,
 						 <&clks IMX6QDL_CLK_ECSPI1>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
+					dmas = <&sdma 3 8 1>, <&sdma 4 8 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -275,7 +275,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI2>,
 						 <&clks IMX6QDL_CLK_ECSPI2>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
+					dmas = <&sdma 5 8 1>, <&sdma 6 8 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -289,7 +289,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI3>,
 						 <&clks IMX6QDL_CLK_ECSPI3>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
+					dmas = <&sdma 7 8 1>, <&sdma 8 8 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -303,7 +303,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI4>,
 						 <&clks IMX6QDL_CLK_ECSPI4>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 9 7 1>, <&sdma 10 7 2>;
+					dmas = <&sdma 9 8 1>, <&sdma 10 8 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
-- 
2.7.0
