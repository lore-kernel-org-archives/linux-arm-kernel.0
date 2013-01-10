From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 10 Jan 2013 15:38:52 -0800
Subject: [PATCH] ARM: dts: sorting the device nodes in alphabetical order for
 EXYNOS DT
Message-ID: <1357861132-16275-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To reduce merge conflicts it would be easier maintain the device nodes
under the root node sorted in alphabetical order.

Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi            |  270 +++++++++---------
 arch/arm/boot/dts/exynos4210-origen.dts   |   82 +++---
 arch/arm/boot/dts/exynos4210-smdkv310.dts |   80 +++---
 arch/arm/boot/dts/exynos4210-trats.dts    |  152 +++++------
 arch/arm/boot/dts/exynos4210.dtsi         |   20 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts |  122 ++++-----
 arch/arm/boot/dts/exynos5250-snow.dts     |   24 +-
 arch/arm/boot/dts/exynos5250.dtsi         |  425 +++++++++++++++--------------
 arch/arm/boot/dts/exynos5440-ssdk5440.dts |   10 +-
 arch/arm/boot/dts/exynos5440.dtsi         |  114 ++++----
 10 files changed, 658 insertions(+), 641 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index e1347fc..ead18e3 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -14,6 +14,10 @@
  * Exynos4 SoCs. As device tree coverage for Exynos4 increases, additional
  * nodes can be added to this file.
  *
+ * One more Note: The device nodes under root node are sorted in alphabetical
+ * order. Please ensure that any new additions into this file maintain the
+ * device nodes in sorted manner.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -25,9 +29,6 @@
 	interrupt-parent = <&gic>;
 
 	aliases {
-		spi0 = &spi_0;
-		spi1 = &spi_1;
-		spi2 = &spi_2;
 		i2c0 = &i2c_0;
 		i2c1 = &i2c_1;
 		i2c2 = &i2c_2;
@@ -36,26 +37,128 @@
 		i2c5 = &i2c_5;
 		i2c6 = &i2c_6;
 		i2c7 = &i2c_7;
+		spi0 = &spi_0;
+		spi1 = &spi_1;
+		spi2 = &spi_2;
 	};
 
-	pd_mfc: mfc-power-domain at 10023C40 {
-		compatible = "samsung,exynos4210-pd";
-		reg = <0x10023C40 0x20>;
+	amba {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "arm,amba-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		mdma1: mdma at 12850000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12850000 0x1000>;
+			interrupts = <0 34 0>;
+		};
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
 	};
 
-	pd_g3d: g3d-power-domain at 10023C60 {
-		compatible = "samsung,exynos4210-pd";
-		reg = <0x10023C60 0x20>;
+	combiner:interrupt-controller at 10440000 {
+		compatible = "samsung,exynos4210-combiner";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0x10440000 0x1000>;
 	};
 
-	pd_lcd0: lcd0-power-domain at 10023C80 {
-		compatible = "samsung,exynos4210-pd";
-		reg = <0x10023C80 0x20>;
+	gic:interrupt-controller at 10490000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x10490000 0x1000>, <0x10480000 0x100>;
 	};
 
-	pd_tv: tv-power-domain at 10023C20 {
-		compatible = "samsung,exynos4210-pd";
-		reg = <0x10023C20 0x20>;
+	i2c_0: i2c at 13860000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x13860000 0x100>;
+		interrupts = <0 58 0>;
+		status = "disabled";
+	};
+
+	i2c_1: i2c at 13870000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x13870000 0x100>;
+		interrupts = <0 59 0>;
+		status = "disabled";
+	};
+
+	i2c_2: i2c at 13880000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x13880000 0x100>;
+		interrupts = <0 60 0>;
+		status = "disabled";
+	};
+
+	i2c_3: i2c at 13890000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x13890000 0x100>;
+		interrupts = <0 61 0>;
+		status = "disabled";
+	};
+
+	i2c_4: i2c at 138A0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x138A0000 0x100>;
+		interrupts = <0 62 0>;
+		status = "disabled";
+	};
+
+	i2c_5: i2c at 138B0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x138B0000 0x100>;
+		interrupts = <0 63 0>;
+		status = "disabled";
+	};
+
+	i2c_6: i2c at 138C0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x138C0000 0x100>;
+		interrupts = <0 64 0>;
+		status = "disabled";
+	};
+
+	i2c_7: i2c at 138D0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x138D0000 0x100>;
+		interrupts = <0 65 0>;
+		status = "disabled";
+	};
+
+	keypad at 100A0000 {
+		compatible = "samsung,s5pv210-keypad";
+		reg = <0x100A0000 0x100>;
+		interrupts = <0 109 0>;
+		status = "disabled";
 	};
 
 	pd_cam: cam-power-domain at 10023C00 {
@@ -63,30 +166,29 @@
 		reg = <0x10023C00 0x20>;
 	};
 
