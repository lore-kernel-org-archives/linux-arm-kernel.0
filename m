From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 15 Nov 2016 21:51:06 +0800
Subject: [PATCH v2 3/3] ARM: dts: sun7i: bananapi-m1-plus: Enable USB OTG
In-Reply-To: <20161115135106.438-1-wens@csie.org>
References: <20161115135106.438-1-wens@csie.org>
Message-ID: <20161115135106.438-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Bananapi M1+ supports USB OTG, with the PMIC doing VBUS sensing.
Enable the USB OTG related functions.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index ac19630c1c23..5f7114e13850 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -194,6 +194,10 @@
 	status = "okay";
 };
 
+&otg_sram {
+	status = "okay";
+};
+
 &pio {
 	gmac_power_pin_bpi_m1p: gmac_power_pin at 0 {
 		allwinner,pins = "PH23";
@@ -249,13 +253,29 @@
 	regulator-name = "avcc";
 };
 
+&reg_usb0_vbus {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
 &usbphy {
+	usb0_id_det-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb0_vbus-supply = <&reg_usb0_vbus>;
 	/* VBUS on usb host ports are tied to DC5V and therefore always on */
 	status = "okay";
 };
-- 
2.10.2
