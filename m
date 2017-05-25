From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 25 May 2017 15:31:38 +0800
Subject: [PATCH 6/6] ARM: sun7i: a20: cubietruck: Tie AXP209's USB power
 supply to USB PHY
In-Reply-To: <20170525073138.20907-1-wens@csie.org>
References: <20170525073138.20907-1-wens@csie.org>
Message-ID: <20170525073138.20907-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB PHY can use either a GPIO pin or the PMIC's USB power supply
to sense VBUS. Since both options are available on the Cubietruck,
add the missing property for the USB power supply to the USB PHY node.

The device tree provides all usable options. Ultimately, which method
is used is up to the driver implementation.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 8dbf732c7aa9..bb510187602c 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -336,6 +336,7 @@
 	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
 	usb0_id_det-gpios = <&pio 7 19 GPIO_ACTIVE_HIGH>; /* PH19 */
 	usb0_vbus_det-gpios = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
 	usb0_vbus-supply = <&reg_usb0_vbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	usb2_vbus-supply = <&reg_usb2_vbus>;
-- 
2.11.0
