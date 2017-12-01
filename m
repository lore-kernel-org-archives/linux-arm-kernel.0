From: k@japko.eu (Krzysztof Adamski)
Date: Fri, 1 Dec 2017 23:49:42 +0100
Subject: [PATCH] ARM: dts: sun8i: h3: enable USB OTG for NanoPi Neo board
Message-ID: <20171201224942.GA12473@t440.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similarly to Orange Pi Zero, NanoPi Neo board has an USB OTG port with
an ID pin but with unpowered VBUS. This patch enables this port in
forced peripheral mode.

Signed-off-by: Krzysztof Adamski <k@japko.eu>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
index 78f6c24952dd..14c3f137dbd3 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
@@ -53,3 +53,20 @@
 	allwinner,leds-active-low;
 	status = "okay";
 };
+
+&usb_otg {
+	status = "okay";
+	dr_mode = "peripheral";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
-- 
2.13.6
