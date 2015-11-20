From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Nov 2015 14:24:52 +0100
Subject: [PATCH v2 7/7] ARM: dts: sun4i: Add touchscreen node to pov
 protab2-ips9 tablet
In-Reply-To: <1448025892-20899-1-git-send-email-hdegoede@redhat.com>
References: <1448025892-20899-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1448025892-20899-8-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node describing the touchscreen found on the pov protab2-ips9
tablet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
index 82e69c3..0e5124f 100644
--- a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
@@ -93,6 +93,22 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins_a>;
 	status = "okay";
+
+	pixcir_ts at 5c {
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_pins>;
+		compatible = "pixcir,pixcir_tangoc";
+		reg = <0x5c>;
+		interrupt-parent = <&pio>;
+		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>; /* EINT21 (PH21) */
+		attb-gpio = <&pio 7 21 GPIO_ACTIVE_HIGH>; /* PH21 */
+		enable-gpios = <&pio 0 5 GPIO_ACTIVE_LOW>;
+		wake-gpios = <&pio 1 13 GPIO_ACTIVE_LOW>;
+		touchscreen-size-x = <1024>;
+		touchscreen-size-y = <768>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
 };
 
 &lradc {
@@ -129,6 +145,13 @@
 };
 
 &pio {
+	touchscreen_pins: touchscreen_pins at 0 {
+		allwinner,pins = "PA5", "PB13";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		allwinner,pins = "PH4";
 		allwinner,function = "gpio_in";
-- 
2.5.0
