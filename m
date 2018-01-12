From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 12 Jan 2018 14:39:04 +0530
Subject: [PATCH v2] arm64: allwinner: a64: orangepi-zero-plus2: add usb otg
Message-ID: <1515748144-25204-1-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb otg support for orangepi-zero-plus2 board:
- Add usb_otg node with dr_mode as 'otg'
- USB0-IDDET connected to PA21
- VBUS connected through DCIN which always on

Tested mass storage function.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Change dr_mode to peripheral

 .../dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index af43533..6511190 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -73,6 +73,10 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>;
@@ -111,6 +115,10 @@
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
@@ -122,3 +130,13 @@
 	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
 	status = "okay";
 };
+
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 0 21 GPIO_ACTIVE_HIGH>; /* PA21 */
+	status = "okay";
+};
-- 
2.7.4
