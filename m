From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue,  1 Dec 2015 20:03:15 +0200
Subject: [PATCH V2 13/19] ARM: dts: am57xx: sbc-am57x: add usb vbus pinmux
In-Reply-To: <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448993001-19495-14-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

usb1_drvvbus pin is used to Drive-VBUS enable to external charge
pump/power switch.

Add a pinmux for that pin.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---

  v2:

   * No fuctional changes
   * Reformat subject

 arch/arm/boot/dts/am57xx-sbc-am57x.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
index 93852e2..17a1972 100644
--- a/arch/arm/boot/dts/am57xx-sbc-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
@@ -37,6 +37,12 @@
 			DRA7XX_CORE_IOPAD(0x377c, PIN_INPUT | MUX_MODE14)	/* mmc1_sdwp.gpio6_28 */
 		>;
 	};
+
+	usb1_pins: pinmux_usb1_pins {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3680, PIN_INPUT_SLEW | MUX_MODE0) /* usb1_drvvbus */
+		>;
+	};
 };
 
 &uart3 {
@@ -59,3 +65,8 @@
 	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio6 28 GPIO_ACTIVE_HIGH>;
 };
+
+&usb1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb1_pins>;
+};
-- 
1.9.1
