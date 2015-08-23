From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 24 Aug 2015 00:37:26 +0200
Subject: [PATCH 5/5] ARM: dts: sun4i: inet97fv2: Enable i2c1 and i2c2
 controllers
In-Reply-To: <1440369446-22195-1-git-send-email-hdegoede@redhat.com>
References: <1440369446-22195-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1440369446-22195-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable i2c1 and i2c2 controllers, these are used for the touchscreen resp.
the accelerometer.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index 909fde9..77c31da 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -83,6 +83,18 @@
 
 #include "axp209.dtsi"
 
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
 	vref-supply = <&reg_ldo2>;
 	status = "okay";
-- 
2.4.3
