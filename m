From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 25 Nov 2015 08:39:44 +0200
Subject: [PATCH 12/18] ARM: am57xx: cl-som-am57x: dts: add MMC1 support
In-Reply-To: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448433590-1399-13-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MMC1 support, used for SD/MMC card.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/am57xx-sbc-am57x.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
index 804ad72..67e7f4a 100644
--- a/arch/arm/boot/dts/am57xx-sbc-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
@@ -24,6 +24,20 @@
 			DRA7XX_CORE_IOPAD(0x37fc, PIN_INPUT_SLEW | MUX_MODE1)	/* uart2_rtsn.uart3_txd */
 		>;
 	};
+
+	mmc1_pins_default: mmc1_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x376c, PIN_INPUT | MUX_MODE14)	/* mmc1sdcd.gpio219 */
+			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_clk.clk */
+			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_cmd.cmd */
+			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
+			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
+			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
+			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
+			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT | MUX_MODE14)	/* mmc1_sdcd.gpio6_27 */
+			DRA7XX_CORE_IOPAD(0x3770, PIN_INPUT | MUX_MODE14)	/* mmc1_sdwp.gpio6_28 */
+		>;
+	};
 };
 
 &uart3 {
@@ -34,3 +48,15 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins_default>;
 };
+
+&mmc1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins_default>;
+
+	vmmc-supply = <&ldo1_reg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio6 28 GPIO_ACTIVE_HIGH>;
+};
-- 
1.9.1
