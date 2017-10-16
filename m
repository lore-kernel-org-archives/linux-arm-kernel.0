From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 16 Oct 2017 20:34:04 -0200
Subject: [PATCH 4/4] ARM: dts: imx50: Pass the 'dma-cells' property
In-Reply-To: <1508193244-14599-1-git-send-email-festevam@gmail.com>
References: <1508193244-14599-1-git-send-email-festevam@gmail.com>
Message-ID: <1508193244-14599-4-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Pass the '#dma-cells' property in the sdma node, so that the following
build warning is gone:

  DTC     arch/arm/boot/dts/imx50-evk.dtb
arch/arm/boot/dts/imx50-evk.dtb: Warning (dmas_property): Missing property '#dma-cells' in node /soc/aips at 60000000/sdma at 63fb0000 or bad phandle (referred from /soc/aips at 50000000/spba at 50000000/ssi at 50014000:dmas[0])

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx50.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 3747d80..30edf9a 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -443,6 +443,7 @@
 				clocks = <&clks IMX5_CLK_SDMA_GATE>,
 					 <&clks IMX5_CLK_SDMA_GATE>;
 				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx50.bin";
 			};
 
-- 
2.7.4
