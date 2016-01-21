From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 21 Jan 2016 13:26:41 +0800
Subject: [PATCH RFC 14/15] ARM: dts: sun9i: a80-optimus: Enable hardware reset
 and HS-DDR for eMMC
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Message-ID: <1453354002-28366-15-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc2 has a special pin for eMMC hardware reset, which is controllable
from the controller. Add the "mmc-cap-hw-reset" property to denote that
this controller supports this function, and the pins are actually used.

Also increase the signal drive strength for mmc2 pins, for HS-DDR mode
support.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index c0060e4f7379..958160e40fd0 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -174,9 +174,15 @@
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <8>;
 	non-removable;
+	cap-mmc-hw-reset;
 	status = "okay";
 };
 
+&mmc2_8bit_pins {
+	/* Increase drive strength for DDR modes */
+	allwinner,drive = <SUN4I_PINCTRL_40_MA>;
+};
+
 &reg_usb1_vbus {
 	pinctrl-0 = <&usb1_vbus_pin_optimus>;
 	gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
-- 
2.7.0.rc3
