From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Fri, 31 Mar 2017 14:32:37 +0200
Subject: [PATCH v2 1/2] dt-bindings: iio: stm32-adc: add option to set
 resolution
In-Reply-To: <1490963559-32159-1-git-send-email-fabrice.gasnier@st.com>
References: <1490963559-32159-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1490963559-32159-2-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for 'assigned-resolution-bits' dt optional property.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- rename property from 'st,adc-res' to 'assigned-resolution-bits' so it
  is more common.
---
 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
index 5dfc88e..e35f9f1 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
@@ -57,6 +57,9 @@ Optional properties:
 - dmas: Phandle to dma channel for this ADC instance.
   See ../../dma/dma.txt for details.
 - dma-names: Must be "rx" when dmas property is being used.
+- assigned-resolution-bits: Resolution (bits) to use for conversions. Must
+  match device available resolutions (e.g. can be 6, 8, 10 or 12 on stm32f4).
+  Default is maximum resolution if unset.
 
 Example:
 	adc: adc at 40012000 {
@@ -84,6 +87,7 @@ Example:
 			st,adc-channels = <8>;
 			dmas = <&dma2 0 0 0x400 0x0>;
 			dma-names = "rx";
+			assigned-resolution-bits = <8>;
 		};
 		...
 		other adc child nodes follow...
-- 
1.9.1
