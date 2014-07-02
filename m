From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  2 Jul 2014 11:58:49 -0300
Subject: [PATCH v2 1/4] ARM: dts: imx6sx: Fix sdma node
Message-ID: <1404313132-14400-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Use the correct compatible string for sdma and also provide the sdma firmware
path.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 arch/arm/boot/dts/imx6sx.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index a7d74e7..2929078 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -703,13 +703,15 @@
 			};
 
 			sdma: sdma at 020ec000 {
-				compatible = "fsl,imx6sx-sdma";
+				compatible = "fsl,imx6sx-sdma", "fsl,imx35-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_SDMA>,
 					 <&clks IMX6SX_CLK_SDMA>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
+				/* imx6sx reuses imx6q sdma firmware */
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";
 			};
 		};
 
-- 
1.8.3.2
