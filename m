From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Nov 2015 14:47:13 +0100
Subject: [PATCH 4/4] ARM: dts: sun4i: Enable onboard codec used on the pov
 protab2-ips9 tablet
In-Reply-To: <1448027233-750-1-git-send-email-hdegoede@redhat.com>
References: <1448027233-750-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1448027233-750-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pov protab2-ips9 tablet uses the A10's integrated audio codec,
enable it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
index 1f92ec7..30d78a6 100644
--- a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
@@ -72,6 +72,13 @@
 	};
 };
 
+&codec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&codec_pa_pin>;
+	pa-gpios = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 };
@@ -163,6 +170,13 @@
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 
+	codec_pa_pin: codec_pa_pin at 0 {
+		allwinner,pins = "PH15";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	touchscreen_pins: touchscreen_pins at 0 {
 		allwinner,pins = "PA5", "PB13";
 		allwinner,function = "gpio_out";
-- 
2.5.0
