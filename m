From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 4 Jul 2014 14:46:01 +0800
Subject: [PATCH] ARM: dts: imx: correct sdma compatbile for imx6sl and imx6sx
Message-ID: <1404456361-8197-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SDMA on imx6sl and imx6sx is more compatible with imx6q one than
imx35.  Let's use "fsl,imx6q-sdma" instead of "fsl,imx35-sdma", so that
SDMA ROM script on imx6sl and imx6sx can work for audio driver just like
the case of imx6q.

Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Thanks to Robin for finding this out.

 arch/arm/boot/dts/imx6sl.dtsi | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c0ee12f1f171..0467ac064e9d 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -608,7 +608,7 @@
 			};
 
 			sdma: sdma at 020ec000 {
-				compatible = "fsl,imx6sl-sdma", "fsl,imx35-sdma";
+				compatible = "fsl,imx6sl-sdma", "fsl,imx6q-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SL_CLK_SDMA>,
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 92d48becdb45..0c5094adedfa 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -706,7 +706,7 @@
 			};
 
 			sdma: sdma at 020ec000 {
-				compatible = "fsl,imx6sx-sdma", "fsl,imx35-sdma";
+				compatible = "fsl,imx6sx-sdma", "fsl,imx6q-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_SDMA>,
-- 
1.8.3.2
