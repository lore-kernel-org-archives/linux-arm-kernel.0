From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 15 Feb 2017 17:55:56 +0100
Subject: [PATCH 1/2] dt-bindings: iio: stm32-adc: add option to set resolution
In-Reply-To: <1487177757-19427-1-git-send-email-fabrice.gasnier@st.com>
References: <1487177757-19427-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1487177757-19427-2-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for 'st,adc-res' dt optional property.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
index 5dfc88e..45f7ff2 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
@@ -57,6 +57,9 @@ Optional properties:
 - dmas: Phandle to dma channel for this ADC instance.
   See ../../dma/dma.txt for details.
 - dma-names: Must be "rx" when dmas property is being used.
+- st,adc-res: Resolution (bits) to use for conversions. Must match device
+  available resolutions (e.g. can be 6, 8, 10 or 12 on stm32f4). Default
+  is maximum resolution if unset.
 
 Example:
 	adc: adc at 40012000 {
@@ -84,6 +87,7 @@ Example:
 			st,adc-channels = <8>;
 			dmas = <&dma2 0 0 0x400 0x0>;
 			dma-names = "rx";
+			st,adc-res = <8>;
 		};
 		...
 		other adc child nodes follow...
-- 
1.9.1