+	pd_g3d: g3d-power-domain at 10023C60 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023C60 0x20>;
+	};
+
 	pd_gps: gps-power-domain at 10023CE0 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023CE0 0x20>;
 	};
 
-	gic:interrupt-controller at 10490000 {
-		compatible = "arm,cortex-a9-gic";
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		reg = <0x10490000 0x1000>, <0x10480000 0x100>;
+	pd_lcd0: lcd0-power-domain at 10023C80 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023C80 0x20>;
 	};
 
-	combiner:interrupt-controller at 10440000 {
-		compatible = "samsung,exynos4210-combiner";
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		reg = <0x10440000 0x1000>;
+	pd_mfc: mfc-power-domain at 10023C40 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023C40 0x20>;
 	};
 
-	watchdog at 10060000 {
-		compatible = "samsung,s3c2410-wdt";
-		reg = <0x10060000 0x100>;
-		interrupts = <0 43 0>;
-		status = "disabled";
+	pd_tv: tv-power-domain at 10023C20 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023C20 0x20>;
 	};
 
 	rtc at 10070000 {
@@ -96,13 +198,6 @@
 		status = "disabled";
 	};
 
-	keypad at 100A0000 {
-		compatible = "samsung,s5pv210-keypad";
-		reg = <0x100A0000 0x100>;
-		interrupts = <0 109 0>;
-		status = "disabled";
-	};
-
 	sdhci at 12510000 {
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12510000 0x100>;
@@ -159,78 +254,6 @@
 		status = "disabled";
 	};
 
-	i2c_0: i2c at 13860000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x13860000 0x100>;
-		interrupts = <0 58 0>;
-		status = "disabled";
-	};
-
-	i2c_1: i2c at 13870000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x13870000 0x100>;
-		interrupts = <0 59 0>;
-		status = "disabled";
-	};
-
-	i2c_2: i2c at 13880000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x13880000 0x100>;
-		interrupts = <0 60 0>;
-		status = "disabled";
-	};
-
-	i2c_3: i2c at 13890000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x13890000 0x100>;
-		interrupts = <0 61 0>;
-		status = "disabled";
-	};
-
-	i2c_4: i2c at 138A0000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x138A0000 0x100>;
-		interrupts = <0 62 0>;
-		status = "disabled";
-	};
-
-	i2c_5: i2c at 138B0000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x138B0000 0x100>;
-		interrupts = <0 63 0>;
-		status = "disabled";
-	};
-
-	i2c_6: i2c at 138C0000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x138C0000 0x100>;
-		interrupts = <0 64 0>;
-		status = "disabled";
-	};
-
-	i2c_7: i2c at 138D0000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x138D0000 0x100>;
-		interrupts = <0 65 0>;
-		status = "disabled";
-	};
-
 	spi_0: spi at 13920000 {
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x13920000 0x100>;
@@ -264,29 +287,10 @@
 		status = "disabled";
 	};
 
-	amba {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "arm,amba-bus";
-		interrupt-parent = <&gic>;
-		ranges;
-
-		pdma0: pdma at 12680000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x12680000 0x1000>;
-			interrupts = <0 35 0>;
-		};
-
-		pdma1: pdma at 12690000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x12690000 0x1000>;
-			interrupts = <0 36 0>;
-		};
-
-		mdma1: mdma at 12850000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x12850000 0x1000>;
-			interrupts = <0 34 0>;
-		};
+	watchdog at 10060000 {
+		compatible = "samsung,s3c2410-wdt";
+		reg = <0x10060000 0x100>;
+		interrupts = <0 43 0>;
+		status = "disabled";
 	};
 };
diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index f271001..41f36e9 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -32,47 +32,6 @@
 		bootargs ="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC2,115200 init=/linuxrc";
 	};
 
-	mmc_reg: voltage-regulator {
-	        compatible = "regulator-fixed";
-		regulator-name = "VMEM_VDD_2.8V";
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-		gpio = <&gpx1 1 0>;
-		enable-active-high;
-	};
-
-	sdhci at 12530000 {
-		bus-width = <4>;
-		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sd2_cd>;
-		pinctrl-names = "default";
-		vmmc-supply = <&mmc_reg>;
-		status = "okay";
-	};
-
-	sdhci at 12510000 {
-		bus-width = <4>;
-		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_cd>;
-		pinctrl-names = "default";
-		vmmc-supply = <&mmc_reg>;
-		status = "okay";
-	};
-
-	serial at 13800000 {
-		status = "okay";
-	};
-
-	serial at 13810000 {
-		status = "okay";
-	};
-
-	serial at 13820000 {
-		status = "okay";
-	};
-
-	serial at 13830000 {
-		status = "okay";
-	};
-
 	gpio_keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
