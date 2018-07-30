From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 30 Jul 2018 13:31:23 +0100
Subject: [PATCH v3 05/19] arm64: dts: allwinner: a64: Orange Pi Win: Enable
 USB OTG socket
In-Reply-To: <20180730123137.923-1-andre.przywara@arm.com>
References: <20180730123137.923-1-andre.przywara@arm.com>
Message-ID: <20180730123137.923-6-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Samuel Holland <samuel@sholland.org>

The Orange Pi Win has a micro USB-B socket, connected to the SoC's
USB-OTG port. Its power is supplied by the AXP PMIC, and the ID pin is
connected to GPIO PH9. It can serve both as a host or a client port.

Add the respective DT node to enable it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index a73489850d88..c9cabe987c19 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -214,8 +214,13 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &usbphy {
+	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
 };
-
-- 
2.14.4
