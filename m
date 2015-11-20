From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Nov 2015 12:17:12 +0100
Subject: [PATCH 6/7] ARM: dts: sun4i: Add touchscreen node to iNet1 tablet
In-Reply-To: <1448018233-27824-1-git-send-email-hdegoede@redhat.com>
References: <1448018233-27824-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1448018233-27824-7-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node describing the touchscreen controller used on the iNet1 tablet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-inet1.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-inet1.dts b/arch/arm/boot/dts/sun4i-a10-inet1.dts
index 487ce63..703d756 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet1.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet1.dts
@@ -104,6 +104,19 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins_a>;
 	status = "okay";
+
+	ft5x: touchscreen at 38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		interrupt-parent = <&pio>;
+		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touchscreen_wake_pin>;
+		wake-gpios = <&pio 1 13 GPIO_ACTIVE_HIGH>; /* PB13 */
+		touchscreen-size-x = <600>;
+		touchscreen-size-y = <1024>;
+		touchscreen-swapped-x-y;
+	};
 };
 
 &lradc {
@@ -151,6 +164,13 @@
 };
 
 &pio {
+	touchscreen_wake_pin: touchscreen_wake_pin at 0 {
+		allwinner,pins = "PB13";
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
