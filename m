From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 13 Jan 2015 11:47:04 +0100
Subject: [PATCH 2/2] ARM: dts: sun8i: Enable lradc on a23-ippo-q8h-v5
In-Reply-To: <1421146024-17957-1-git-send-email-hdegoede@redhat.com>
References: <1421146024-17957-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1421146024-17957-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The a23-ippo-q8h tablets have volume up/down buttons using the lradc. This
has been tested on both a v5 and a v1.2 tablet.

Tested-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
index 1da31d0..623573e 100644
--- a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
+++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
@@ -52,6 +52,7 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -86,6 +87,25 @@
 			};
 		};
 
+		lradc: lradc at 01c22800 {
+			vref-supply = <&reg_vcc3v0>;
+			status = "okay";
+
+			button at 200 {
+				label = "Volume Up";
+				linux,code = <KEY_VOLUMEUP>;
+				channel = <0>;
+				voltage = <200000>;
+			};
+
+			button at 400 {
+				label = "Volume Down";
+				linux,code = <KEY_VOLUMEDOWN>;
+				channel = <0>;
+				voltage = <400000>;
+			};
+		};
+
 		i2c0: i2c at 01c2ac00 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
-- 
2.1.0
