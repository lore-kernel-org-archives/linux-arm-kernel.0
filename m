From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Mon, 22 Feb 2016 16:42:59 +0200
Subject: [PATCH] ARM: dts: omap3-n900: Allow gpio keys to be disabled
In-Reply-To: <20160212215326.GD19432@atomide.com>
References: <20160212215326.GD19432@atomide.com>
Message-ID: <1456152179-12558-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add linux,can-disable; to all gpios exported from gpio-keys driver, so
userspace can disable them

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 74d8f7eb..f01a151 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -68,6 +68,7 @@
 			linux,input-type = <5>; /* EV_SW */
 			linux,code = <0x09>; /* SW_CAMERA_LENS_COVER */
 			wakeup-source;
+			linux,can-disable;
 		};
 
 		camera_focus {
@@ -75,6 +76,7 @@
 			gpios = <&gpio3 4 GPIO_ACTIVE_LOW>; /* 68 */
 			linux,code = <0x210>; /* KEY_CAMERA_FOCUS */
 			wakeup-source;
+			linux,can-disable;
 		};
 
 		camera_capture {
@@ -82,6 +84,7 @@
 			gpios = <&gpio3 5 GPIO_ACTIVE_LOW>; /* 69 */
 			linux,code = <0xd4>; /* KEY_CAMERA */
 			wakeup-source;
+			linux,can-disable;
 		};
 
 		lock_button {
@@ -89,6 +92,7 @@
 			gpios = <&gpio4 17 GPIO_ACTIVE_LOW>; /* 113 */
 			linux,code = <0x98>; /* KEY_SCREENLOCK */
 			wakeup-source;
+			linux,can-disable;
 		};
 
 		keypad_slide {
@@ -97,6 +101,7 @@
 			linux,input-type = <5>; /* EV_SW */
 			linux,code = <0x0a>; /* SW_KEYPAD_SLIDE */
 			wakeup-source;
+			linux,can-disable;
 		};
 
 		proximity_sensor {
@@ -104,6 +109,7 @@
 			gpios = <&gpio3 25 GPIO_ACTIVE_HIGH>; /* 89 */
 			linux,input-type = <5>; /* EV_SW */
 			linux,code = <0x0b>; /* SW_FRONT_PROXIMITY */
+			linux,can-disable;
 		};
 	};
 
-- 
1.9.1
