From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 3 Nov 2015 14:25:36 -0200
Subject: [PATCH 1/2] ARM: dts: imx6sx: Pass the 'adck-max-frequency' property
Message-ID: <1446567937-15025-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify the 'adck-max-frequency' property in the adc nodes.

According to Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
this is a recommended property.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 167f77b..da42566 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1152,6 +1152,8 @@
 				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_IPG>;
 				clock-names = "adc";
+				fsl,adck-max-frequency = <30000000>, <40000000>,
+							 <20000000>;
 				status = "disabled";
                         };
 
@@ -1161,6 +1163,8 @@
 				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_IPG>;
 				clock-names = "adc";
+				fsl,adck-max-frequency = <30000000>, <40000000>,
+							 <20000000>;
 				status = "disabled";
                         };
 
-- 
1.9.1
