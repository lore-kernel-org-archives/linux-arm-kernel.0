From: mka@chromium.org (Matthias Kaehlcke)
Date: Wed,  8 Aug 2018 12:13:37 -0700
Subject: [PATCH 1/3] dt-bindings: iio: vadc: Fix documentation of 'reg'
In-Reply-To: <20180808191339.16875-1-mka@chromium.org>
References: <20180808191339.16875-1-mka@chromium.org>
Message-ID: <20180808191339.16875-2-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The documentation of Qualcomm's SPMI PMIC voltage ADC claims that the
'reg' property consists of two values, the SPMI address and the length
of the controller's registers. However the SPMI bus to which it is added
specifies "#size-cells = <0>;". Remove the controller register length
from the documentation of the field and the example.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
index 0fb46137f936..d0c188e5c922 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
@@ -13,7 +13,7 @@ VADC node:
 - reg:
     Usage: required
     Value type: <prop-encoded-array>
-    Definition: VADC base address and length in the SPMI PMIC register map.
+    Definition: VADC base address in the SPMI PMIC register map.
 
 - #address-cells:
     Usage: required
@@ -104,7 +104,7 @@ Example:
 	/* VADC node */
 	pmic_vadc: vadc at 3100 {
 		compatible = "qcom,spmi-vadc";
-		reg = <0x3100 0x100>;
+		reg = <0x3100>;
 		interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.18.0.597.ga71716f1ad-goog
