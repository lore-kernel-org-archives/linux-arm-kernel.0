From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 25 Mar 2017 17:29:37 +0100
Subject: [PATCH 1/2] Documentation: dt-bindings: add a Meson8b compatible to
 the SAR ADC
In-Reply-To: <20170325162938.28659-1-martin.blumenstingl@googlemail.com>
References: <20170325162938.28659-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170325162938.28659-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson SAR ADC driver can be used on Meson8b as well
(probably on earlier SoC generations as well, but I don't have any
hardware available for testing that).
Add a separate compatible for Meson8b because it does not need any of
the BL30 magic (unlike the GX SoCs).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
index f9e3ff2c656e..84a931a0ff1f 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
@@ -2,6 +2,7 @@
 
 Required properties:
 - compatible:	depending on the SoC this should be one of:
+			- "amlogic,meson8b-saradc" for Meson8b
 			- "amlogic,meson-gxbb-saradc" for GXBB
 			- "amlogic,meson-gxl-saradc" for GXL
 			- "amlogic,meson-gxm-saradc" for GXM
-- 
2.12.1
