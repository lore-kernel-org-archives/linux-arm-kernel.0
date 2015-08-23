From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 24 Aug 2015 00:37:25 +0200
Subject: [PATCH 4/5] ARM: dts: sun4i: inet97fv2: Enable support for tablet keys
In-Reply-To: <1440369446-22195-1-git-send-email-hdegoede@redhat.com>
References: <1440369446-22195-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1440369446-22195-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for the tablet keys which are connected via the lradc.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index 309a0da..909fde9 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -47,6 +47,7 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "INet-97F Rev 02";
@@ -82,6 +83,46 @@
 
 #include "axp209.dtsi"
 
+&lradc {
+	vref-supply = <&reg_ldo2>;
+	status = "okay";
+
+	button at 200 {
+		label = "Menu";
+		linux,code = <KEY_MENU>;
+		channel = <0>;
+		voltage = <200000>;
+	};
+
+	button at 600 {
+		label = "Volume Up";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <600000>;
+	};
+
+	button at 800 {
+		label = "Volume Down";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <800000>;
+	};
+
+	button at 1000 {
+		label = "Home";
+		linux,code = <KEY_HOMEPAGE>;
+		channel = <0>;
+		voltage = <1000000>;
+	};
+
+	button at 1200 {
+		label = "Esc";
+		linux,code = <KEY_ESC>;
+		channel = <0>;
+		voltage = <1200000>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
-- 
2.4.3
