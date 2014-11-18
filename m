From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue, 18 Nov 2014 11:13:20 +0200
Subject: [PATCH 5/9] ARM: dts: sb-t35: add EEPROM support
In-Reply-To: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
References: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1416302004-22199-6-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add at24 EEPROM chip support.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-sb-t35.dtsi |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-sb-t35.dtsi b/arch/arm/boot/dts/omap3-sb-t35.dtsi
index b1cb577..aff733e 100644
--- a/arch/arm/boot/dts/omap3-sb-t35.dtsi
+++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
@@ -58,6 +58,26 @@
 			OMAP3_CORE1_IOPAD(0x20b4, PIN_OUTPUT | MUX_MODE4)	/* gpmc_ncs3.gpio_54 */
 		>;
 	};
+
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21c2, PIN_INPUT_PULLUP | MUX_MODE0) /* i2c3_scl */
+			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT_PULLUP | MUX_MODE0) /* i2c3_sda */
+		>;
+	};
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+
+	clock-frequency = <400000>;
+
+	at24 at 50 {
+		compatible = "at24,24c02";
+		pagesize = <16>;
+		reg = <0x50>;
+	};
 };
 
 &gpmc {
-- 
1.7.5.4
