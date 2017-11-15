From: eugen.hristev@microchip.com (Eugen Hristev)
Date: Wed, 15 Nov 2017 14:56:45 +0200
Subject: [PATCH v3 1/4] dt-bindings: iio: at91-sama5d2_adc: add optional dma
 property
In-Reply-To: <1510750608-8697-1-git-send-email-eugen.hristev@microchip.com>
References: <1510750608-8697-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <1510750608-8697-2-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added property for DMA configuration of the device.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Changes in v3:
None, but we discussed on the ML about whether we should have "dma-names"
present in the binding even if it's only one.
The helpers in the kernel to retrieve the channel info rely on the
presence of this property, so I am resending the patch based on this.
If another solution is better, please advise and I can try it and
resend the patch.

 Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
index 552e7a8..6469a4c 100644
--- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
@@ -17,6 +17,11 @@ Required properties:
   This property uses the IRQ edge types values: IRQ_TYPE_EDGE_RISING ,
   IRQ_TYPE_EDGE_FALLING or IRQ_TYPE_EDGE_BOTH
 
+Optional properties:
+  - dmas: Phandle to dma channel for the ADC.
+  - dma-names: Must be "rx" when dmas property is being used.
+  See ../../dma/dma.txt for details.
+
 Example:
 
 adc: adc at fc030000 {
@@ -31,4 +36,6 @@ adc: adc at fc030000 {
 	vddana-supply = <&vdd_3v3_lp_reg>;
 	vref-supply = <&vdd_3v3_lp_reg>;
 	atmel,trigger-edge-type = <IRQ_TYPE_EDGE_BOTH>;
+	dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) | AT91_XDMAC_DT_PERID(25))>;
+	dma-names = "rx";
 }
-- 
2.7.4