@@ -121,4 +80,45 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	mmc_reg: voltage-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VMEM_VDD_2.8V";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&gpx1 1 0>;
+		enable-active-high;
+	};
+
+	sdhci at 12510000 {
+		bus-width = <4>;
+		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_cd>;
+		pinctrl-names = "default";
+		vmmc-supply = <&mmc_reg>;
+		status = "okay";
+	};
+
+	sdhci at 12530000 {
+		bus-width = <4>;
+		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sd2_cd>;
+		pinctrl-names = "default";
+		vmmc-supply = <&mmc_reg>;
+		status = "okay";
+	};
+
+	serial at 13800000 {
+		status = "okay";
+	};
+
+	serial at 13810000 {
+		status = "okay";
+	};
+
+	serial at 13820000 {
+		status = "okay";
+	};
+
+	serial at 13830000 {
+		status = "okay";
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index f634907..405b49b 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -29,34 +29,24 @@
 		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc";
 	};
 
-	sdhci at 12530000 {
-		samsung,sdhci-bus-width = <4>;
-		linux,mmc_cap_4_bit_data;
-		samsung,sdhci-cd-internal;
-		gpio-cd = <&gpk2 2 2 3 3>;
-		gpios = <&gpk2 0 2 0 3>,
-			<&gpk2 1 2 0 3>,
-			<&gpk2 3 2 3 3>,
-			<&gpk2 4 2 3 3>,
-			<&gpk2 5 2 3 3>,
-			<&gpk2 6 2 3 3>;
-		status = "okay";
-	};
-
-	serial at 13800000 {
-		status = "okay";
-	};
-
-	serial at 13810000 {
+	i2c at 13860000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <20000>;
+		gpios = <&gpd1 0 2 3 0>,
+			<&gpd1 1 2 3 0>;
 		status = "okay";
-	};
 
-	serial at 13820000 {
-		status = "okay";
-	};
+		eeprom at 50 {
+			compatible = "samsung,24ad0xd1";
+			reg = <0x50>;
+		};
 
-	serial at 13830000 {
-		status = "okay";
+		eeprom at 52 {
+			compatible = "samsung,24ad0xd1";
+			reg = <0x52>;
+		};
 	};
 
 	keypad at 100A0000 {
@@ -139,24 +129,34 @@
 		};
 	};
 
-	i2c at 13860000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-max-bus-freq = <20000>;
-		gpios = <&gpd1 0 2 3 0>,
-			<&gpd1 1 2 3 0>;
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
 		status = "okay";
+	};
 
-		eeprom at 50 {
-			compatible = "samsung,24ad0xd1";
-			reg = <0x50>;
-		};
+	serial at 13800000 {
+		status = "okay";
+	};
 
-		eeprom at 52 {
-			compatible = "samsung,24ad0xd1";
-			reg = <0x52>;
-		};
+	serial at 13810000 {
+		status = "okay";
+	};
+
+	serial at 13820000 {
+		status = "okay";
+	};
+
+	serial at 13830000 {
+		status = "okay";
 	};
 
 	spi_2: spi at 13940000 {
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index c346b64..e73f825 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -30,82 +30,6 @@
 		bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rootwait earlyprintk panic=5";
 	};
 
-	vemmc_reg: voltage-regulator at 0 {
-	        compatible = "regulator-fixed";
-		regulator-name = "VMEM_VDD_2.8V";
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-		gpio = <&gpk0 2 0>;
-		enable-active-high;
-	};
-
-	sdhci_emmc: sdhci at 12510000 {
-		bus-width = <8>;
-		non-removable;
-		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus8>;
-		pinctrl-names = "default";
-		vmmc-supply = <&vemmc_reg>;
-		status = "okay";
-	};
-
-	serial at 13800000 {
-		status = "okay";
-	};
-
-	serial at 13810000 {
-		status = "okay";
-	};
-
-	serial at 13820000 {
-		status = "okay";
-	};
-
-	serial at 13830000 {
-		status = "okay";
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		vol-down-key {
-			gpios = <&gpx2 1 1>;
-			linux,code = <114>;
-			label = "volume down";
-			debounce-interval = <10>;
-		};
-
-		vol-up-key {
-			gpios = <&gpx2 0 1>;
-			linux,code = <115>;
-			label = "volume up";
-			debounce-interval = <10>;
-		};
-
-		power-key {
-			gpios = <&gpx2 7 1>;
-			linux,code = <116>;
-			label = "power";
-			debounce-interval = <10>;
-			gpio-key,wakeup;
-		};
-
-		ok-key {
-			gpios = <&gpx3 5 1>;
-			linux,code = <352>;
-			label = "ok";
-			debounce-interval = <10>;
-		};
-	};
-
-	tsp_reg: voltage-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "TSP_FIXED_VOLTAGES";
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-		gpio = <&gpl0 3 0>;
-		enable-active-high;
-	};
-
 	i2c at 13890000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-slave-addr = <0x10>;
