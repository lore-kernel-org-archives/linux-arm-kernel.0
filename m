From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sat, 16 Nov 2013 14:23:40 +0100
Subject: [PATCH 07/11] ARM: dts: AM33XX BASE0033: add pinmux and user led
 support.
In-Reply-To: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1384608224-9452-8-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Enable the user leds on the IGEP AQUILA EXPANSION. The has two leds,
one green and one red, that are controllable by software.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/boot/dts/am335x-base0033.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-base0033.dts b/arch/arm/boot/dts/am335x-base0033.dts
index 3a97613..2878024 100644
--- a/arch/arm/boot/dts/am335x-base0033.dts
+++ b/arch/arm/boot/dts/am335x-base0033.dts
@@ -22,6 +22,25 @@
 		pinctrl-1 = <&nxp_hdmi_off_pins>;
 		status = "okay";
 	};
+
+	leds_base {
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_base_pins>;
+
+		compatible = "gpio-leds";
+
+		led at 0 {
+			label = "base:red:user";
+			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;	/* gpio1_21 */
+			default-state = "off";
+		};
+
+		led at 1 {
+			label = "base:green:user";
+			gpios = <&gpio2 0 GPIO_ACTIVE_HIGH>;	/* gpio2_0 */
+			default-state = "off";
+		};
+	};
 };
 
 &am33xx_pinmux {
@@ -55,6 +74,13 @@
 			0x1b0 (PIN_OUTPUT | MUX_MODE3)	/* xdma_event_intr0.clkout1 */
 		>;
 	};
+
+	leds_base_pins: pinmux_leds_base_pins {
+		pinctrl-single,pins = <
+			0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
+			0x88 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_csn3.gpio2_0 */
+		>;
+	};
 };
 
 &lcdc {
-- 
1.8.4.2
