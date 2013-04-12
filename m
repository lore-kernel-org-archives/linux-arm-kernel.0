From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 13 Apr 2013 01:53:11 +0200
Subject: [PATCH] ARM: S3C24XX: add devicetree support for smdk2416
Message-ID: <201304130153.11653.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Definitions in s3c24xx.dtsi are usable for all s3c24xx SoCs, but some
need to be extended with proper compatible properties, as can be seen
in s3c2416.dtsi .

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
This patch depends on the not yet merged s3c24xx pinctrl support and
the samsung-time muliplatform support.

 arch/arm/boot/dts/Makefile              |    1 +
 arch/arm/boot/dts/s3c2416-pinctrl.dtsi  |  173 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/s3c2416-smdk2416.dts  |   72 +++++++++++++
 arch/arm/boot/dts/s3c2416.dtsi          |   79 ++++++++++++++
 arch/arm/boot/dts/s3c24xx.dtsi          |   92 ++++++++++++++++
 arch/arm/mach-s3c24xx/Kconfig           |   12 ++
 arch/arm/mach-s3c24xx/Makefile          |    1 +
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c |   91 ++++++++++++++++
 8 files changed, 521 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/s3c2416-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/s3c2416-smdk2416.dts
 create mode 100644 arch/arm/boot/dts/s3c2416.dtsi
 create mode 100644 arch/arm/boot/dts/s3c24xx.dtsi
 create mode 100644 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d3cd880..4296353 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -137,6 +137,7 @@ dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
 	hrefprev60.dtb \
 	hrefv60plus.dtb \
 	ccu9540.dtb
+dtb-$(CONFIG_ARCH_S3C24XX) += s3c2416-smdk2416.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a7740-armadillo800eva.dtb \
 	sh73a0-kzm9g.dtb \
