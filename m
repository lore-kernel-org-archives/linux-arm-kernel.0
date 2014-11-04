From: stefan@agner.ch (Stefan Agner)
Date: Tue,  4 Nov 2014 14:07:08 +0100
Subject: [PATCH 1/3] ARM: dts: vf610: use new GPIO support
In-Reply-To: <1415106430-6271-1-git-send-email-stefan@agner.ch>
References: <1415106430-6271-1-git-send-email-stefan@agner.ch>
Message-ID: <1415106430-6271-2-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GPIO support by adding SD card detection configuration and
GPIO pinmux for Colibri's standard GPIO pins. Attach the GPIO
pins to the iomuxc node to get the GPIO pin settings applied.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/vf-colibri.dtsi | 9 +++++++++
 arch/arm/boot/dts/vf610-twr.dts   | 1 +
 arch/arm/boot/dts/vfxxx.dtsi      | 1 +
 3 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index ab40367..ab9616d7 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -31,6 +31,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
 	bus-width = <4>;
+	cd-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
 };
 
 &fec1 {
@@ -76,6 +77,14 @@
 
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
index ebc906b..793a376 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -123,6 +123,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
 	bus-width = <4>;
+	cd-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 4e70833..505969a 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -10,6 +10,7 @@
 #include "vf610-pinfunc.h"
 #include <dt-bindings/clock/vf610-clock.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	aliases {
-- 
2.1.3
