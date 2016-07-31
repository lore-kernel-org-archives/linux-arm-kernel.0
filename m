From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 31 Jul 2016 17:23:10 +0200
Subject: [PATCH 4/4] ARM: dts: sun4i: Describe softbuttons in dserve-dsrv9703c
 touchscreen node
In-Reply-To: <1469978590-14081-1-git-send-email-hdegoede@redhat.com>
References: <1469978590-14081-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1469978590-14081-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dserve-dsrv9703c touchscreen has 3 softbuttons, describe these
in the dts.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts | 49 ++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
index 893497e..92e15e4 100644
--- a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
+++ b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
@@ -78,6 +78,18 @@
 		max-microvolt = <3000000>;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins>;
+
+		touchscreen_softbuttons_led {
+			label = "dsrv9703c:white:touschscreen-softbuttons";
+			gpios = <&pio 0 5 GPIO_ACTIVE_HIGH>; /* PA5 */
+			linux,default-trigger = "touschscreen-softbuttons";
+		};
+	};
+
 	reg_motor: reg_motor {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -140,6 +152,36 @@
 		reset-gpios = <&pio 1 13 GPIO_ACTIVE_LOW>;
 		touchscreen-size-x = <1024>;
 		touchscreen-size-y = <768>;
+
+		button at 0 {
+			label = "Esc";
+			linux,code = <KEY_ESC>;
+			softbutton-min-x = <1084>;
+			softbutton-max-x = <1098>;
+			softbutton-min-y = <0>;
+			softbutton-max-y = <49>;
+			linux,led-trigger = "touschscreen-softbuttons";
+		};
+
+		button at 1 {
+			label = "Home";
+			linux,code = <KEY_HOMEPAGE>;
+			softbutton-min-x = <1084>;
+			softbutton-max-x = <1098>;
+			softbutton-min-y = <50>;
+			softbutton-max-y = <99>;
+			linux,led-trigger = "touschscreen-softbuttons";
+		};
+
+		button at 2 {
+			label = "Menu";
+			linux,code = <KEY_MENU>;
+			softbutton-min-x = <1084>;
+			softbutton-max-x = <1098>;
+			softbutton-min-y = <100>;
+			softbutton-max-y = <149>;
+			linux,led-trigger = "touschscreen-softbuttons";
+		};
 	};
 };
 
@@ -191,6 +233,13 @@
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
+	led_pins: led_pins at 0 {
+		allwinner,pins = "PA5";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	motor_pins: motor_pins at 0 {
 		allwinner,pins = "PB3";
 		allwinner,function = "gpio_out";
-- 
2.7.4
