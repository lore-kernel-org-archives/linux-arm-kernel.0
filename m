From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 2 Sep 2014 15:00:43 -0300
Subject: [PATCH v2 1/2] ARM: dts: imx6sx: Add LCDIF compatible strings
Message-ID: <1409680844-24747-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx6sx has the same LCDIF controller IP as in mx28, so add the proper
compatible strings.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 arch/arm/boot/dts/imx6sx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 63d9d82..d137caca 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1065,6 +1065,7 @@
 				};
 
 				lcdif1: lcdif at 02220000 {
+					compatible = "fsl,imx6sx-lcdif", "fsl,imx28-lcdif";
 					reg = <0x02220000 0x4000>;
 					interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SX_CLK_LCDIF1_PIX>,
@@ -1075,6 +1076,7 @@
 				};
 
 				lcdif2: lcdif at 02224000 {
+					compatible = "fsl,imx6sx-lcdif", "fsl,imx28-lcdif";
 					reg = <0x02224000 0x4000>;
 					interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SX_CLK_LCDIF2_PIX>,
-- 
1.9.1
