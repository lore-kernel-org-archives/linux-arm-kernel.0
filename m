From: stefan@agner.ch (Stefan Agner)
Date: Thu, 16 Oct 2014 21:47:59 +0200
Subject: [PATCH v5 3/4] ARM: dts: vf610: use new GPIO support
In-Reply-To: <cover.1413488264.git.stefan@agner.ch>
References: <cover.1413488264.git.stefan@agner.ch>
Message-ID: <150ed46ff5102dc0fc8bd81160387cfeee748a27.1413488264.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GPIO support by adding SD card detection configuration and
GPIO pinmux for Colibri's standard GPIO pins. Attach the GPIO
pins to the iomuxc node to get the GPIO pin settings applied.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf610-colibri.dtsi | 9 +++++++++
 arch/arm/boot/dts/vf610-twr.dts      | 1 +
 arch/arm/boot/dts/vf610.dtsi         | 1 +
 3 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi b/arch/arm/boot/dts/vf610-colibri.dtsi
index 0cd8343..efd4322 100644
--- a/arch/arm/boot/dts/vf610-colibri.dtsi
+++ b/arch/arm/boot/dts/vf610-colibri.dtsi
@@ -31,6 +31,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
 	bus-width = <4>;
+	cd-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
 };
 
 &fec1 {
@@ -71,6 +72,14 @@
 
 &iomuxc {
 	vf610-colibri {
+		pinctrl_gpio_ext: gpio_ext {
+			fsl,pins = <
+				VF610_PAD_PTD10__GPIO_89	0x22ed /* EXT_IO_0 */
+				VF610_PAD_PTD9__GPIO_88		0x22ed /* EXT_IO_1 */
+				VF610_PAD_PTD26__GPIO_68	0x22ed /* EXT_IO_2 */
+			>;
+		};
+
 		pinctrl_esdhc1: esdhc1grp {
 			fsl,pins = <
 				VF610_PAD_PTA24__ESDHC1_CLK	0x31ef
diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 189b697..3fe8a8f 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -116,6 +116,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
 	bus-width = <4>;
+	cd-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 4d2ec32..467c97e 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -11,6 +11,7 @@
 #include "vf610-pinfunc.h"
 #include <dt-bindings/clock/vf610-clock.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	aliases {
-- 
2.1.2
