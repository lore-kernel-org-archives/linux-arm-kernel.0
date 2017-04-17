From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 17 Apr 2017 20:28:18 +0200
Subject: [PATCH 1/3] Documentation: dt-bindings: iio: adc: add Meson8 and
 Meson8b support
In-Reply-To: <20170417182820.26670-1-martin.blumenstingl@googlemail.com>
References: <20170417182820.26670-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170417182820.26670-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson SAR ADC driver can be used on Meson8 and Meson8b
(probably on earlier SoC generations as well, but I don't have any
hardware available for testing that).
Add a separate compatible for Meson8 and Meson8b because it does not
need any of the BL30 magic (unlike the GX SoCs).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
index f9e3ff2c656e..08cee82e54c3 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
@@ -2,6 +2,8 @@
 
 Required properties:
 - compatible:	depending on the SoC this should be one of:
+			- "amlogic,meson8-saradc" for Meson8
+			- "amlogic,meson8b-saradc" for Meson8b
 			- "amlogic,meson-gxbb-saradc" for GXBB
 			- "amlogic,meson-gxl-saradc" for GXL
 			- "amlogic,meson-gxm-saradc" for GXM
-- 
2.12.2
