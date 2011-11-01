From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue,  1 Nov 2011 06:36:53 +0530
Subject: [PATCH v2 2/2] ARM: dts: Add intial dts file for Exynos4210 SoC,
	SMDKV310 and Origen board
In-Reply-To: <1320109613-2811-1-git-send-email-thomas.abraham@linaro.org>
References: <1320109613-2811-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1320109613-2811-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial dts file for Exynos4210 SoC. This dts file describes the SoC
specific devices and properties. Along with this, add dts file for Samsung's
SMDKV310 board and Insignal's Origen board which uses the Exynos4210 dts file
and extends it to describe the board specific properties.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/boot/dts/exynos4210-origen.dts   |  137 ++++++++++
 arch/arm/boot/dts/exynos4210-smdkv310.dts |  182 +++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi         |  397 +++++++++++++++++++++++++++++
 3 files changed, 716 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4210-origen.dts
 create mode 100644 arch/arm/boot/dts/exynos4210-smdkv310.dts
 create mode 100644 arch/arm/boot/dts/exynos4210.dtsi

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
new file mode 100644
index 0000000..b8c4763
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -0,0 +1,137 @@
+/*
+ * Samsung's Exynos4210 based Origen board device tree source
+ *
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2010-2011 Linaro Ltd.
+ *		www.linaro.org
+ *
+ * Device tree source file for Insignal's Origen board which is based on
+ * Samsung's Exynos4210 SoC.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/dts-v1/;
+/include/ "exynos4210.dtsi"
+
+/ {
+	model = "Insignal Origen evaluation board based on Exynos4210";
+	compatible = "insignal,origen", "samsung,exynos4210";
+
+	memory {
+		reg = <0x40000000 0x40000000>;
+	};
+
+	chosen {
+		bootargs ="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC2,115200 init=/linuxrc";
+	};
+
+	sdhci at 12530000 {
+		samsung,sdhci-bus-width = <4>;
+		linux,mmc_cap_4_bit_data;
+		samsung,sdhci-cd-internal;
+		gpio-cd = <&gpk2 2 2 3 3>;
+		gpios = <&gpk2 0 2 0 3>,
+			<&gpk2 1 2 0 3>,
+			<&gpk2 3 2 3 3>,
+			<&gpk2 4 2 3 3>,
+			<&gpk2 5 2 3 3>,
+			<&gpk2 6 2 3 3>;
+	};
+
+	sdhci at 12510000 {
+		samsung,sdhci-bus-width = <4>;
+		linux,mmc_cap_4_bit_data;
+		samsung,sdhci-cd-internal;
+		gpio-cd = <&gpk0 2 2 3 3>;
+		gpios = <&gpk0 0 2 0 3>,
+			<&gpk0 1 2 0 3>,
+			<&gpk0 3 2 3 3>,
+			<&gpk0 4 2 3 3>,
+			<&gpk0 5 2 3 3>,
+			<&gpk0 6 2 3 3>;
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		up {
+			label = "Up";
+			gpios = <&gpx2 0 0 0 2>;
+			linux,code = <103>;
+		};
+
+		down {
+			label = "Down";
+			gpios = <&gpx2 1 0 0 2>;
+			linux,code = <108>;
+		};
+
+		back {
+			label = "Back";
+			gpios = <&gpx1 7 0 0 2>;
+			linux,code = <158>;
+		};
+
+		home {
+			label = "Home";
+			gpios = <&gpx1 6 0 0 2>;
+			linux,code = <102>;
+		};
+
+		menu {
+			label = "Menu";
+			gpios = <&gpx1 5 0 0 2>;
+			linux,code = <139>;
+		};
+	};
+
+	keypad at 100A0000 {
+		status = "disabled";
+	};
+
+	sdhci at 12520000 {
+		status = "disabled";
+	};
+
+	sdhci at 12540000 {
+		status = "disabled";
+	};
+
+	i2c at 13860000 {
+		status = "disabled";
+	};
+
+	i2c at 13870000 {
+		status = "disabled";
+	};
+
+	i2c at 13880000 {
+		status = "disabled";
+	};
+
+	i2c at 13890000 {
+		status = "disabled";
+	};
+
+	i2c at 138A0000 {
+		status = "disabled";
+	};
+
+	i2c at 138B0000 {
+		status = "disabled";
+	};
+
+	i2c at 138C0000 {
+		status = "disabled";
+	};
+
+	i2c at 138D0000 {
+		status = "disabled";
+	};
+};
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
new file mode 100644
index 0000000..27afc8e
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -0,0 +1,182 @@
+/*
+ * Samsung's Exynos4210 based SMDKV310 board device tree source
+ *
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2010-2011 Linaro Ltd.
+ *		www.linaro.org
+ *
+ * Device tree source file for Samsung's SMDKV310 board which is based on
+ * Samsung's Exynos4210 SoC.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/dts-v1/;
+/include/ "exynos4210.dtsi"
+
+/ {
+	model = "Samsung smdkv310 evaluation board based on Exynos4210";
+	compatible = "samsung,smdkv310", "samsung,exynos4210";
+
+	memory {
+		reg = <0x40000000 0x80000000>;
+	};
+
+	chosen {
+		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc";
+	};
+
+	sdhci at 12530000 {
+		samsung,sdhci-bus-width = <4>;
+		linux,mmc_cap_4_bit_data;
+		samsung,sdhci-cd-internal;
+		gpio-cd = <&gpk2 2 2 3 3>;
+		gpios = <&gpk2 0 2 0 3>,
+			<&gpk2 1 2 0 3>,
+			<&gpk2 3 2 3 3>,
+			<&gpk2 4 2 3 3>,
+			<&gpk2 5 2 3 3>,
+			<&gpk2 6 2 3 3>;
+	};
+
+	keypad at 100A0000 {
+		samsung,keypad-num-rows = <2>;
+		samsung,keypad-num-columns = <8>;
+		linux,keypad-no-autorepeat;
+		linux,keypad-wakeup;
+
+		row-gpios = <&gpx2 0 3 3 0>,
+			    <&gpx2 1 3 3 0>;
+
+		col-gpios = <&gpx1 0 3 0 0>,
+			    <&gpx1 1 3 0 0>,
+			    <&gpx1 2 3 0 0>,
+			    <&gpx1 3 3 0 0>,
+			    <&gpx1 4 3 0 0>,
+			    <&gpx1 5 3 0 0>,
+			    <&gpx1 6 3 0 0>,
+			    <&gpx1 7 3 0 0>;
+
+		key_1 {
+			keypad,row = <0>;
+			keypad,column = <3>;
+			linux,code = <2>;
+		};
+
+		key_2 {
+			keypad,row = <0>;
+			keypad,column = <4>;
+			linux,code = <3>;
+		};
+
+		key_3 {
+			keypad,row = <0>;
+			keypad,column = <5>;
+			linux,code = <4>;
+		};
+
+		key_4 {
+			keypad,row = <0>;
+			keypad,column = <6>;
+			linux,code = <5>;
+		};
+
+		key_5 {
+			keypad,row = <0>;
+			keypad,column = <7>;
+			linux,code = <6>;
+		};
+
+		key_a {
+			keypad,row = <1>;
+			keypad,column = <3>;
+			linux,code = <30>;
+		};
+
+		key_b {
+			keypad,row = <1>;
+			keypad,column = <4>;
+			linux,code = <48>;
+		};
+
+		key_c {
+			keypad,row = <1>;
+			keypad,column = <5>;
+			linux,code = <46>;
+		};
+
+		key_d {
+			keypad,row = <1>;
+			keypad,column = <6>;
+			linux,code = <32>;
+		};
+
+		key_e {
+			keypad,row = <1>;
+			keypad,column = <7>;
+			linux,code = <18>;
+		};
+	};
+
+	i2c at 13860000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <20000>;
+		gpios = <&gpd1 0 2 3 0>,
+			<&gpd1 1 2 3 0>;
+
+		eeprom at 50 {
+			compatible = "samsung,24ad0xd1";
+			reg = <0x50>;
+		};
+
+		eeprom at 52 {
+			compatible = "samsung,24ad0xd1";
+			reg = <0x52>;
+		};
+	};
+
+	sdhci at 12510000 {
+		status = "disabled";
+	};
+
+	sdhci at 12520000 {
+		status = "disabled";
+	};
+
+	sdhci at 12540000 {
+		status = "disabled";
+	};
+
+	i2c at 13870000 {
+		status = "disabled";
+	};
+
+	i2c at 13880000 {
+		status = "disabled";
+	};
+
+	i2c at 13890000 {
+		status = "disabled";
+	};
+
+	i2c at 138A0000 {
+		status = "disabled";
+	};
+
+	i2c at 138B0000 {
+		status = "disabled";
+	};
+
+	i2c at 138C0000 {
+		status = "disabled";
+	};
+
+	i2c at 138D0000 {
+		status = "disabled";
+	};
+};
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
new file mode 100644
index 0000000..63d7578
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -0,0 +1,397 @@
+/*
+ * Samsung's Exynos4210 SoC device tree source
+ *
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2010-2011 Linaro Ltd.
+ *		www.linaro.org
+ *
+ * Samsung's Exynos4210 SoC device nodes are listed in this file. Exynos4210
+ * based board files can include this file and provide values for board specfic
+ * bindings.
+ *
+ * Note: This file does not include device nodes for all the controllers in
+ * Exynos4210 SoC. As device tree coverage for Exynos4210 increases, additional
+ * nodes can be added to this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "samsung,exynos4210";
+	interrupt-parent = <&gic>;
+
+	gic:interrupt-controller at 10490000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x10490000 0x1000>, <0x10480000 0x100>;
+	};
+
+	watchdog at 10060000 {
+		compatible = "samsung,s3c2410-wdt";
+		reg = <0x10060000 0x100>;
+		interrupts = <0 43 0>;
+	};
+
+	rtc at 10070000 {
+		compatible = "samsung,s3c6410-rtc";
+		reg = <0x10070000 0x100>;
+		interrupts = <0 44 0>, <0 45 0>;
+	};
+
+	keypad at 100A0000 {
+		compatible = "samsung,s5pv210-keypad";
+		reg = <0x100A0000 0x100>;
+		interrupts = <0 109 0>;
+	};
+
+	sdhci at 12510000 {
+		compatible = "samsung,exynos4210-sdhci";
+		reg = <0x12510000 0x100>;
+		interrupts = <0 73 0>;
+	};
+
+	sdhci at 12520000 {
+		compatible = "samsung,exynos4210-sdhci";
+		reg = <0x12520000 0x100>;
+		interrupts = <0 74 0>;
+	};
+
+	sdhci at 12530000 {
+		compatible = "samsung,exynos4210-sdhci";
+		reg = <0x12530000 0x100>;
+		interrupts = <0 75 0>;
+	};
+
+	sdhci at 12540000 {
+		compatible = "samsung,exynos4210-sdhci";
+		reg = <0x12540000 0x100>;
+		interrupts = <0 76 0>;
+	};
+
+	serial at 13800000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x13800000 0x100>;
+		interrupts = <0 52 0>;
+	};
+
+	serial at 13810000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x13810000 0x100>;
+		interrupts = <0 53 0>;
+	};
+
+	serial at 13820000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x13820000 0x100>;
+		interrupts = <0 54 0>;
+	};
+
+	serial at 13830000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x13830000 0x100>;
+		interrupts = <0 55 0>;
+	};
+
+	i2c at 13860000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x13860000 0x100>;
+		interrupts = <0 58 0>;
+	};
+
+	i2c at 13870000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x13870000 0x100>;
+		interrupts = <0 59 0>;
+	};
+
+	i2c at 13880000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x13880000 0x100>;
+		interrupts = <0 60 0>;
+	};
+
+	i2c at 13890000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x13890000 0x100>;
+		interrupts = <0 61 0>;
+	};
+
+	i2c at 138A0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x138A0000 0x100>;
+		interrupts = <0 62 0>;
+	};
+
+	i2c at 138B0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x138B0000 0x100>;
+		interrupts = <0 63 0>;
+	};
+
+	i2c at 138C0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x138C0000 0x100>;
+		interrupts = <0 64 0>;
+	};
+
+	i2c at 138D0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x138D0000 0x100>;
+		interrupts = <0 65 0>;
+	};
+
+	amba {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "arm,amba-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		pdma0: pdma at 12680000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12680000 0x1000>;
+			interrupts = <0 35 0>;
+		};
+
+		pdma1: pdma at 12690000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12690000 0x1000>;
+			interrupts = <0 36 0>;
+		};
+	};
+
+	gpio-controllers {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		gpio-controller;
+		ranges;
+
+		gpa0: gpio-controller at 11400000 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400000 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpa1: gpio-controller at 11400020 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400020 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpb: gpio-controller at 11400040 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400040 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpc0: gpio-controller at 11400060 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400060 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpc1: gpio-controller at 11400080 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400080 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpd0: gpio-controller at 114000A0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x114000A0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpd1: gpio-controller at 114000C0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x114000C0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpe0: gpio-controller at 114000E0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x114000E0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpe1: gpio-controller at 11400100 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400100 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpe2: gpio-controller at 11400120 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400120 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpe3: gpio-controller at 11400140 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400140 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpe4: gpio-controller at 11400160 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400160 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpf0: gpio-controller at 11400180 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11400180 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpf1: gpio-controller at 114001A0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x114001A0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpf2: gpio-controller at 114001C0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x114001C0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpf3: gpio-controller at 114001E0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x114001E0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpj0: gpio-controller at 11000000 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11000000 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpj1: gpio-controller at 11000020 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11000020 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpk0: gpio-controller at 11000040 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11000040 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpk1: gpio-controller at 11000060 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11000060 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpk2: gpio-controller at 11000080 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11000080 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpk3: gpio-controller at 110000A0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x110000A0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpl0: gpio-controller at 110000C0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x110000C0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpl1: gpio-controller at 110000E0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x110000E0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpl2: gpio-controller at 11000100 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11000100 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpy0: gpio-controller at 11000120 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11000120 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpy1: gpio-controller at 11000140 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11000140 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpy2: gpio-controller at 11000160 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11000160 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpy3: gpio-controller at 11000180 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11000180 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpy4: gpio-controller at 110001A0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x110001A0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpy5: gpio-controller at 110001C0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x110001C0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpy6: gpio-controller at 110001E0 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x110001E0 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpx0: gpio-controller at 11000C00 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11000C00 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpx1: gpio-controller at 11000C20 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11000C20 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpx2: gpio-controller at 11000C40 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11000C40 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpx3: gpio-controller at 11000C60 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x11000C60 0x20>;
+			#gpio-cells = <4>;
+		};
+
+		gpz: gpio-controller at 03860000 {
+			compatible = "samsung,exynos4-gpio";
+			reg = <0x03860000 0x20>;
+			#gpio-cells = <4>;
+		};
+	};
+};
-- 
1.7.4.4
