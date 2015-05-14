From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Thu, 14 May 2015 19:12:10 +0900
Subject: [PATCH v5 03/13] ARM: dts: Use labels for overriding nodes in
 exynos4210-origen
In-Reply-To: <1431598340-3319-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431598340-3319-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431598340-3319-4-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos4210-origen.dts | 418 ++++++++++++++++----------------
 1 file changed, 209 insertions(+), 209 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index b81146141402..e0abfc3324d1 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -50,209 +50,6 @@
 		};
 	};
 
-	watchdog at 10060000 {
-		status = "okay";
-	};
-
-	rtc at 10070000 {
-		status = "okay";
-	};
-
-	tmu at 100C0000 {
-		status = "okay";
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
-	g2d at 12800000 {
-		status = "okay";
-	};
-
-	codec at 13400000 {
-		samsung,mfc-r = <0x43000000 0x800000>;
-		samsung,mfc-l = <0x51000000 0x800000>;
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
-	i2c at 13860000 {
-		status = "okay";
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-max-bus-freq = <20000>;
-		pinctrl-0 = <&i2c0_bus>;
-		pinctrl-names = "default";
-
-		max8997_pmic at 66 {
-			compatible = "maxim,max8997-pmic";
-			reg = <0x66>;
-			interrupt-parent = <&gpx0>;
-			interrupts = <4 0>, <3 0>;
-
-			max8997,pmic-buck1-dvs-voltage = <1350000>;
-			max8997,pmic-buck2-dvs-voltage = <1100000>;
-			max8997,pmic-buck5-dvs-voltage = <1200000>;
-
-			regulators {
-				ldo1_reg: LDO1 {
-					regulator-name = "VDD_ABB_3.3V";
-					regulator-min-microvolt = <3300000>;
-					regulator-max-microvolt = <3300000>;
-				};
-
-				ldo2_reg: LDO2 {
-					regulator-name = "VDD_ALIVE_1.1V";
-					regulator-min-microvolt = <1100000>;
-					regulator-max-microvolt = <1100000>;
-					regulator-always-on;
-				};
-
-				ldo3_reg: LDO3 {
-					regulator-name = "VMIPI_1.1V";
-					regulator-min-microvolt = <1100000>;
-					regulator-max-microvolt = <1100000>;
-				};
-
-				ldo4_reg: LDO4 {
-					regulator-name = "VDD_RTC_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt	= <1800000>;
-					regulator-always-on;
-				};
-
-				ldo6_reg: LDO6 {
-					regulator-name = "VMIPI_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt	= <1800000>;
-					regulator-always-on;
-				};
-
-				ldo7_reg: LDO7 {
-					regulator-name = "VDD_AUD_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt	= <1800000>;
-				};
-
-				ldo8_reg: LDO8 {
-					regulator-name = "VADC_3.3V";
-					regulator-min-microvolt = <3300000>;
-					regulator-max-microvolt	= <3300000>;
-				};
-
-				ldo9_reg: LDO9 {
-					regulator-name = "DVDD_SWB_2.8V";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt	= <2800000>;
-					regulator-always-on;
-				};
-
-				ldo10_reg: LDO10 {
-					regulator-name = "VDD_PLL_1.1V";
-					regulator-min-microvolt = <1100000>;
-					regulator-max-microvolt	= <1100000>;
-					regulator-always-on;
-				};
-
-				ldo11_reg: LDO11 {
-					regulator-name = "VDD_AUD_3V";
-					regulator-min-microvolt = <3000000>;
-					regulator-max-microvolt	= <3000000>;
-				};
-
-				ldo14_reg: LDO14 {
-					regulator-name = "AVDD18_SWB_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt	= <1800000>;
-					regulator-always-on;
-				};
-
-				ldo17_reg: LDO17 {
-					regulator-name = "VDD_SWB_3.3V";
-					regulator-min-microvolt = <3300000>;
-					regulator-max-microvolt	= <3300000>;
-					regulator-always-on;
-				};
-
-				ldo21_reg: LDO21 {
-					regulator-name = "VDD_MIF_1.2V";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt	= <1200000>;
-					regulator-always-on;
-				};
-
-				buck1_reg: BUCK1 {
-					/*
-					* HACK: The real name is VDD_ARM_1.2V,
-					* but exynos-cpufreq does not support
-					* DT-based regulator lookup yet.
-					*/
-					regulator-name = "vdd_arm";
-					regulator-min-microvolt = <950000>;
-					regulator-max-microvolt	= <1350000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck2_reg: BUCK2 {
-					regulator-name = "VDD_INT_1.1V";
-					regulator-min-microvolt = <900000>;
-					regulator-max-microvolt	= <1100000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck3_reg: BUCK3 {
-					regulator-name = "VDD_G3D_1.1V";
-					regulator-min-microvolt = <900000>;
-					regulator-max-microvolt = <1100000>;
-				};
-
-				buck5_reg: BUCK5 {
-					regulator-name = "VDDQ_M1M2_1.2V";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
-					regulator-always-on;
-				};
-
-				buck7_reg: BUCK7 {
-					regulator-name = "VDD_LCD_3.3V";
-					regulator-min-microvolt = <3300000>;
-					regulator-max-microvolt = <3300000>;
-					regulator-boot-on;
-					regulator-always-on;
-				};
-			};
-		};
-	};
-
 	gpio_keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
@@ -314,12 +111,6 @@
 		};
 	};
 
-	fimd at 11c00000 {
-		pinctrl-0 = <&lcd_en &lcd_clk &lcd_data24 &pwm0_out>;
-		pinctrl-names = "default";
-		status = "okay";
-	};
-
 	display-timings {
 		native-mode = <&timing0>;
 		timing0: timing {
@@ -335,3 +126,212 @@
 		};
 	};
 };
+
+&fimd {
+	pinctrl-0 = <&lcd_en &lcd_clk &lcd_data24 &pwm0_out>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&g2d {
+	status = "okay";
+};
+
+&i2c_0 {
+	status = "okay";
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-max-bus-freq = <20000>;
+	pinctrl-0 = <&i2c0_bus>;
+	pinctrl-names = "default";
+
+	max8997_pmic at 66 {
+		compatible = "maxim,max8997-pmic";
+		reg = <0x66>;
+		interrupt-parent = <&gpx0>;
+		interrupts = <4 0>, <3 0>;
+
+		max8997,pmic-buck1-dvs-voltage = <1350000>;
+		max8997,pmic-buck2-dvs-voltage = <1100000>;
+		max8997,pmic-buck5-dvs-voltage = <1200000>;
+
+		regulators {
+			ldo1_reg: LDO1 {
+				regulator-name = "VDD_ABB_3.3V";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo2_reg: LDO2 {
+				regulator-name = "VDD_ALIVE_1.1V";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+			};
+
+			ldo3_reg: LDO3 {
+				regulator-name = "VMIPI_1.1V";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+			};
+
+			ldo4_reg: LDO4 {
+				regulator-name = "VDD_RTC_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt	= <1800000>;
+				regulator-always-on;
+			};
+
+			ldo6_reg: LDO6 {
+				regulator-name = "VMIPI_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt	= <1800000>;
+				regulator-always-on;
+			};
+
+			ldo7_reg: LDO7 {
+				regulator-name = "VDD_AUD_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt	= <1800000>;
+			};
+
+			ldo8_reg: LDO8 {
+				regulator-name = "VADC_3.3V";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt	= <3300000>;
+			};
+
+			ldo9_reg: LDO9 {
+				regulator-name = "DVDD_SWB_2.8V";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt	= <2800000>;
+				regulator-always-on;
+			};
+
+			ldo10_reg: LDO10 {
+				regulator-name = "VDD_PLL_1.1V";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt	= <1100000>;
+				regulator-always-on;
+			};
+
+			ldo11_reg: LDO11 {
+				regulator-name = "VDD_AUD_3V";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt	= <3000000>;
+			};
+
+			ldo14_reg: LDO14 {
+				regulator-name = "AVDD18_SWB_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt	= <1800000>;
+				regulator-always-on;
+			};
+
+			ldo17_reg: LDO17 {
+				regulator-name = "VDD_SWB_3.3V";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt	= <3300000>;
+				regulator-always-on;
+			};
+
+			ldo21_reg: LDO21 {
+				regulator-name = "VDD_MIF_1.2V";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt	= <1200000>;
+				regulator-always-on;
+			};
+
+			buck1_reg: BUCK1 {
+				/*
+				* HACK: The real name is VDD_ARM_1.2V,
+				* but exynos-cpufreq does not support
+				* DT-based regulator lookup yet.
+				*/
+				regulator-name = "vdd_arm";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt	= <1350000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck2_reg: BUCK2 {
+				regulator-name = "VDD_INT_1.1V";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt	= <1100000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck3_reg: BUCK3 {
+				regulator-name = "VDD_G3D_1.1V";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1100000>;
+			};
+
+			buck5_reg: BUCK5 {
+				regulator-name = "VDDQ_M1M2_1.2V";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+			};
+
+			buck7_reg: BUCK7 {
+				regulator-name = "VDD_LCD_3.3V";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&mfc {
+	samsung,mfc-r = <0x43000000 0x800000>;
+	samsung,mfc-l = <0x51000000 0x800000>;
+	status = "okay";
+};
+
+&sdhci_0 {
+	bus-width = <4>;
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_cd>;
+	pinctrl-names = "default";
+	vmmc-supply = <&mmc_reg>;
+	status = "okay";
+};
+
+&sdhci_2 {
+	bus-width = <4>;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sd2_cd>;
+	pinctrl-names = "default";
+	vmmc-supply = <&mmc_reg>;
+	status = "okay";
+};
+
+&serial_0 {
+	status = "okay";
+};
+
+&serial_1 {
+	status = "okay";
+};
+
+&serial_2 {
+	status = "okay";
+};
+
+&serial_3 {
+	status = "okay";
+};
+
+&rtc {
+	status = "okay";
+};
+
+&tmu {
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
-- 
2.1.4