@@ -289,4 +213,80 @@
 			};
 		};
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		vol-down-key {
+			gpios = <&gpx2 1 1>;
+			linux,code = <114>;
+			label = "volume down";
+			debounce-interval = <10>;
+		};
+
+		vol-up-key {
+			gpios = <&gpx2 0 1>;
+			linux,code = <115>;
+			label = "volume up";
+			debounce-interval = <10>;
+		};
+
+		power-key {
+			gpios = <&gpx2 7 1>;
+			linux,code = <116>;
+			label = "power";
+			debounce-interval = <10>;
+			gpio-key,wakeup;
+		};
+
+		ok-key {
+			gpios = <&gpx3 5 1>;
+			linux,code = <352>;
+			label = "ok";
+			debounce-interval = <10>;
+		};
+	};
+
+	sdhci_emmc: sdhci at 12510000 {
+		bus-width = <8>;
+		non-removable;
+		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus8>;
+		pinctrl-names = "default";
+		vmmc-supply = <&vemmc_reg>;
+		status = "okay";
+	};
+
+	serial at 13800000 {
+		status = "okay";
+	};
+
+	serial at 13810000 {
+		status = "okay";
+	};
+
+	serial at 13820000 {
+		status = "okay";
+	};
+
+	serial at 13830000 {
+		status = "okay";
+	};
+
+	tsp_reg: voltage-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "TSP_FIXED_VOLTAGES";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&gpl0 3 0>;
+		enable-active-high;
+	};
+
+	vemmc_reg: voltage-regulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "VMEM_VDD_2.8V";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&gpk0 2 0>;
+		enable-active-high;
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index e31bfc4..10c0041 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -14,6 +14,10 @@
  * Exynos4210 SoC. As device tree coverage for Exynos4210 increases, additional
  * nodes can be added to this file.
  *
+ * One more Note: The device nodes under root node are sorted in alphabetical
+ * order. Please ensure that any new additions into this file maintain the
+ * device nodes in sorted manner.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -31,20 +35,20 @@
 		pinctrl2 = &pinctrl_2;
 	};
 
-	pd_lcd1: lcd1-power-domain at 10023CA0 {
-		compatible = "samsung,exynos4210-pd";
-		reg = <0x10023CA0 0x20>;
+	combiner:interrupt-controller at 10440000 {
+		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
+			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
+			     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
+			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
 	};
 
 	gic:interrupt-controller at 10490000 {
 		cpu-offset = <0x8000>;
 	};
 
-	combiner:interrupt-controller at 10440000 {
-		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
-			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
-			     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
-			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
+	pd_lcd1: lcd1-power-domain at 10023CA0 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10023CA0 0x20>;
 	};
 
 	pinctrl_0: pinctrl at 11400000 {
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 942d576..546fbe6 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -27,6 +27,65 @@
 		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC2,115200 init=/linuxrc";
 	};
 
+	codec at 11000000 {
+		samsung,mfc-r = <0x43000000 0x800000>;
+		samsung,mfc-l = <0x51000000 0x800000>;
+	};
+
+	dwmmc0 at 12200000 {
+		num-slots = <1>;
+		supports-highspeed;
+		broken-cd;
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
+
+		slot at 0 {
+			reg = <0>;
+			bus-width = <8>;
+			gpios = <&gpc0 0 2 0 3>, <&gpc0 1 2 0 3>,
+				<&gpc1 0 2 3 3>, <&gpc1 1 2 3 3>,
+				<&gpc1 2 2 3 3>, <&gpc1 3 2 3 3>,
+				<&gpc0 3 2 3 3>, <&gpc0 4 2 3 3>,
+				<&gpc0 5 2 3 3>, <&gpc0 6 2 3 3>;
+		};
+	};
+
+	dwmmc1 at 12210000 {
+		status = "disabled";
+	};
+
+	dwmmc2 at 12220000 {
+		num-slots = <1>;
+		supports-highspeed;
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
+
+		slot at 0 {
+			reg = <0>;
+			bus-width = <4>;
+			samsung,cd-pinmux-gpio = <&gpc3 2 2 3 3>;
+			gpios = <&gpc3 0 2 0 3>, <&gpc3 1 2 0 3>,
+				<&gpc3 3 2 3 3>, <&gpc3 4 2 3 3>,
+				<&gpc3 5 2 3 3>, <&gpc3 6 2 3 3>,
+				<&gpc4 3 3 3 3>, <&gpc4 3 3 3 3>,
+				<&gpc4 5 3 3 3>, <&gpc4 6 3 3 3>;
+		};
+	};
+
+	dwmmc3 at 12230000 {
+		status = "disabled";
+	};
+
+	hdmi {
+		hpd-gpio = <&gpx3 7 0xf 1 3>;
+	};
+
 	i2c at 12C60000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <20000>;
@@ -62,10 +121,6 @@
 		};
 	};
 
