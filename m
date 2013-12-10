From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Dec 2013 11:07:29 +0000
Subject: [PATCH 3/3] ARM: dts: Rename Exynos5250 ChromeOS common file to have
 exynos prefix
In-Reply-To: <1386673649-15181-1-git-send-email-broonie@kernel.org>
References: <1386673649-15181-1-git-send-email-broonie@kernel.org>
Message-ID: <1386673649-15181-4-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Make it easier to notice the common file for ChromeOS devices based on
the Exynos5250 by giving it the exynos5250 prefix that the boards have.

Signed-off-by: Mark Brown <broonie@linaro.org>
Acked-by: Tomasz Figa <t.figa@samsung.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/cros5250-common.dtsi        | 325 --------------------------
 arch/arm/boot/dts/exynos5250-cros-common.dtsi | 325 ++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5250-snow.dts         |   2 +-
 3 files changed, 326 insertions(+), 326 deletions(-)
 delete mode 100644 arch/arm/boot/dts/cros5250-common.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5250-cros-common.dtsi

diff --git a/arch/arm/boot/dts/cros5250-common.dtsi b/arch/arm/boot/dts/cros5250-common.dtsi
deleted file mode 100644
index 2fed9acd28da..000000000000
--- a/arch/arm/boot/dts/cros5250-common.dtsi
+++ /dev/null
@@ -1,325 +0,0 @@
-/*
- * Common device tree include for all Exynos 5250 boards based off of Daisy.
- *
- * Copyright (c) 2012 Google, Inc
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/ {
-	aliases {
-	};
-
-	memory {
-		reg = <0x40000000 0x80000000>;
-	};
-
-	chosen {
-	};
-
-	pinctrl at 11400000 {
-		/*
-		 * Disabled pullups since external part has its own pullups and
-		 * double-pulling gets us out of spec in some cases.
-		 */
-		i2c2_bus: i2c2-bus {
-			samsung,pin-pud = <0>;
-		};
-
-		max77686_irq: max77686-irq {
-			samsung,pins = "gpx3-2";
-			samsung,pin-function = <0>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
-		};
-	};
-
-	i2c at 12C60000 {
-		status = "okay";
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-max-bus-freq = <378000>;
-
-		max77686 at 09 {
-			compatible = "maxim,max77686";
-			interrupt-parent = <&gpx3>;
-			interrupts = <2 0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&max77686_irq>;
-			wakeup-source;
-			reg = <0x09>;
-
-			voltage-regulators {
-				ldo1_reg: LDO1 {
-					regulator-name = "P1.0V_LDO_OUT1";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-				};
-
-				ldo2_reg: LDO2 {
-					regulator-name = "P1.8V_LDO_OUT2";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				ldo3_reg: LDO3 {
-					regulator-name = "P1.8V_LDO_OUT3";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				ldo7_reg: LDO7 {
-					regulator-name = "P1.1V_LDO_OUT7";
-					regulator-min-microvolt = <1100000>;
-					regulator-max-microvolt = <1100000>;
-					regulator-always-on;
-				};
-
-				ldo8_reg: LDO8 {
-					regulator-name = "P1.0V_LDO_OUT8";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-				};
-
-				ldo10_reg: LDO10 {
-					regulator-name = "P1.8V_LDO_OUT10";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				ldo12_reg: LDO12 {
-					regulator-name = "P3.0V_LDO_OUT12";
-					regulator-min-microvolt = <3000000>;
-					regulator-max-microvolt = <3000000>;
-					regulator-always-on;
-				};
-
-				ldo14_reg: LDO14 {
-					regulator-name = "P1.8V_LDO_OUT14";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				ldo15_reg: LDO15 {
-					regulator-name = "P1.0V_LDO_OUT15";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-				};
-
-				ldo16_reg: LDO16 {
-					regulator-name = "P1.8V_LDO_OUT16";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				buck1_reg: BUCK1 {
-					regulator-name = "vdd_mif";
-					regulator-min-microvolt = <950000>;
-					regulator-max-microvolt = <1300000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck2_reg: BUCK2 {
-					regulator-name = "vdd_arm";
-					regulator-min-microvolt = <850000>;
-					regulator-max-microvolt = <1350000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck3_reg: BUCK3 {
-					regulator-name = "vdd_int";
-					regulator-min-microvolt = <900000>;
-					regulator-max-microvolt = <1200000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck4_reg: BUCK4 {
-					regulator-name = "vdd_g3d";
-					regulator-min-microvolt = <850000>;
-					regulator-max-microvolt = <1300000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck5_reg: BUCK5 {
-					regulator-name = "P1.8V_BUCK_OUT5";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck6_reg: BUCK6 {
-					regulator-name = "P1.35V_BUCK_OUT6";
-					regulator-min-microvolt = <1350000>;
-					regulator-max-microvolt = <1350000>;
-					regulator-always-on;
-				};
-
-				buck7_reg: BUCK7 {
-					regulator-name = "P2.0V_BUCK_OUT7";
-					regulator-min-microvolt = <2000000>;
-					regulator-max-microvolt = <2000000>;
-					regulator-always-on;
-				};
-
-				buck8_reg: BUCK8 {
-					regulator-name = "P2.85V_BUCK_OUT8";
-					regulator-min-microvolt = <2850000>;
-					regulator-max-microvolt = <2850000>;
-					regulator-always-on;
-				};
-			};
-		};
-	};
-
-	i2c at 12C70000 {
-		status = "okay";
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-max-bus-freq = <378000>;
-
-		trackpad {
-			reg = <0x67>;
-			compatible = "cypress,cyapa";
-			interrupts = <2 0>;
-			interrupt-parent = <&gpx1>;
-			wakeup-source;
-		};
-	};
-
-	i2c at 12C80000 {
-		status = "okay";
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-max-bus-freq = <66000>;
-
-		hdmiddc at 50 {
-			compatible = "samsung,exynos4210-hdmiddc";
-			reg = <0x50>;
-		};
-	};
-
-	i2c at 12C90000 {
-		status = "okay";
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-max-bus-freq = <66000>;
-	};
-
-	i2c at 12CA0000 {
-		status = "okay";
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-max-bus-freq = <66000>;
-	};
-
-	i2c at 12CB0000 {
-		status = "okay";
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-max-bus-freq = <66000>;
-	};
-
-	i2c at 12CD0000 {
-		status = "okay";
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-max-bus-freq = <66000>;
-	};
-
-	i2c at 12CE0000 {
-		status = "okay";
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-max-bus-freq = <378000>;
-
-		hdmiphy at 38 {
-			compatible = "samsung,exynos4212-hdmiphy";
-			reg = <0x38>;
-		};
-	};
-
-	mmc at 12200000 {
-		num-slots = <1>;
-		supports-highspeed;
-		broken-cd;
-		fifo-depth = <0x80>;
-		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
-
-		slot at 0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
-	};
-
-	mmc at 12210000 {
-		status = "disabled";
-	};
-
-	mmc at 12220000 {
-		num-slots = <1>;
-		supports-highspeed;
-		fifo-depth = <0x80>;
-		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-
-		slot at 0 {
-			reg = <0>;
-			bus-width = <4>;
-			wp-gpios = <&gpc2 1 0>;
-		};
-	};
-
-	mmc at 12230000 {
-		num-slots = <1>;
-		supports-highspeed;
-		broken-cd;
-		fifo-depth = <0x80>;
-		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
-		/* See board-specific dts files for pin setup */
-
-		slot at 0 {
-			reg = <0>;
-			bus-width = <4>;
-		};
-	};
-
-	spi_1: spi at 12d30000 {
-		status = "okay";
-		samsung,spi-src-clk = <0>;
-		num-cs = <1>;
-	};
-
-	hdmi {
-		hpd-gpio = <&gpx3 7 0>;
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		power {
-			label = "Power";
-			gpios = <&gpx1 3 1>;
-			linux,code = <116>; /* KEY_POWER */
-			gpio-key,wakeup;
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
new file mode 100644
index 000000000000..2fed9acd28da
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
@@ -0,0 +1,325 @@
+/*
+ * Common device tree include for all Exynos 5250 boards based off of Daisy.
+ *
+ * Copyright (c) 2012 Google, Inc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/ {
+	aliases {
+	};
+
+	memory {
+		reg = <0x40000000 0x80000000>;
+	};
+
+	chosen {
+	};
+
+	pinctrl at 11400000 {
+		/*
+		 * Disabled pullups since external part has its own pullups and
+		 * double-pulling gets us out of spec in some cases.
+		 */
+		i2c2_bus: i2c2-bus {
+			samsung,pin-pud = <0>;
+		};
+
+		max77686_irq: max77686-irq {
+			samsung,pins = "gpx3-2";
+			samsung,pin-function = <0>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+	};
+
+	i2c at 12C60000 {
+		status = "okay";
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <378000>;
+
+		max77686 at 09 {
+			compatible = "maxim,max77686";
+			interrupt-parent = <&gpx3>;
+			interrupts = <2 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&max77686_irq>;
+			wakeup-source;
+			reg = <0x09>;
+
+			voltage-regulators {
+				ldo1_reg: LDO1 {
+					regulator-name = "P1.0V_LDO_OUT1";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+				};
+
+				ldo2_reg: LDO2 {
+					regulator-name = "P1.8V_LDO_OUT2";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				ldo3_reg: LDO3 {
+					regulator-name = "P1.8V_LDO_OUT3";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				ldo7_reg: LDO7 {
+					regulator-name = "P1.1V_LDO_OUT7";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1100000>;
+					regulator-always-on;
+				};
+
+				ldo8_reg: LDO8 {
+					regulator-name = "P1.0V_LDO_OUT8";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+				};
+
+				ldo10_reg: LDO10 {
+					regulator-name = "P1.8V_LDO_OUT10";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				ldo12_reg: LDO12 {
+					regulator-name = "P3.0V_LDO_OUT12";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-always-on;
+				};
+
+				ldo14_reg: LDO14 {
+					regulator-name = "P1.8V_LDO_OUT14";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				ldo15_reg: LDO15 {
+					regulator-name = "P1.0V_LDO_OUT15";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+				};
+
+				ldo16_reg: LDO16 {
+					regulator-name = "P1.8V_LDO_OUT16";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				buck1_reg: BUCK1 {
+					regulator-name = "vdd_mif";
+					regulator-min-microvolt = <950000>;
+					regulator-max-microvolt = <1300000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				buck2_reg: BUCK2 {
+					regulator-name = "vdd_arm";
+					regulator-min-microvolt = <850000>;
+					regulator-max-microvolt = <1350000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				buck3_reg: BUCK3 {
+					regulator-name = "vdd_int";
+					regulator-min-microvolt = <900000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				buck4_reg: BUCK4 {
+					regulator-name = "vdd_g3d";
+					regulator-min-microvolt = <850000>;
+					regulator-max-microvolt = <1300000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				buck5_reg: BUCK5 {
+					regulator-name = "P1.8V_BUCK_OUT5";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				buck6_reg: BUCK6 {
+					regulator-name = "P1.35V_BUCK_OUT6";
+					regulator-min-microvolt = <1350000>;
+					regulator-max-microvolt = <1350000>;
+					regulator-always-on;
+				};
+
+				buck7_reg: BUCK7 {
+					regulator-name = "P2.0V_BUCK_OUT7";
+					regulator-min-microvolt = <2000000>;
+					regulator-max-microvolt = <2000000>;
+					regulator-always-on;
+				};
+
+				buck8_reg: BUCK8 {
+					regulator-name = "P2.85V_BUCK_OUT8";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+					regulator-always-on;
+				};
+			};
+		};
+	};
+
+	i2c at 12C70000 {
+		status = "okay";
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <378000>;
+
+		trackpad {
+			reg = <0x67>;
+			compatible = "cypress,cyapa";
+			interrupts = <2 0>;
+			interrupt-parent = <&gpx1>;
+			wakeup-source;
+		};
+	};
+
+	i2c at 12C80000 {
+		status = "okay";
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <66000>;
+
+		hdmiddc at 50 {
+			compatible = "samsung,exynos4210-hdmiddc";
+			reg = <0x50>;
+		};
+	};
+
+	i2c at 12C90000 {
+		status = "okay";
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <66000>;
+	};
+
+	i2c at 12CA0000 {
+		status = "okay";
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <66000>;
+	};
+
+	i2c at 12CB0000 {
+		status = "okay";
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <66000>;
+	};
+
+	i2c at 12CD0000 {
+		status = "okay";
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <66000>;
+	};
+
+	i2c at 12CE0000 {
+		status = "okay";
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <378000>;
+
+		hdmiphy at 38 {
+			compatible = "samsung,exynos4212-hdmiphy";
+			reg = <0x38>;
+		};
+	};
+
+	mmc at 12200000 {
+		num-slots = <1>;
+		supports-highspeed;
+		broken-cd;
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <2 3>;
+		samsung,dw-mshc-ddr-timing = <1 2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
+
+		slot at 0 {
+			reg = <0>;
+			bus-width = <8>;
+		};
+	};
+
+	mmc at 12210000 {
+		status = "disabled";
+	};
+
+	mmc at 12220000 {
+		num-slots = <1>;
+		supports-highspeed;
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <2 3>;
+		samsung,dw-mshc-ddr-timing = <1 2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
+
+		slot at 0 {
+			reg = <0>;
+			bus-width = <4>;
+			wp-gpios = <&gpc2 1 0>;
+		};
+	};
+
+	mmc at 12230000 {
+		num-slots = <1>;
+		supports-highspeed;
+		broken-cd;
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <2 3>;
+		samsung,dw-mshc-ddr-timing = <1 2>;
+		/* See board-specific dts files for pin setup */
+
+		slot at 0 {
+			reg = <0>;
+			bus-width = <4>;
+		};
+	};
+
+	spi_1: spi at 12d30000 {
+		status = "okay";
+		samsung,spi-src-clk = <0>;
+		num-cs = <1>;
+	};
+
+	hdmi {
+		hpd-gpio = <&gpx3 7 0>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "Power";
+			gpios = <&gpx1 3 1>;
+			linux,code = <116>; /* KEY_POWER */
+			gpio-key,wakeup;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index a9395c426db4..a290be8be2cb 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -10,7 +10,7 @@
 
 /dts-v1/;
 #include "exynos5250.dtsi"
-#include "cros5250-common.dtsi"
+#include "exynos5250-cros-common.dtsi"
 
 / {
 	model = "Google Snow";
-- 
1.8.5.1
