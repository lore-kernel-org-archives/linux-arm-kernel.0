From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  8 Mar 2016 09:26:12 -0300
Subject: [PATCH 1/3] ARM: dts: imx6sx: Fix SAI DMA index
Message-ID: <1457439974-1149-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

According to sdma_peripheral_type in include/linux/platform_data/dma-imx.h
IMX_DMATYPE_SAI corresponds to index 24, so fix it accordingly.

Suggested-by: Zidan Wang <zidan.wang@nxp.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index a5f7602..c8269e7 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -970,7 +970,7 @@
 					 <&clks 0>, <&clks 0>;
 				clock-names = "bus", "mclk1", "mclk2", "mclk3";
 				dma-names = "rx", "tx";
-				dmas = <&sdma 31 23 0>, <&sdma 32 23 0>;
+				dmas = <&sdma 31 24 0>, <&sdma 32 24 0>;
 				dma-source = <&gpr 0 15 0 16>;
 				status = "disabled";
 			};
@@ -990,7 +990,7 @@
 					 <&clks 0>, <&clks 0>;
 				clock-names = "bus", "mclk1", "mclk2", "mclk3";
 				dma-names = "rx", "tx";
-				dmas = <&sdma 33 23 0>, <&sdma 34 23 0>;
+				dmas = <&sdma 33 24 0>, <&sdma 34 24 0>;
 				dma-source = <&gpr 0 17 0 18>;
 				status = "disabled";
 			};
-- 
1.9.1
