From: ynezz@true.cz (=?UTF-8?q?Petr=20=C5=A0tetiar?=)
Date: Thu, 19 Nov 2015 13:25:00 +0100
Subject: [PATCH 2/2] ARM: dts: imx6: Add support for Toradex Apalis Ixora board
In-Reply-To: <1447935900-13635-1-git-send-email-ynezz@true.cz>
References: <1447935900-13635-1-git-send-email-ynezz@true.cz>
Message-ID: <1447935900-13635-3-git-send-email-ynezz@true.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Petr ?tetiar <ynezz@true.cz>
---
 arch/arm/boot/dts/Makefile                    |    2 +
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      |   25 +++
 arch/arm/boot/dts/imx6q-apalis_v1_0-ixora.dts |   33 ++++
 arch/arm/boot/dts/imx6qdl-apalis-ixora.dtsi   |  211 +++++++++++++++++++++++++
 4 files changed, 271 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-apalis-ixora.dts
 create mode 100644 arch/arm/boot/dts/imx6q-apalis_v1_0-ixora.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-apalis-ixora.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 992736b..623def6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -277,6 +277,8 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-udoo.dtb \
 	imx6dl-wandboard.dtb \
 	imx6dl-wandboard-revb1.dtb \
+	imx6q-apalis-ixora.dtb \
+	imx6q-apalis_v1_0-ixora.dtb \
 	imx6q-arm2.dtb \
 	imx6q-cm-fx6.dtb \
 	imx6q-cubox-i.dtb \
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
new file mode 100644
index 0000000..cf1ef48
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -0,0 +1,25 @@
+/*
+ * Copyright 2014-2015 Toradex AG
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "imx6q.dtsi"
+#include "imx6qdl-apalis.dtsi"
+#include "imx6qdl-apalis-ixora.dtsi"
+
+/ {
+	model = "Toradex Apalis iMX6Q on Apalis Ixora Board";
+	compatible = "toradex,apalis_imx6q-ixora", "toradex,apalis_imx6q", "fsl,imx6q";
+};
diff --git a/arch/arm/boot/dts/imx6q-apalis_v1_0-ixora.dts b/arch/arm/boot/dts/imx6q-apalis_v1_0-ixora.dts
new file mode 100644
index 0000000..6f69669
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-apalis_v1_0-ixora.dts
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2014-2015 Toradex AG
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "imx6q.dtsi"
+
+/*
+ * On HW V1.0 all RX/TX lines are routed in a DCE way, all control lines are
+ * then not routed as given in the module specification and thus unusable. The
+ * following define configures the UARTs to RX/TX correctly.
+ */
+#define USE_UART_IN_DCE_MODE
+
+#include "imx6qdl-apalis.dtsi"
+#include "imx6qdl-apalis-ixora.dtsi"
+
+/ {
+	model = "Toradex Apalis iMX6Q on Apalis Ixora Board v1.0";
+	compatible = "toradex,apalis_imx6q-ixora", "toradex,apalis_imx6q", "fsl,imx6q";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-apalis-ixora.dtsi b/arch/arm/boot/dts/imx6qdl-apalis-ixora.dtsi
new file mode 100644
index 0000000..293e2ab
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-apalis-ixora.dtsi
@@ -0,0 +1,211 @@
+/*
+ * Copyright 2014-2015 Toradex AG
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	aliases {
+		i2c0 = &i2cddc;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+	};
+
+	aliases {
+		mmc0 = &usdhc3; /* eMMC */
+		mmc2 = &usdhc2; /* SD1  4bit slot */
+	};
+
+	aliases {
+		rtc0 = &rtc_i2c;
+		rtc1 = "/soc/aips-bus at 02000000/snvs at 020cc000/snvs-rtc-lp at 34";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		wakeup {
+			label = "Wake-Up";
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_WAKEUP>;
+			debounce-interval = <10>;
+			gpio-key,wakeup;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds_ixora>;
+
+		led4-green {
+			label = "LED_4_GREEN";
+			gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
+		};
+
+		led4-red {
+			label = "LED_4_RED";
+			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
+		};
+
+		led5-green {
+			label = "LED_5_GREEN";
+			gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led5-red {
+			label = "LED_5_RED";
+			gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	pwmleds {
+		compatible = "pwm-leds";
+		ledpwm1 {
+			label = "PWM1";
+			pwms = <&pwm1 0 50000>;
+			max-brightness = <255>;
+		};
+
+		ledpwm2 {
+			label = "PWM2";
+			pwms = <&pwm2 0 50000>;
+			max-brightness = <255>;
+		};
+
+		ledpwm3 {
+			label = "PWM3";
+			pwms = <&pwm3 0 50000>;
+			max-brightness = <255>;
+		};
+	};
+
+	regulators {
+		reg_usb_otg_vbus: usb_otg_vbus {
+			status = "okay";
+		};
+
+		reg_usb_host_vbus: usb_host_vbus {
+			status = "okay";
+		};
+	};
+};
+
+&backlight {
+	brightness-levels = <0 127 191 223 239 247 251 255>;
+	default-brightness-level = <1>;
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&can2 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	cat24c02 at 50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+	};
+
+	/* M41T0M6 real time clock on carrier board */
+	rtc_i2c: rtc at 68 {
+		compatible = "st,m41t00";
+		reg = <0x68>;
+	};
+};
+
+&iomuxc {
+	/*
+	 * Mux the Apalis GPIOs, GPIO7 used for PCIe reset,
+	 * GPIO5, 6 used by optional fusion_F0710A kernel module
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_apalis_gpio1 &pinctrl_apalis_gpio2
+		     &pinctrl_apalis_gpio3 &pinctrl_apalis_gpio4
+		     &pinctrl_apalis_gpio5 &pinctrl_apalis_gpio6
+		     &pinctrl_apalis_gpio7 &pinctrl_apalis_gpio8>;
+
+	leds_ixora {
+		pinctrl_leds_ixora: leds-ixora {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_DAT1__GPIO1_IO17 PAD_CTRL_HYS_PU
+				MX6QDL_PAD_SD1_DAT3__GPIO1_IO21 PAD_CTRL_HYS_PU
+				MX6QDL_PAD_NANDF_D1__GPIO2_IO01 PAD_CTRL_HYS_PU
+				MX6QDL_PAD_NANDF_D2__GPIO2_IO02 PAD_CTRL_HYS_PU
+			>;
+		};
+	};
+};
+
+&pcie {
+	reset-gpio = <&gpio1 28 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usbotg {
+	status = "okay";
+};
+
+/* SD1 */
+&usdhc2 {
+	status = "okay";
+};
-- 
1.7.9.5
