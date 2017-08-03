From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Aug 2017 16:14:11 +0800
Subject: [PATCH 8/8] ARM: sun8i: a83t: h8homlet-v2: Enable USB ports
In-Reply-To: <20170803081411.22389-1-wens@csie.org>
References: <20170803081411.22389-1-wens@csie.org>
Message-ID: <20170803081411.22389-9-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The h8homlet board has the A83T's standard USB 1.1/2.0 host pair routed
to a USB host port on the board. The other USB host port is routed to
USB OTG controller.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
index e0055180d29f..1f0d60afb25b 100644
--- a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
@@ -58,6 +58,10 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -78,6 +82,20 @@
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
+&reg_usb0_vbus {
+	gpio = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+	status = "okay";
+};
+
+&reg_usb1_vbus {
+	gpio = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
@@ -118,3 +136,14 @@
 	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
+
+&usbphy {
+	usb0_vbus-supply = <&reg_usb0_vbus>;
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "host";
+	status = "okay";
+};
-- 
2.13.3
