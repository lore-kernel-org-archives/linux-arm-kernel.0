From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 13 Nov 2014 10:31:49 +0100
Subject: [PATCH 7/7] ARM: dts: sun6i: Add support for the status led
In-Reply-To: <1415871109-28332-1-git-send-email-hdegoede@redhat.com>
References: <1415871109-28332-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1415871109-28332-7-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Mele M9 / A1000G quad has a blue status led, add support for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31-m9.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index c85247e..43f8f18 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -46,6 +46,12 @@
 		};
 
 		pio: pinctrl at 01c20800 {
+			led_pins_m9: led_pins at 0 {
+				allwinner,pins = "PH13";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 			mmc0_cd_pin_m9: mmc0_cd_pin at 0 {
 				allwinner,pins = "PH22";
 				allwinner,function = "gpio_in";
@@ -67,6 +73,17 @@
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_m9>;
+
+		blue {
+			label = "m9:blue:usr";
+			gpios = <&pio 7 13 0>;
+		};
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb1_vbus_pin_m9>;
-- 
2.1.0