-	sata at 122F0000 {
-		samsung,sata-freq = <66>;
-	};
-
 	i2c at 12C80000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
@@ -108,54 +163,8 @@
 		};
 	};
 
-	dwmmc0 at 12200000 {
-		num-slots = <1>;
-		supports-highspeed;
-		broken-cd;
-		fifo-depth = <0x80>;
-		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3 3>;
-		samsung,dw-mshc-ddr-timing = <1 2 3>;
-
-		slot at 0 {
-			reg = <0>;
-			bus-width = <8>;
-			gpios = <&gpc0 0 2 0 3>, <&gpc0 1 2 0 3>,
-				<&gpc1 0 2 3 3>, <&gpc1 1 2 3 3>,
-				<&gpc1 2 2 3 3>, <&gpc1 3 2 3 3>,
-				<&gpc0 3 2 3 3>, <&gpc0 4 2 3 3>,
-				<&gpc0 5 2 3 3>, <&gpc0 6 2 3 3>;
-		};
-	};
-
-	dwmmc1 at 12210000 {
-		status = "disabled";
-	};
-
-	dwmmc2 at 12220000 {
-		num-slots = <1>;
-		supports-highspeed;
-		fifo-depth = <0x80>;
-		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3 3>;
-		samsung,dw-mshc-ddr-timing = <1 2 3>;
-
-		slot at 0 {
-			reg = <0>;
-			bus-width = <4>;
-			samsung,cd-pinmux-gpio = <&gpc3 2 2 3 3>;
-			gpios = <&gpc3 0 2 0 3>, <&gpc3 1 2 0 3>,
-				<&gpc3 3 2 3 3>, <&gpc3 4 2 3 3>,
-				<&gpc3 5 2 3 3>, <&gpc3 6 2 3 3>,
-				<&gpc4 3 3 3 3>, <&gpc4 3 3 3 3>,
-				<&gpc4 5 3 3 3>, <&gpc4 6 3 3 3>;
-		};
-	};
-
-	dwmmc3 at 12230000 {
-		status = "disabled";
+	sata at 122F0000 {
+		samsung,sata-freq = <66>;
 	};
 
 	spi_0: spi at 12d20000 {
@@ -195,13 +204,4 @@
 	spi_2: spi at 12d40000 {
 		status = "disabled";
 	};
-
-	hdmi {
-		hpd-gpio = <&gpx3 7 0xf 1 3>;
-	};
-
-	codec at 11000000 {
-		samsung,mfc-r = <0x43000000 0x800000>;
-		samsung,mfc-l = <0x51000000 0x800000>;
-	};
 };
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 17dd951..4293d34 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -16,6 +16,18 @@
 	model = "Google Snow";
 	compatible = "google,snow", "samsung,exynos5250";
 
+	/*
+	 * On Snow we've got SIP WiFi and so can keep drive strengths low to
+	 * reduce EMI.
+	 */
+	dwmmc3 at 12230000 {
+		slot at 0 {
+			gpios = <&gpc4 0 2 0 0>, <&gpc4 1 2 3 0>,
+				<&gpc4 3 2 3 0>, <&gpc4 4 2 3 0>,
+				<&gpc4 5 2 3 0>, <&gpc4 6 2 3 0>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -28,16 +40,4 @@
 			gpio-key,wakeup;
 		};
 	};
-
-	/*
-	 * On Snow we've got SIP WiFi and so can keep drive strengths low to
-	 * reduce EMI.
-	 */
-	dwmmc3 at 12230000 {
-		slot at 0 {
-			gpios = <&gpc4 0 2 0 0>, <&gpc4 1 2 3 0>,
-				<&gpc4 3 2 3 0>, <&gpc4 4 2 3 0>,
-				<&gpc4 5 2 3 0>, <&gpc4 6 2 3 0>;
-		};
-	};
 };
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 3acf594..c7cfed3 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -12,6 +12,10 @@
  * EXYNOS5250 SoC. As device tree coverage for EXYNOS5250 increases,
  * additional nodes can be added to this file.
  *
+ * One more Note: The device nodes under root node are sorted in alphabetical
+ * order. Please ensure that any new additions into this file maintain the
+ * device nodes in sorted manner.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -24,17 +28,10 @@
 	interrupt-parent = <&gic>;
 
 	aliases {
-		spi0 = &spi_0;
-		spi1 = &spi_1;
-		spi2 = &spi_2;
 		gsc0 = &gsc_0;
 		gsc1 = &gsc_1;
 		gsc2 = &gsc_2;
 		gsc3 = &gsc_3;
-		mshc0 = &dwmmc_0;
-		mshc1 = &dwmmc_1;
-		mshc2 = &dwmmc_2;
-		mshc3 = &dwmmc_3;
 		i2c0 = &i2c_0;
 		i2c1 = &i2c_1;
 		i2c2 = &i2c_2;
@@ -44,13 +41,51 @@
 		i2c6 = &i2c_6;
 		i2c7 = &i2c_7;
 		i2c8 = &i2c_8;
+		mshc0 = &dwmmc_0;
+		mshc1 = &dwmmc_1;
+		mshc2 = &dwmmc_2;
+		mshc3 = &dwmmc_3;
+		spi0 = &spi_0;
+		spi1 = &spi_1;
+		spi2 = &spi_2;
 	};
 
