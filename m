From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 28 Feb 2016 11:20:26 +0100
Subject: [PATCH v3 3/4] ARM: dts: omap3-sniper: TWL4030 keypad support
In-Reply-To: <1456654827-11349-1-git-send-email-contact@paulk.fr>
References: <1456654827-11349-1-git-send-email-contact@paulk.fr>
Message-ID: <1456654827-11349-4-git-send-email-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the volume and gesture keys, using TWL4030 keypad.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/omap3-sniper.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-sniper.dts b/arch/arm/boot/dts/omap3-sniper.dts
index 21d6afa..7f38d58 100644
--- a/arch/arm/boot/dts/omap3-sniper.dts
+++ b/arch/arm/boot/dts/omap3-sniper.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "omap36xx.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "LG Optimus Black";
@@ -226,6 +227,14 @@
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
 
+&twl_keypad {
+	linux,keymap = <
+		MATRIX_KEY(0x00, 0x00, KEY_VOLUMEUP)
+		MATRIX_KEY(0x01, 0x00, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x02, 0x00, KEY_SELECT)
+	>;
+};
+
 /*
  * The TWL4030 VAUX2 and VDAC regulators power sensors that are slaves on I2C3.
  * When not powered, these sensors cause the I2C3 clock to stay low at all times,
-- 
2.6.4
