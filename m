From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 28 Feb 2016 13:39:42 +0100
Subject: [PATCH v4 2/5] ARM: dts: omap3-sniper: USB OTG support
In-Reply-To: <1456663185-14170-1-git-send-email-contact@paulk.fr>
References: <1456663185-14170-1-git-send-email-contact@paulk.fr>
Message-ID: <1456663185-14170-3-git-send-email-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for USB OTG on the Optimus Black.
The HSUSB0 interface is connected to the TWL4030 USB PHY.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/omap3-sniper.dts | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-sniper.dts b/arch/arm/boot/dts/omap3-sniper.dts
index f057e03..6e31daf 100644
--- a/arch/arm/boot/dts/omap3-sniper.dts
+++ b/arch/arm/boot/dts/omap3-sniper.dts
@@ -94,6 +94,23 @@
 			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT | MUX_MODE0)	/* sdmmc2_dat7 */
 		>;
 	};
+
+	usb_otg_hs_pins: pinmux_usb_otg_hs_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21a2, PIN_INPUT | MUX_MODE0)	/* hsusb0_clk */
+			OMAP3_CORE1_IOPAD(0x21a4, PIN_OUTPUT | MUX_MODE0)	/* hsusb0_stp */
+			OMAP3_CORE1_IOPAD(0x21a6, PIN_INPUT | MUX_MODE0)	/* hsusb0_dir */
+			OMAP3_CORE1_IOPAD(0x21a8, PIN_INPUT | MUX_MODE0)	/* hsusb0_nxt */
+			OMAP3_CORE1_IOPAD(0x21aa, PIN_INPUT | MUX_MODE0)	/* hsusb0_data0 */
+			OMAP3_CORE1_IOPAD(0x21ac, PIN_INPUT | MUX_MODE0)	/* hsusb0_data1 */
+			OMAP3_CORE1_IOPAD(0x21ae, PIN_INPUT | MUX_MODE0)	/* hsusb0_data2 */
+			OMAP3_CORE1_IOPAD(0x21b0, PIN_INPUT | MUX_MODE0)	/* hsusb0_data3 */
+			OMAP3_CORE1_IOPAD(0x21b2, PIN_INPUT | MUX_MODE0)	/* hsusb0_data4 */
+			OMAP3_CORE1_IOPAD(0x21b4, PIN_INPUT | MUX_MODE0)	/* hsusb0_data5 */
+			OMAP3_CORE1_IOPAD(0x21b6, PIN_INPUT | MUX_MODE0)	/* hsusb0_data6 */
+			OMAP3_CORE1_IOPAD(0x21b8, PIN_INPUT | MUX_MODE0)	/* hsusb0_data7 */
+		>;
+	};
 };
 
 &omap3_pmx_wkup {
@@ -175,15 +192,16 @@
 &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins &mmc1_cd_pin>;
+
 	vmmc-supply = <&lp8720_ldo1>;
 	cd-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>; /* gpio 10 */
 	bus-width = <4>;
 };
 
 &mmc2 {
-
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
+
 	vmmc-supply = <&vmmc2>;
 	ti,non-removable;
 	bus-width = <8>;
@@ -193,6 +211,18 @@
 	status = "disabled";
 };
 
+&usb_otg_hs {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb_otg_hs_pins>;
+
+	interface-type = <0>;
+	usb-phy = <&usb2_phy>;
+	phys = <&usb2_phy>;
+	phy-names = "usb2-phy";
+	mode = <3>;
+	power = <50>;
+};
+
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
 
-- 
2.6.4
