From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  5 Jun 2015 21:02:23 +0200
Subject: [PATCH 20/20] ARM: dts: sun8i: sina33: Enable USB hosts
In-Reply-To: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
References: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1433530943-12599-21-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen-Yu Tsai <wens@csie.org>

The Sina33 SDK board exposes the EHCI/OHCI USB host pair.
VBUS for this port is always on and non-controllable.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index 5788c29..1d5390d 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -63,6 +63,10 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &lradc {
 	vref-supply = <&reg_vcc3v0>;
 	status = "okay";
@@ -113,6 +117,10 @@
 	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &pio {
 	mmc0_cd_pin_sina33: mmc0_cd_pin at 0 {
 		allwinner,pins = "PB4";
@@ -127,3 +135,8 @@
 	pinctrl-0 = <&uart0_pins_b>;
 	status = "okay";
 };
+
+&usbphy {
+	status = "okay";
+	usb1_vbus-supply = <&reg_vcc5v0>; /* USB1 VBUS is always on */
+};
-- 
2.4.2
