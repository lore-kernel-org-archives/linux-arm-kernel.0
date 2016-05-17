From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 May 2016 23:56:08 +0800
Subject: [PATCH 3/6] ARM: dts: sun5i: q8-common: Enable USB-based WiFi
In-Reply-To: <1463500571-28970-1-git-send-email-wens@csie.org>
References: <1463500571-28970-1-git-send-email-wens@csie.org>
Message-ID: <1463500571-28970-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The early A13 Q8 tablets all use a Realtek WiFi module connected to
USB1. The module is powered by AXP209's LDO3 at 3.3V.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun5i-q8-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-q8-common.dtsi b/arch/arm/boot/dts/sun5i-q8-common.dtsi
index a78e189f6653..dcaaa085ac77 100644
--- a/arch/arm/boot/dts/sun5i-q8-common.dtsi
+++ b/arch/arm/boot/dts/sun5i-q8-common.dtsi
@@ -154,6 +154,12 @@
 	regulator-name = "avcc";
 };
 
+&reg_ldo3 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi";
+};
+
 &reg_usb0_vbus {
 	gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
 	status = "okay";
@@ -176,5 +182,6 @@
 	usb0_id_det-gpio = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
 	usb0_vbus_det-gpio = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
 	usb0_vbus-supply = <&reg_usb0_vbus>;
+	usb1_vbus-supply = <&reg_ldo3>;
 	status = "okay";
 };
-- 
2.8.1
