From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  6 Nov 2018 10:03:42 -0200
Subject: [PATCH 1/2] ARM: dts: imx6sx: Complete the PXP support
Message-ID: <1541505823-14375-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Documentation/devicetree/bindings/media/fsl-pxp.txt,
only one PXP clock needs to be described and it should be named
"axi".

Also pass the compatible string as suggested in the bindings doc.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 84b7687..b79b6c4 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1194,11 +1194,11 @@
 				};
 
 				pxp: pxp at 2218000 {
+					compatible = "fsl,imx6sx-pxp", "fsl,imx6ull-pxp";
 					reg = <0x02218000 0x4000>;
 					interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6SX_CLK_PXP_AXI>,
-						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
-					clock-names = "pxp-axi", "disp-axi";
+					clocks = <&clks IMX6SX_CLK_PXP_AXI>;
+					clock-names = "axi";
 					status = "disabled";
 				};
 
-- 
2.7.4
