From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  1 Mar 2016 08:14:02 +0100
Subject: [PATCH] ARM: dts: imx53-qsb: Fix gpio button polarity
Message-ID: <1456816442-29104-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The polarity of the gpio buttons is defined to '0' which is
active high. The buttons are active low though which has been verified by
testing it and by looking into the schematics. While at it use
defines rathers than numbers for the key codes.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx53-qsb-common.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index 53fd75c..e340bcc 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -59,21 +59,21 @@
 
 		power {
 			label = "Power Button";
-			gpios = <&gpio1 8 0>;
-			linux,code = <116>; /* KEY_POWER */
+			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
 		};
 
 		volume-up {
 			label = "Volume Up";
-			gpios = <&gpio2 14 0>;
-			linux,code = <115>; /* KEY_VOLUMEUP */
+			gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
 			gpio-key,wakeup;
 		};
 
 		volume-down {
 			label = "Volume Down";
-			gpios = <&gpio2 15 0>;
-			linux,code = <114>; /* KEY_VOLUMEDOWN */
+			gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
 			gpio-key,wakeup;
 		};
 	};
-- 
2.7.0
