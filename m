From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sun, 23 Jul 2017 16:49:49 +0200
Subject: [linux-sunxi][PATCH 1/2] ARM: dts: sun8i: h3: Enable USB OTG on the
 Beelink X2
In-Reply-To: <20170723144950.29330-1-codekipper@gmail.com>
References: <20170723144950.29330-1-codekipper@gmail.com>
Message-ID: <20170723144950.29330-2-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

This STB has a type A socket which acts as OTG.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index e7fae65eb5d3..87d7f2cdefa6 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -100,6 +100,10 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
@@ -147,10 +151,19 @@
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &ohci1 {
 	status = "okay";
 };
 
+&reg_usb0_vbus {
+	gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL2 */
+	status = "okay";
+};
+
 &spdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spdif_tx_pins_a>;
@@ -163,7 +176,15 @@
 	status = "okay";
 };
 
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &usbphy {
-	/* USB VBUS is on as long as VCC-IO is on */
+	/* USB VBUS is always on except for the OTG port */
 	status = "okay";
+	usb0_id_det-gpios = <&pio 0 7 GPIO_ACTIVE_HIGH>; /* PA07 */
+	usb0_vbus-supply = <&reg_usb0_vbus>;
 };
-- 
2.13.3
