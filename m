From: marek@goldelico.com (Marek Belisko)
Date: Tue, 17 May 2016 21:48:48 +0200
Subject: [PATCH 2/5] ARM: dts: omap3-gta04: Define and use bma180 irq pin
In-Reply-To: <1463514531-7235-1-git-send-email-marek@goldelico.com>
References: <1463514531-7235-1-git-send-email-marek@goldelico.com>
Message-ID: <1463514531-7235-3-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

Add pinmux and usage of bma180 irq pin.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index cef8b23..e0520cf 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -250,6 +250,12 @@
 			OMAP3_CORE1_IOPAD(0x21c6, PIN_INPUT_PULLUP | MUX_MODE0) /* i2c3_sda.hdq */
 		>;
 	};
+
+	bma180_pins: pinmux_bma180_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x213a, PIN_INPUT_PULLUP | MUX_MODE4) /* gpio115 */
+		>;
+	};
 };
 
 &omap3_pmx_core2 {
@@ -320,6 +326,8 @@
 	bma180 at 41 {
 		compatible = "bosch,bma180";
 		reg = <0x41>;
+		pinctrl-names = "default";
+		pintcrl-0 = <&bma180_pins>;
 		interrupt-parent = <&gpio4>;
 		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>; /* GPIO_115 */
 	};
-- 
2.5.0