diff --git a/arch/arm/boot/dts/s3c2416-pinctrl.dtsi b/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
new file mode 100644
index 0000000..527e319
--- /dev/null
+++ b/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
@@ -0,0 +1,173 @@
+/*
+ * Samsung S3C2416 pinctrl settings
+ *
+ * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+&pinctrl_0 {
+	/*
+	 * Pin banks
+	 */
+
+	gpa: gpa {
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpb: gpb {
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpc: gpc {
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpd: gpd {
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpe: gpe {
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpf: gpf {
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg: gpg {
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gph: gph {
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpj: gpj {
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpk: gpk {
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpl: gpl {
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpm: gpm {
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	/*
+	 * Pin groups
+	 */
+
+	uart0_data: uart0-data {
+		samsung,pins = "gph-0", "gph-1";
+		samsung,pin-function = <2>;
+	};
+
+	uart0_fctl: uart0-fctl {
+		samsung,pins = "gph-8", "gph-9";
+		samsung,pin-function = <2>;
+	};
+
+	uart1_data: uart1-data {
+		samsung,pins = "gph-2", "gph-3";
+		samsung,pin-function = <2>;
+	};
+
+	uart1_fctl: uart1-fctl {
+		samsung,pins = "gph-10", "gph-11";
+		samsung,pin-function = <2>;
+	};
+
+	uart2_data: uart2-data {
+		samsung,pins = "gph-4", "gph-5";
+		samsung,pin-function = <2>;
+	};
+
+	uart2_fctl: uart2-fctl {
+		samsung,pins = "gph-6", "gph-7";
+		samsung,pin-function = <2>;
+	};
+
+	uart3_data: uart3-data {
+		samsung,pins = "gph-6", "gph-7";
+		samsung,pin-function = <2>;
+	};
+
+	extuart_clk: extuart-clk {
+		samsung,pins = "gph-12";
+		samsung,pin-function = <2>;
+	};
+
+	i2c0_bus: i2c0-bus {
+		samsung,pins = "gpe-14", "gpe-15";
+		samsung,pin-function = <2>;
+	};
+
+	spi0_bus: spi0-bus {
+		samsung,pins = "gpe-11", "gpe-12", "gpe-13";
+		samsung,pin-function = <2>;
+	};
+
+	sd0_clk: sd0-clk {
+		samsung,pins = "gpe-5";
+		samsung,pin-function = <2>;
+	};
+
+	sd0_cmd: sd0-cmd {
+		samsung,pins = "gpe-6";
+		samsung,pin-function = <2>;
+	};
+
+	sd0_bus1: sd0-bus1 {
+		samsung,pins = "gpe-7";
+		samsung,pin-function = <2>;
+	};
+
+	sd0_bus4: sd0-bus4 {
+		samsung,pins = "gpe-8", "gpe-9", "gpe-10";
+		samsung,pin-function = <2>;
+	};
+
+	sd1_cmd: sd1-cmd {
+		samsung,pins = "gpl-8";
+		samsung,pin-function = <2>;
+	};
+
+	sd1_clk: sd1-clk {
+		samsung,pins = "gpl-9";
+		samsung,pin-function = <2>;
+	};
+
+	sd1_bus1: sd1-bus1 {
+		samsung,pins = "gpl-0";
+		samsung,pin-function = <2>;
+	};
+
+	sd1_bus4: sd1-bus4 {
+		samsung,pins = "gpl-1", "gpl-2", "gpl-3";
+		samsung,pin-function = <2>;
+	};
+};
diff --git a/arch/arm/boot/dts/s3c2416-smdk2416.dts b/arch/arm/boot/dts/s3c2416-smdk2416.dts
new file mode 100644
index 0000000..ad1dd09
--- /dev/null
+++ b/arch/arm/boot/dts/s3c2416-smdk2416.dts
@@ -0,0 +1,72 @@
+/*
+ * SAMSUNG SMDK2416 board device tree source
+ *
+ * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+/include/ "s3c2416.dtsi"
+
+/ {
+	model = "SMDK2416";
+	compatible = "samsung,s3c2416";
+
+	memory {
+		reg =  <0x30000000 0x4000000>;
+	};
+
+	serial at 50000000 {
+		status = "okay";
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart0_data>, <&uart0_fctl>;
+	};
+
+	serial at 50004000 {
+		status = "okay";
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart1_data>, <&uart1_fctl>;
+	};
+
+	serial at 50008000 {
+		status = "okay";
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart2_data>;
+	};
+
+	serial at 5000C000 {
+		status = "okay";
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart3_data>;
+	};
+
+	watchdog at 53000000 {
+		status = "okay";
+	};
+
+	rtc at 57000000 {
+		status = "okay";
+	};
+
+	sdhci at 4AC00000 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd0_clk>, <&sd0_cmd>,
+				<&sd0_bus1>, <&sd0_bus4>;
+		bus-width = <4>;
+		cd-gpios = <&gpf 1 0>;
+		cd-inverted;
+		status = "okay";
+	};
+
+	sdhci at 4A800000 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd1_clk>, <&sd1_cmd>,
+				<&sd1_bus1>, <&sd1_bus4>;
+		bus-width = <4>;
+		broken-cd;
+		status = "okay";
+	};
+};
diff --git a/arch/arm/boot/dts/s3c2416.dtsi b/arch/arm/boot/dts/s3c2416.dtsi
new file mode 100644
index 0000000..6809324
--- /dev/null
+++ b/arch/arm/boot/dts/s3c2416.dtsi
@@ -0,0 +1,79 @@
+/*
+ * Samsung's S3C2416 SoC device tree source
+ *
+ * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/include/ "s3c24xx.dtsi"
+/include/ "s3c2416-pinctrl.dtsi"
+
+/ {
+	model = "Samsung S3C2416 SoC";
+	compatible = "samsung,s3c2416";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu {
+			compatible = "arm,arm926ejs";
+		};
+	};
+
+	interrupt-controller at 4a000000 {
+		compatible = "samsung,s3c2416-irq";
+	};
+
+	pinctrl at 56000000 {
+		compatible = "samsung,s3c2416-pinctrl";
+	};
+
+	serial at 50000000 {
+		compatible = "samsung,s3c2440-uart";
+	};
+
+	serial at 50004000 {
+		compatible = "samsung,s3c2440-uart";
+	};
+
+	serial at 50008000 {
+		compatible = "samsung,s3c2440-uart";
+	};
+
+	serial at 5000C000 {
+		compatible = "samsung,s3c2440-uart";
+		reg = <0x5000C000 0x4000>;
+		interrupts = <1 18 24 4>, <1 18 25 4>;
+		status = "disabled";
+	};
+
+	sdhci at 4AC00000 {
+		compatible = "samsung,s3c6410-sdhci";
+		reg = <0x4AC00000 0x100>;
+		interrupts = <0 0 21 3>;
+		status = "disabled";
+	};
+
+	sdhci at 4A800000 {
+		compatible = "samsung,s3c6410-sdhci";
+		reg = <0x4A800000 0x100>;
+		interrupts = <0 0 20 3>;
+		status = "disabled";
+	};
+
+	watchdog at 53000000 {
+		interrupts = <1 9 27 3>;
+	};
+
+	rtc at 57000000 {
+		compatible = "samsung,s3c2416-rtc";
+	};
+
+	i2c at 54000000 {
+		compatible = "samsung,s3c2440-i2c";
+	};
+};
diff --git a/arch/arm/boot/dts/s3c24xx.dtsi b/arch/arm/boot/dts/s3c24xx.dtsi
new file mode 100644
index 0000000..92017f6
--- /dev/null
+++ b/arch/arm/boot/dts/s3c24xx.dtsi
@@ -0,0 +1,92 @@
+/*
+ * Samsung's S3C24XX family device tree source
+ *
+ * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "samsung,s3c24xx";
+	interrupt-parent = <&intc>;
+
+	aliases {
+		pinctrl0 = &pinctrl_0;
+	};
+
+	intc:interrupt-controller at 4a000000 {
+		compatible = "samsung,s3c24xx-irq";
+		reg = <0x4a000000 0x100>;
+		interrupt-controller;
+		#interrupt-cells = <4>;
+	};
+
+	pinctrl_0: pinctrl at 56000000 {
+		reg = <0x56000000 0x1000>;
+
+		wakeup-interrupt-controller {
+			compatible = "samsung,s3c2410-wakeup-eint";
+			interrupts = <0 0 0 3>,
+				     <0 0 1 3>,
+				     <0 0 2 3>,
+				     <0 0 3 3>,
+				     <0 0 4 4>,
+				     <0 0 5 4>;
+		};
+	};
+
+	timer at 51000000 {
+		compatible = "samsung,s3c2410-pwm";
+		reg = <0x51000000 0x1000>;
+		interrupts = <0 0 10 3>, <0 0 11 3>, <0 0 12 3>, <0 0 13 3>, <0 0 14 3>;
+		#pwm-cells = <4>;
+	};
+
+	serial at 50000000 {
+		compatible = "samsung,s3c2410-uart";
+		reg = <0x50000000 0x4000>;
+		interrupts = <1 28 0 4>, <1 28 1 4>;
+		status = "disabled";
+	};
+
+	serial at 50004000 {
+		compatible = "samsung,s3c2410-uart";
+		reg = <0x50004000 0x4000>;
+		interrupts = <1 23 3 4>, <1 23 4 4>;
+		status = "disabled";
+	};
+
+	serial at 50008000 {
+		compatible = "samsung,s3c2410-uart";
+		reg = <0x50008000 0x4000>;
+		interrupts = <1 15 6 4>, <1 15 7 4>;
+		status = "disabled";
+	};
+
+	watchdog at 53000000 {
+		compatible = "samsung,s3c2410-wdt";
+		reg = <0x53000000 0x100>;
+		interrupts = <0 0 9 3>;
+		status = "disabled";
+	};
+
+	rtc at 57000000 {
+		compatible = "samsung,s3c2410-rtc";
+		reg = <0x57000000 0x100>;
+		interrupts = <0 0 30 3>, <0 0 8 3>;
+		status = "disabled";
+	};
+
+	i2c at 54000000 {
+		compatible = "samsung,s3c2410-i2c";
+		reg = <0x54000000 0x100>;
+		interrupts = <0 0 27 3>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 0a8663c..f842e3e 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -496,6 +496,18 @@ config MACH_SMDK2416
 	help
 	  Say Y here if you are using an SMDK2416
 
+config MACH_S3C2416_DT
+	bool "Samsung S3C2416 machine using devicetree"
+	select CLKSRC_OF
+	select USE_OF
+	select PINCTRL
+	select PINCTRL_S3C24XX
+	help
+	  Machine support for Samsung S3C2416 machines with device tree enabled.
+	  Select this if a fdt blob is available for the S3C2416 SoC based board.
+	  Note: This is under development and not all peripherals can be supported
+	  with this machine file.
+
 endif	# CPU_S3C2416
 
 if CPU_S3C2440
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 6f46ecf..6de730b 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_MACH_SMDK2413)		+= mach-smdk2413.o
 obj-$(CONFIG_MACH_VSTMS)		+= mach-vstms.o
 
 obj-$(CONFIG_MACH_SMDK2416)		+= mach-smdk2416.o
+obj-$(CONFIG_MACH_S3C2416_DT)		+= mach-s3c2416-dt.o
 
 obj-$(CONFIG_MACH_ANUBIS)		+= mach-anubis.o
 obj-$(CONFIG_MACH_AT2440EVB)		+= mach-at2440evb.o
diff --git a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
new file mode 100644
index 0000000..f5c9072
--- /dev/null
+++ b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
@@ -0,0 +1,91 @@
+/*
+ * Samsung's S3C2416 flattened device tree enabled machine
+ *
+ * Copyright (c) 2012 Heiko Stuebner <heiko@sntech.de>
+ *
+ * based on mach-exynos/mach-exynos4-dt.c
+ *
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2010-2011 Linaro Ltd.
+ *		www.linaro.org
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/clocksource.h>
+#include <linux/irqchip.h>
+#include <linux/of_platform.h>
+#include <linux/serial_core.h>
+
+#include <asm/mach/arch.h>
+#include <mach/map.h>
+
+#include <plat/cpu.h>
+#include <plat/pm.h>
+#include <plat/regs-serial.h>
+
+#include "common.h"
+
+/*
+ * The following lookup table is used to override device names when devices
+ * are registered from device tree. This is temporarily added to enable
+ * device tree support addition for the S3C2416 architecture.
+ *
+ * For drivers that require platform data to be provided from the machine
+ * file, a platform data pointer can also be supplied along with the
+ * devices names. Usually, the platform data elements that cannot be parsed
+ * from the device tree by the drivers (example: function pointers) are
+ * supplied. But it should be noted that this is a temporary mechanism and
+ * at some point, the drivers should be capable of parsing all the platform
+ * data from the device tree.
+ */
+static const struct of_dev_auxdata s3c2416_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("samsung,s3c2440-uart", S3C2410_PA_UART0,
+				"s3c2440-uart.0", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-uart", S3C2410_PA_UART1,
+				"s3c2440-uart.1", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-uart", S3C2410_PA_UART2,
+				"s3c2440-uart.2", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-uart", S3C2443_PA_UART3,
+				"s3c2440-uart.3", NULL),
+	OF_DEV_AUXDATA("samsung,s3c6410-sdhci", S3C_PA_HSMMC0,
+				"s3c-sdhci.0", NULL),
+	OF_DEV_AUXDATA("samsung,s3c6410-sdhci", S3C_PA_HSMMC1,
+				"s3c-sdhci.1", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-i2c", S3C_PA_IIC,
+				"s3c2440-i2c.0", NULL),
+	{},
+};
+
+static void __init s3c2416_dt_map_io(void)
+{
+	s3c24xx_init_io(NULL, 0);
+	s3c24xx_init_clocks(12000000);
+}
+
+static void __init s3c2416_dt_machine_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table,
+				s3c2416_auxdata_lookup, NULL);
+
+	s3c_pm_init();
+}
+
+static char const *s3c2416_dt_compat[] __initdata = {
+	"samsung,s3c2416",
+	"samsung,s3c2450",
+	NULL
+};
+
+DT_MACHINE_START(S3C2416_DT, "Samsung S3C2416 (Flattened Device Tree)")
+	/* Maintainer: Heiko Stuebner <heiko@sntech.de> */
+	.dt_compat	= s3c2416_dt_compat,
+	.map_io		= s3c2416_dt_map_io,
+	.init_irq	= irqchip_init,
+	.init_machine	= s3c2416_dt_machine_init,
+	 .init_time	= clocksource_of_init,
+	.restart	= s3c2416_restart,
+MACHINE_END
-- 
1.7.2.3
