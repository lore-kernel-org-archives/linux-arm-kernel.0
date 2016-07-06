From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  6 Jul 2016 17:10:42 +0800
Subject: [PATCH 1/9] ARM: dts: sun7i: lamobo-r1: Fix USB-based WiFi module
 power
In-Reply-To: <1467796250-22010-1-git-send-email-wens@csie.org>
References: <1467796250-22010-1-git-send-email-wens@csie.org>
Message-ID: <1467796250-22010-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Lamobo R1, USB2 is connected to the RTL8192CU WiFi module.
The power enable pin is connected to PH12.

Fix the enable pin the reg_usb2_vbus.

Also disable ohci1, as the WiFi module is USB 2.0 capable.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
index fbca93406e1b..285142882a80 100644
--- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
+++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
@@ -212,10 +212,6 @@
 	status = "okay";
 };
 
-&ohci1 {
-	status = "okay";
-};
-
 &otg_sram {
 	status = "okay";
 };
@@ -291,6 +287,7 @@
 };
 
 &reg_usb2_vbus {
+	gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>; /* PH12 */
 	status = "okay";
 };
 
@@ -329,6 +326,10 @@
 	status = "okay";
 };
 
+&usb2_vbus_pin_a {
+	allwinner,pins = "PH12";
+};
+
 &usbphy {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb0_id_detect_pin>;
-- 
2.8.1
