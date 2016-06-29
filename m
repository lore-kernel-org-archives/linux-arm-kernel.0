From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 29 Jun 2016 20:47:00 +0200
Subject: [PATCH 2/4] ARM: dts: sun5i: Enable otg on the mk802
In-Reply-To: <1467226022-10525-1-git-send-email-hdegoede@redhat.com>
References: <1467226022-10525-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467226022-10525-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the otg controller, the id pin is not connected so enable
it in peripheral only mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s-mk802.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-mk802.dts b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
index 46ff940..0bb5755 100644
--- a/arch/arm/boot/dts/sun5i-a10s-mk802.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
@@ -87,6 +87,10 @@
 	status = "okay";
 };
 
+&otg_sram {
+	status = "okay";
+};
+
 &pio {
 	led_pins_mk802: led_pins at 0 {
 		allwinner,pins = "PB2";
@@ -122,6 +126,11 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
 &usbphy {
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
-- 
2.7.4
