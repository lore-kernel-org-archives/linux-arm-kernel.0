From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  8 Aug 2015 17:38:54 +0200
Subject: [PATCH] ARM: dts: sun4i: Enable i2c1 and i2c2 on the Chuwi V7-CW0825
 tablet
Message-ID: <1439048334-14704-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i2c1 has a freescale mma7660 accelerometer connected to it at addr 0x4c,
i2c2 has a ft5x touchscreen connected to it at addr 0x38.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
index 1430568..5366089 100644
--- a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
+++ b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
@@ -78,6 +78,18 @@
 	};
 };
 
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+};
+
 &lradc {
 	vref-supply = <&reg_vcc3v0>;
 	status = "okay";
-- 
2.4.3