-	gic:interrupt-controller at 10481000 {
-		compatible = "arm,cortex-a9-gic";
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		reg = <0x10481000 0x1000>, <0x10482000 0x2000>;
+	amba {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "arm,amba-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		pdma0: pdma at 121A0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121A0000 0x1000>;
+			interrupts = <0 34 0>;
+		};
+
+		pdma1: pdma at 121B0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121B0000 0x1000>;
+			interrupts = <0 35 0>;
+		};
+
+		mdma0: mdma at 10800000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x10800000 0x1000>;
+			interrupts = <0 33 0>;
+		};
+
+		mdma1: mdma at 11C10000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x11C10000 0x1000>;
+			interrupts = <0 124 0>;
+		};
+	};
+
+	codec at 11000000 {
+		compatible = "samsung,mfc-v6";
+		reg = <0x11000000 0x10000>;
+		interrupts = <0 96 0>;
 	};
 
 	combiner:interrupt-controller at 10440000 {
@@ -69,174 +104,6 @@
 			     <0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
 	};
 
-	watchdog {
-		compatible = "samsung,s3c2410-wdt";
-		reg = <0x101D0000 0x100>;
-		interrupts = <0 42 0>;
-	};
-
-	codec at 11000000 {
-		compatible = "samsung,mfc-v6";
-		reg = <0x11000000 0x10000>;
-		interrupts = <0 96 0>;
-	};
-
-	rtc {
-		compatible = "samsung,s3c6410-rtc";
-		reg = <0x101E0000 0x100>;
-		interrupts = <0 43 0>, <0 44 0>;
-	};
-
-	tmu at 10060000 {
-		compatible = "samsung,exynos5250-tmu";
-		reg = <0x10060000 0x100>;
-		interrupts = <0 65 0>;
-	};
-
-	serial at 12C00000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0x12C00000 0x100>;
-		interrupts = <0 51 0>;
-	};
-
-	serial at 12C10000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0x12C10000 0x100>;
-		interrupts = <0 52 0>;
-	};
-
-	serial at 12C20000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0x12C20000 0x100>;
-		interrupts = <0 53 0>;
-	};
-
-	serial at 12C30000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0x12C30000 0x100>;
-		interrupts = <0 54 0>;
-	};
-
-	sata at 122F0000 {
-		compatible = "samsung,exynos5-sata-ahci";
-		reg = <0x122F0000 0x1ff>;
-		interrupts = <0 115 0>;
-	};
-
-	sata-phy at 12170000 {
-		compatible = "samsung,exynos5-sata-phy";
-		reg = <0x12170000 0x1ff>;
-	};
-
-	i2c_0: i2c at 12C60000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x12C60000 0x100>;
-		interrupts = <0 56 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	i2c_1: i2c at 12C70000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x12C70000 0x100>;
-		interrupts = <0 57 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	i2c_2: i2c at 12C80000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x12C80000 0x100>;
-		interrupts = <0 58 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	i2c_3: i2c at 12C90000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x12C90000 0x100>;
-		interrupts = <0 59 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	i2c_4: i2c at 12CA0000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x12CA0000 0x100>;
-		interrupts = <0 60 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	i2c_5: i2c at 12CB0000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x12CB0000 0x100>;
-		interrupts = <0 61 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	i2c_6: i2c at 12CC0000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x12CC0000 0x100>;
-		interrupts = <0 62 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	i2c_7: i2c at 12CD0000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x12CD0000 0x100>;
-		interrupts = <0 63 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	i2c_8: i2c at 12CE0000 {
-		compatible = "samsung,s3c2440-hdmiphy-i2c";
-		reg = <0x12CE0000 0x1000>;
-		interrupts = <0 64 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	i2c at 121D0000 {
-                compatible = "samsung,exynos5-sata-phy-i2c";
-                reg = <0x121D0000 0x100>;
-                #address-cells = <1>;
-                #size-cells = <0>;
-	};
-
-	spi_0: spi at 12d20000 {
-		compatible = "samsung,exynos4210-spi";
-		reg = <0x12d20000 0x100>;
-		interrupts = <0 66 0>;
-		tx-dma-channel = <&pdma0 5>; /* preliminary */
-		rx-dma-channel = <&pdma0 4>; /* preliminary */
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	spi_1: spi at 12d30000 {
-		compatible = "samsung,exynos4210-spi";
-		reg = <0x12d30000 0x100>;
-		interrupts = <0 67 0>;
-		tx-dma-channel = <&pdma1 5>; /* preliminary */
-		rx-dma-channel = <&pdma1 4>; /* preliminary */
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	spi_2: spi at 12d40000 {
-		compatible = "samsung,exynos4210-spi";
-		reg = <0x12d40000 0x100>;
-		interrupts = <0 68 0>;
-		tx-dma-channel = <&pdma0 7>; /* preliminary */
-		rx-dma-channel = <&pdma0 6>; /* preliminary */
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
 	dwmmc_0: dwmmc0 at 12200000 {
 		compatible = "samsung,exynos5250-dw-mshc";
 		reg = <0x12200000 0x1000>;
@@ -269,36 +136,11 @@
 		#size-cells = <0>;
 	};
 
-	amba {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "arm,amba-bus";
-		interrupt-parent = <&gic>;
-		ranges;
-
-		pdma0: pdma at 121A0000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x121A0000 0x1000>;
-			interrupts = <0 34 0>;
-		};
-
-		pdma1: pdma at 121B0000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x121B0000 0x1000>;
-			interrupts = <0 35 0>;
-		};
-
-		mdma0: mdma at 10800000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x10800000 0x1000>;
-			interrupts = <0 33 0>;
-		};
-
-		mdma1: mdma at 11C10000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x11C10000 0x1000>;
-			interrupts = <0 124 0>;
-		};
+	gic:interrupt-controller at 10481000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x10481000 0x1000>, <0x10482000 0x2000>;
 	};
 
 	gpio-controllers {
@@ -578,9 +420,172 @@
 		interrupts = <0 95 0>;
 	};
 
