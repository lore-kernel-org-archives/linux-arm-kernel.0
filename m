From: haibo.chen@freescale.com (Haibo Chen)
Date: Thu, 8 Oct 2015 18:59:05 +0800
Subject: [PATCH 2/5] Documentation: add the binding file for Freescale imx7d
 ADC driver
In-Reply-To: <1444301948-21721-1-git-send-email-haibo.chen@freescale.com>
References: <1444301948-21721-1-git-send-email-haibo.chen@freescale.com>
Message-ID: <1444301948-21721-2-git-send-email-haibo.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds the binding file for Freescale imx7d ADC driver.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 .../devicetree/bindings/iio/adc/imx7d-adc.txt      | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
new file mode 100644
index 0000000..6b21fd27
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
@@ -0,0 +1,26 @@
+Freescale imx7d ADC bindings
+
+The devicetree bingdings are for the nwe ADC driver written for
+imx7d SoC.
+
+Required properties:
+- compatible: Should be "fsl,imx7d-adc"
+- reg: Offset and length of the register set for the ADC device
+- interrupts: The interrupt number for the ADC device
+- clocks: The root clock of the ADC controller
+- clock-names: Must contain "adc", matching entry in the clocks property
+- vref-supply: The regulator supply ADC reference voltage
+
+Optional properties:
+- num-channels: the number of channels used
+
+Example:
+adc1: adc at 30610000 {
+	compatible = "fsl,imx7d-adc";
+	reg = <0x30610000 0x10000>;
+	interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clks IMX7D_ADC_ROOT_CLK>;
+	clock-names = "adc";
+	num-channels = <4>;
+	vref-supply = <&reg_vcc_3v3_mcu>;
+};
-- 
1.9.1
