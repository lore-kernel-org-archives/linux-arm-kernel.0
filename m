From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Sep 2015 11:21:19 -0400
Subject: [PATCH v2] ARM: dts: sun5i: Add backlight node to sun5i-q8-common.dtsi
Message-ID: <1442762479-11424-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All A13 based q8 formfactor tablets use the same backlight setup, add
a backlight devicetree node for controlling the backlight on these devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Drop the comment about DCDC1SW, the axp209 used on A13 boards does not
 have a DCDC1SW
---
 arch/arm/boot/dts/sun5i-q8-common.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-q8-common.dtsi b/arch/arm/boot/dts/sun5i-q8-common.dtsi
index 0641d68..a78e189 100644
--- a/arch/arm/boot/dts/sun5i-q8-common.dtsi
+++ b/arch/arm/boot/dts/sun5i-q8-common.dtsi
@@ -41,11 +41,21 @@
  */
 #include "sunxi-q8-common.dtsi"
 
+#include <dt-bindings/pwm/pwm.h>
+
 / {
 	aliases {
 		serial0 = &uart1;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
+		default-brightness-level = <8>;
+		/* TODO: backlight uses axp gpio1 as enable pin */
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-- 
2.4.3
