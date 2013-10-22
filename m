From: sre@debian.org (Sebastian Reichel)
Date: Tue, 22 Oct 2013 13:05:13 +0200
Subject: [PATCH] DTS: ARM: OMAP3-N900: Add UART support
Message-ID: <1382439913-16534-1-git-send-email-sre@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add UART support to Nokia N900.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 2374b9a..99d0668 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -31,6 +31,20 @@
 &omap3_pmx_core {
 	pinctrl-names = "default";
 
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			0x14a (PIN_INPUT | MUX_MODE0)		/* uart2_rx */
+			0x148 (PIN_OUTPUT | MUX_MODE0)		/* uart2_tx */
+		>;
+	};
+
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			0x16e (PIN_INPUT | MUX_MODE0)		/* uart3_rx */
+			0x170 (PIN_OUTPUT | MUX_MODE0)		/* uart3_tx */
+		>;
+	};
+
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
 			0x18a (PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
@@ -125,3 +139,17 @@
 	mode = <2>;
 	power = <50>;
 };
+
+&uart1 {
+	status = "disabled";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+};
-- 
1.8.4.rc3
