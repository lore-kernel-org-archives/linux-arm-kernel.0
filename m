From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  4 Nov 2015 10:54:50 -0200
Subject: [PATCH] ARM: dts: imx6ul: Add ADC support
Message-ID: <1446641690-30927-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add support for ADC1.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index d00e994..11fc57e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -619,6 +619,18 @@
 				status = "disabled";
 			};
 
+			adc1: adc at 02198000 {
+				compatible = "fsl,imx6ul-adc", "fsl,vf610-adc";
+				reg = <0x02198000 0x4000>;
+				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_ADC1>;
+				num-channels = <2>;
+				clock-names = "adc";
+				fsl,adck-max-frequency = <30000000>, <40000000>,
+							 <20000000>;
+				status = "disabled";
+			};
+
 			i2c1: i2c at 021a0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
1.9.1
