From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 24 Aug 2015 00:37:23 +0200
Subject: [PATCH 2/5] ARM: dts: sun4i: inet97fv2: Add regulator nodes
In-Reply-To: <1440369446-22195-1-git-send-email-hdegoede@redhat.com>
References: <1440369446-22195-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1440369446-22195-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use axp209.dtsi and add regulator nodes for the regulators used on the
inet97fv2 tablet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts | 35 +++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index 51621c5..69e22bd 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -61,6 +61,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &ehci1 {
 	status = "okay";
 };
@@ -71,15 +75,13 @@
 	status = "okay";
 
 	axp209: pmic at 34 {
-		compatible = "x-powers,axp209";
 		reg = <0x34>;
 		interrupts = <0>;
-
-		interrupt-controller;
-		#interrupt-cells = <1>;
 	};
 };
 
+#include "axp209.dtsi"
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
@@ -90,6 +92,31 @@
 	status = "okay";
 };
 
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1250000>;
+	regulator-max-microvolt = <1250000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
 &reg_usb2_vbus {
 	status = "okay";
 };
-- 
2.4.3
