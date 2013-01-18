From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 18 Jan 2013 15:31:08 +0800
Subject: [PATCH v7 04/15] gpio: set gpio range cells property as 3
In-Reply-To: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1358494279-16503-5-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio offset into "gpio-range-cells" property. It's used to support
sparse pinctrl range in gpio chip.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 Documentation/devicetree/bindings/gpio/gpio.txt |    6 +++---
 arch/arm/boot/dts/spear1310.dtsi                |    4 ++--
 arch/arm/boot/dts/spear1340.dtsi                |    4 ++--
 arch/arm/boot/dts/spear310.dtsi                 |    4 ++--
 arch/arm/boot/dts/spear320.dtsi                 |    4 ++--
 drivers/gpio/gpiolib-of.c                       |    7 ++-----
 6 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
index a336287..d933af3 100644
--- a/Documentation/devicetree/bindings/gpio/gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio.txt
@@ -98,7 +98,7 @@ announce the pinrange to the pin ctrl subsystem. For example,
 		compatible = "fsl,qe-pario-bank-e", "fsl,qe-pario-bank";
 		reg = <0x1460 0x18>;
 		gpio-controller;
-		gpio-ranges = <&pinctrl1 20 10>, <&pinctrl2 50 20>;
+		gpio-ranges = <&pinctrl1 0 20 10>, <&pinctrl2 10 50 20>;
 
     }
 
@@ -107,8 +107,8 @@ where,
 
    Next values specify the base pin and number of pins for the range
    handled by 'qe_pio_e' gpio. In the given example from base pin 20 to
-   pin 29 under pinctrl1 and pin 50 to pin 69 under pinctrl2 is handled
-   by this gpio controller.
+   pin 29 under pinctrl1 with gpio offset 0 and pin 50 to pin 69 under
+   pinctrl2 with gpio offset 10 is handled by this gpio controller.
 
 The pinctrl node must have "#gpio-range-cells" property to show number of
 arguments to pass with phandle from gpio controllers node.
diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
index 1513c19..122ae94 100644
--- a/arch/arm/boot/dts/spear1310.dtsi
+++ b/arch/arm/boot/dts/spear1310.dtsi
@@ -89,7 +89,7 @@
 		pinmux: pinmux at e0700000 {
 			compatible = "st,spear1310-pinmux";
 			reg = <0xe0700000 0x1000>;
-			#gpio-range-cells = <2>;
+			#gpio-range-cells = <3>;
 		};
 
 		apb {
@@ -212,7 +212,7 @@
 				interrupt-controller;
 				gpio-controller;
 				#gpio-cells = <2>;
-				gpio-ranges = <&pinmux 0 246>;
+				gpio-ranges = <&pinmux 0 0 246>;
 				status = "disabled";
 
 				st-plgpio,ngpio = <246>;
diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index 34da11a..c511c47 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -63,7 +63,7 @@
 		pinmux: pinmux at e0700000 {
 			compatible = "st,spear1340-pinmux";
 			reg = <0xe0700000 0x1000>;
-			#gpio-range-cells = <2>;
+			#gpio-range-cells = <3>;
 		};
 
 		pwm: pwm at e0180000 {
@@ -127,7 +127,7 @@
 				interrupt-controller;
 				gpio-controller;
 				#gpio-cells = <2>;
-				gpio-ranges = <&pinmux 0 252>;
+				gpio-ranges = <&pinmux 0 0 252>;
 				status = "disabled";
 
 				st-plgpio,ngpio = <250>;
diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/spear310.dtsi
index ab45b8c..9537208 100644
--- a/arch/arm/boot/dts/spear310.dtsi
+++ b/arch/arm/boot/dts/spear310.dtsi
@@ -25,7 +25,7 @@
 		pinmux: pinmux at b4000000 {
 			compatible = "st,spear310-pinmux";
 			reg = <0xb4000000 0x1000>;
-			#gpio-range-cells = <2>;
+			#gpio-range-cells = <3>;
 		};
 
 		fsmc: flash at 44000000 {
@@ -102,7 +102,7 @@
 				interrupt-controller;
 				gpio-controller;
 				#gpio-cells = <2>;
-				gpio-ranges = <&pinmux 0 102>;
+				gpio-ranges = <&pinmux 0 0 102>;
 				status = "disabled";
 
 				st-plgpio,ngpio = <102>;
diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/spear320.dtsi
index caa5520..ffea342 100644
--- a/arch/arm/boot/dts/spear320.dtsi
+++ b/arch/arm/boot/dts/spear320.dtsi
@@ -24,7 +24,7 @@
 		pinmux: pinmux at b3000000 {
 			compatible = "st,spear320-pinmux";
 			reg = <0xb3000000 0x1000>;
-			#gpio-range-cells = <2>;
+			#gpio-range-cells = <3>;
 		};
 
 		clcd at 90000000 {
@@ -130,7 +130,7 @@
 				interrupt-controller;
 				gpio-controller;
 				#gpio-cells = <2>;
-				gpio-ranges = <&pinmux 0 102>;
+				gpio-ranges = <&pinmux 0 0 102>;
 				status = "disabled";
 
 				st-plgpio,ngpio = <102>;
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 25b1dbe..b1f0682 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -245,15 +245,12 @@ static void of_gpiochip_add_pin_range(struct gpio_chip *chip)
 		 * to add different ranges for one and the same GPIO chip,
 		 * as the code assumes that we have one consecutive range
 		 * on both, mapping 1-to-1.
-		 *
-		 * TODO: make the OF bindings handle multiple sparse ranges
-		 * on the same GPIO chip.
 		 */
 		ret = gpiochip_add_pin_range(chip,
 					     pinctrl_dev_get_devname(pctldev),
-					     0, /* offset in gpiochip */
 					     pinspec.args[0],
-					     pinspec.args[1]);
+					     pinspec.args[1],
+					     pinspec.args[2]);
 
 		if (ret)
 			break;
-- 
1.7.10.4
