From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Mon, 30 Jan 2017 14:57:39 +0100
Subject: [PATCH 1/5] Documentation: dt: iio: document stm32 adc trigger
 polarity
In-Reply-To: <1485784663-19505-1-git-send-email-fabrice.gasnier@st.com>
References: <1485784663-19505-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1485784663-19505-2-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32 ADC trigger polarity can be set to either rising, falling
or both edges. Allow to configure it from dt.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
index 5dfc88e..6c6d968 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
@@ -57,6 +57,8 @@ Optional properties:
 - dmas: Phandle to dma channel for this ADC instance.
   See ../../dma/dma.txt for details.
 - dma-names: Must be "rx" when dmas property is being used.
+- st,trigger-polarity: Must be 0 (default), 1 or 2 to set default trigger
+  polarity to respectively "rising-edge", "falling-edge" or "both-edges".
 
 Example:
 	adc: adc at 40012000 {
@@ -84,6 +86,7 @@ Example:
 			st,adc-channels = <8>;
 			dmas = <&dma2 0 0 0x400 0x0>;
 			dma-names = "rx";
+			st,trigger-polarity = <1>;
 		};
 		...
 		other adc child nodes follow...
-- 
1.9.1
