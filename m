From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  9 Jul 2016 22:21:56 +0200
Subject: [PATCH 2/4] ARM: dts: sun8i: Extend Orange Pi Plus dt to also handle
 the Plus 2E
In-Reply-To: <1468095718-18515-1-git-send-email-hdegoede@redhat.com>
References: <1468095718-18515-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1468095718-18515-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a new Orange Pi Plus 2E available now, rather then adding yet
another dts file for this variant, extend the existing Plus / Plus2 dt
to also support this variant.

The 2E goes from 4 to 3 USB ports and drops the sata connector, so it
no longer has a USB hub or an USB <-> sata bridge on the board.

This commit enables all 3 ehci and ohci controllers to support the 3
USB connectors which are now directly connected to the SoC.

Downside of this approach is 4 unused USB busses now showing up on
the original Plus / Plus 2.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index b0cb417..28f74f6 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -44,7 +44,7 @@
 #include "sun8i-h3-orangepi-2.dts"
 
 / {
-	model = "Xunlong Orange Pi Plus";
+	model = "Xunlong Orange Pi Plus / Plus 2 / Plus 2E";
 	compatible = "xunlong,orangepi-plus", "allwinner,sun8i-h3";
 
 	reg_usb3_vbus: usb3-vbus {
@@ -60,6 +60,10 @@
 	};
 };
 
+&ehci2 {
+	status = "okay";
+};
+
 &ehci3 {
 	status = "okay";
 };
@@ -81,6 +85,18 @@
 	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 };
 
+&ohci1 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
 &pio {
 	usb3_vbus_pin_a: usb3_vbus_pin at 0 {
 		allwinner,pins = "PG11";
-- 
2.7.4
