From: woogyom.kim@gmail.com (Milo Kim)
Date: Thu, 20 Oct 2016 17:07:00 +0900
Subject: [PATCH 2/3] ARM: dts: sun8i: Use the common file in NanoPi NEO SBC
In-Reply-To: <20161020080701.15993-1-woogyom.kim@gmail.com>
References: <20161020080701.15993-1-woogyom.kim@gmail.com>
Message-ID: <20161020080701.15993-3-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: James Pettigrew <james@innovum.com.au>
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts | 79 +------------------------------
 1 file changed, 1 insertion(+), 78 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
index 3d64caf..8d2cc6e 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
@@ -40,86 +40,9 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/dts-v1/;
-#include "sun8i-h3.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/sun4i-a10.h>
+#include "sun8i-h3-nanopi.dtsi"
 
 / {
 	model = "FriendlyARM NanoPi NEO";
 	compatible = "friendlyarm,nanopi-neo", "allwinner,sun8i-h3";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&leds_opc>, <&leds_r_opc>;
-
-		pwr {
-			label = "nanopi:green:pwr";
-			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
-			default-state = "on";
-		};
-
-		status {
-			label = "nanopi:blue:status";
-			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>; /* PA10 */
-		};
-	};
-};
-
-&ehci3 {
-	status = "okay";
-};
-
-&mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
-	cd-inverted;
-	status = "okay";
-};
-
-&ohci3 {
-	status = "okay";
-};
-
-&pio {
-	leds_opc: led-pins {
-		allwinner,pins = "PA10";
-		allwinner,function = "gpio_out";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-};
-
-&r_pio {
-	leds_r_opc: led-pins {
-		allwinner,pins = "PL10";
-		allwinner,function = "gpio_out";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
-	status = "okay";
-};
-
-&usbphy {
-	/* USB VBUS is always on */
-	status = "okay";
 };
-- 
2.9.3
