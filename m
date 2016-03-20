From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Mar 2016 17:00:33 +0100
Subject: [PATCH 5/8] ARM: dts: sun8i: Enable IR receiver on Orangepi Plus
 boards
In-Reply-To: <1458489636-2825-1-git-send-email-hdegoede@redhat.com>
References: <1458489636-2825-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1458489636-2825-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the ir receiver found on the orangepi plus board.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index 1cb6c66..a680b1f 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -80,6 +80,12 @@
 	status = "okay";
 };
 
+&ir {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ir_pins_a>;
+	status = "okay";
+};
+
 &pio {
 	usb3_vbus_pin_a: usb3_vbus_pin at 0 {
 		allwinner,pins = "PG11";
-- 
2.7.3