+	i2c_0: i2c at 12C60000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12C60000 0x100>;
+		interrupts = <0 56 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	i2c_1: i2c at 12C70000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12C70000 0x100>;
+		interrupts = <0 57 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	i2c_2: i2c at 12C80000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12C80000 0x100>;
+		interrupts = <0 58 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	i2c_3: i2c at 12C90000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12C90000 0x100>;
+		interrupts = <0 59 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	i2c_4: i2c at 12CA0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12CA0000 0x100>;
+		interrupts = <0 60 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	i2c_5: i2c at 12CB0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12CB0000 0x100>;
+		interrupts = <0 61 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	i2c_6: i2c at 12CC0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12CC0000 0x100>;
+		interrupts = <0 62 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	i2c_7: i2c at 12CD0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x12CD0000 0x100>;
+		interrupts = <0 63 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	i2c_8: i2c at 12CE0000 {
+		compatible = "samsung,s3c2440-hdmiphy-i2c";
+		reg = <0x12CE0000 0x1000>;
+		interrupts = <0 64 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	i2c at 121D0000 {
+		compatible = "samsung,exynos5-sata-phy-i2c";
+		reg = <0x121D0000 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
 	mixer {
 		compatible = "samsung,exynos5-mixer";
 		reg = <0x14450000 0x10000>;
 		interrupts = <0 94 0>;
 	};
+
+	rtc {
+		compatible = "samsung,s3c6410-rtc";
+		reg = <0x101E0000 0x100>;
+		interrupts = <0 43 0>, <0 44 0>;
+	};
+
+	sata at 122F0000 {
+		compatible = "samsung,exynos5-sata-ahci";
+		reg = <0x122F0000 0x1ff>;
+		interrupts = <0 115 0>;
+	};
+
+	sata-phy at 12170000 {
+		compatible = "samsung,exynos5-sata-phy";
+		reg = <0x12170000 0x1ff>;
+	};
+
+	serial at 12C00000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x12C00000 0x100>;
+		interrupts = <0 51 0>;
+	};
+
+	serial at 12C10000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x12C10000 0x100>;
+		interrupts = <0 52 0>;
+	};
+
+	serial at 12C20000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x12C20000 0x100>;
+		interrupts = <0 53 0>;
+	};
+
+	serial at 12C30000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x12C30000 0x100>;
+		interrupts = <0 54 0>;
+	};
+
+	spi_0: spi at 12d20000 {
+		compatible = "samsung,exynos4210-spi";
+		reg = <0x12d20000 0x100>;
+		interrupts = <0 66 0>;
+		tx-dma-channel = <&pdma0 5>; /* preliminary */
+		rx-dma-channel = <&pdma0 4>; /* preliminary */
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	spi_1: spi at 12d30000 {
+		compatible = "samsung,exynos4210-spi";
+		reg = <0x12d30000 0x100>;
+		interrupts = <0 67 0>;
+		tx-dma-channel = <&pdma1 5>; /* preliminary */
+		rx-dma-channel = <&pdma1 4>; /* preliminary */
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	spi_2: spi at 12d40000 {
+		compatible = "samsung,exynos4210-spi";
+		reg = <0x12d40000 0x100>;
+		interrupts = <0 68 0>;
+		tx-dma-channel = <&pdma0 7>; /* preliminary */
+		rx-dma-channel = <&pdma0 6>; /* preliminary */
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	tmu at 10060000 {
+		compatible = "samsung,exynos5250-tmu";
+		reg = <0x10060000 0x100>;
+		interrupts = <0 65 0>;
+	};
+
+	watchdog {
+		compatible = "samsung,s3c2410-wdt";
+		reg = <0x101D0000 0x100>;
+		interrupts = <0 42 0>;
+	};
+
 };
diff --git a/arch/arm/boot/dts/exynos5440-ssdk5440.dts b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
index 81e2c96..61d24cc 100644
--- a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
+++ b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
@@ -24,23 +24,23 @@
 		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x81000000,8M console=ttySAC0,115200 init=/linuxrc";
 	};
 
-	spi {
+	i2c at F0000 {
 		status = "disabled";
 	};
 
-	i2c at F0000 {
+	i2c at 100000 {
 		status = "disabled";
 	};
 
-	i2c at 100000 {
+	rtc {
 		status = "disabled";
 	};
 
-	watchdog {
+	spi {
 		status = "disabled";
 	};
 
-	rtc {
+	watchdog {
 		status = "disabled";
 	};
 };
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 5406689..b928337 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -4,6 +4,10 @@
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
+ * Important Note: The device nodes under root node are sorted in alphabetical
+ * order. Please ensure that any new additions into this file maintain the
+ * device nodes in sorted manner.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -16,11 +20,24 @@
 
 	interrupt-parent = <&gic>;
 
-	gic:interrupt-controller at 2E0000 {
-		compatible = "arm,cortex-a15-gic";
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		reg = <0x2E1000 0x1000>, <0x2E2000 0x1000>;
+	amba {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "arm,amba-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		pdma0: pdma at 121A0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x120000 0x1000>;
+			interrupts = <0 34 0>;
+		};
+
+		pdma1: pdma at 121B0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121000 0x1000>;
+			interrupts = <0 35 0>;
+		};
 	};
 
 	cpus {
@@ -58,24 +75,25 @@
 		};
 	};
 
-	serial at B0000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0xB0000 0x1000>;
-		interrupts = <0 2 0>;
+	gic:interrupt-controller at 2E0000 {
+		compatible = "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x2E1000 0x1000>, <0x2E2000 0x1000>;
 	};
 
-	serial at C0000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0xC0000 0x1000>;
-		interrupts = <0 3 0>;
+	i2c at F0000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0xF0000 0x1000>;
+		interrupts = <0 5 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 
-	spi {
-		compatible = "samsung,exynos4210-spi";
-		reg = <0xD0000 0x1000>;
-		interrupts = <0 4 0>;
-		tx-dma-channel = <&pdma0 5>; /* preliminary */
-		rx-dma-channel = <&pdma0 4>; /* preliminary */
+	i2c at 100000 {
+		compatible = "samsung,s3c2440-i2c";
+		reg = <0x100000 0x1000>;
+		interrupts = <0 6 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
@@ -104,18 +122,30 @@
 		};
 	};
 
-	i2c at F0000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0xF0000 0x1000>;
-		interrupts = <0 5 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
+	rtc {
+		compatible = "samsung,s3c6410-rtc";
+		reg = <0x130000 0x1000>;
+		interrupts = <0 16 0>, <0 17 0>;
 	};
 
-	i2c at 100000 {
-		compatible = "samsung,s3c2440-i2c";
-		reg = <0x100000 0x1000>;
-		interrupts = <0 6 0>;
+	serial at B0000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0xB0000 0x1000>;
+		interrupts = <0 2 0>;
+	};
+
+	serial at C0000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0xC0000 0x1000>;
+		interrupts = <0 3 0>;
+	};
+
+	spi {
+		compatible = "samsung,exynos4210-spi";
+		reg = <0xD0000 0x1000>;
+		interrupts = <0 4 0>;
+		tx-dma-channel = <&pdma0 5>; /* preliminary */
+		rx-dma-channel = <&pdma0 4>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
@@ -125,30 +155,4 @@
 		reg = <0x110000 0x1000>;
 		interrupts = <0 1 0>;
 	};
-
-	amba {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "arm,amba-bus";
-		interrupt-parent = <&gic>;
-		ranges;
-
-		pdma0: pdma at 121A0000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x120000 0x1000>;
-			interrupts = <0 34 0>;
-		};
-
-		pdma1: pdma at 121B0000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x121000 0x1000>;
-			interrupts = <0 35 0>;
-		};
-	};
-
-	rtc {
-		compatible = "samsung,s3c6410-rtc";
-		reg = <0x130000 0x1000>;
-		interrupts = <0 16 0>, <0 17 0>;
-	};
 };
-- 
1.7.10.4
