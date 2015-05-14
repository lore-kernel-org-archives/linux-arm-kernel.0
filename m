From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Thu, 14 May 2015 19:12:19 +0900
Subject: [PATCH v5 12/13] ARM: dts: Use labels for overriding nodes in
 exynos4412-origen
In-Reply-To: <1431598340-3319-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431598340-3319-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431598340-3319-13-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos4412-origen.dts | 892 ++++++++++++++++----------------
 1 file changed, 446 insertions(+), 446 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index bd8b73077d41..84c76310b312 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -50,485 +50,485 @@
 		};
 	};
 
-	watchdog at 10060000 {
-		status = "okay";
-	};
-
-	rtc at 10070000 {
-		status = "okay";
+	display-timings {
+		native-mode = <&timing0>;
+		timing0: timing {
+			clock-frequency = <47500000>;
+			hactive = <1024>;
+			vactive = <600>;
+			hfront-porch = <64>;
+			hback-porch = <16>;
+			hsync-len = <48>;
+			vback-porch = <64>;
+			vfront-porch = <16>;
+			vsync-len = <3>;
+		};
 	};
 
-	pinctrl at 11000000 {
-		keypad_rows: keypad-rows {
-			samsung,pins = "gpx2-0", "gpx2-1", "gpx2-2";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <0>;
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti";
+			clock-frequency = <0>;
 		};
 
-		keypad_cols: keypad-cols {
-			samsung,pins = "gpx1-0", "gpx1-1";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+		xusbxti {
+			compatible = "samsung,clock-xusbxti";
+			clock-frequency = <24000000>;
 		};
 	};
+};
 
-	keypad at 100A0000 {
-		samsung,keypad-num-rows = <3>;
-		samsung,keypad-num-columns = <2>;
-		linux,keypad-no-autorepeat;
-		linux,keypad-wakeup;
-		pinctrl-0 = <&keypad_rows &keypad_cols>;
-		pinctrl-names = "default";
-		status = "okay";
-
-		key_home {
-			keypad,row = <0>;
-			keypad,column = <0>;
-			linux,code = <KEY_HOME>;
-		};
+&fimd {
+	pinctrl-0 = <&lcd_clk &lcd_data24 &pwm1_out>;
+	pinctrl-names = "default";
+	status = "okay";
+};
 
-		key_down {
-			keypad,row = <0>;
-			keypad,column = <1>;
-			linux,code = <KEY_DOWN>;
-		};
+&g2d {
+	status = "okay";
+};
 
-		key_up {
-			keypad,row = <1>;
-			keypad,column = <0>;
-			linux,code = <KEY_UP>;
-		};
+&i2c_0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-max-bus-freq = <20000>;
+	pinctrl-0 = <&i2c0_bus>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	s5m8767_pmic at 66 {
+		compatible = "samsung,s5m8767-pmic";
+		reg = <0x66>;
+
+		s5m8767,pmic-buck-default-dvs-idx = <3>;
+
+		s5m8767,pmic-buck-dvs-gpios = <&gpx2 3 0>,
+						 <&gpx2 4 0>,
+						 <&gpx2 5 0>;
+
+		s5m8767,pmic-buck-ds-gpios = <&gpm3 5 0>,
+						<&gpm3 6 0>,
+						<&gpm3 7 0>;
+
+		s5m8767,pmic-buck2-dvs-voltage = <1250000>, <1200000>,
+						 <1200000>, <1200000>,
+						 <1200000>, <1200000>,
+						 <1200000>, <1200000>;
+
+		s5m8767,pmic-buck3-dvs-voltage = <1100000>, <1100000>,
+						 <1100000>, <1100000>,
+						 <1100000>, <1100000>,
+						 <1100000>, <1100000>;
+
+		s5m8767,pmic-buck4-dvs-voltage = <1200000>, <1200000>,
+						 <1200000>, <1200000>,
+						 <1200000>, <1200000>,
+						 <1200000>, <1200000>;
+
+		regulators {
+			ldo1_reg: LDO1 {
+				regulator-name = "VDD_ALIVE";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+				regulator-boot-on;
+				op_mode = <1>; /* Normal Mode */
+			};
 
-		key_menu {
-			keypad,row = <1>;
-			keypad,column = <1>;
-			linux,code = <KEY_MENU>;
-		};
+			ldo2_reg: LDO2 {
+				regulator-name = "VDDQ_M12";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
 
-		key_back {
-			keypad,row = <2>;
-			keypad,column = <0>;
-			linux,code = <KEY_BACK>;
-		};
+			ldo3_reg: LDO3 {
+				regulator-name = "VDDIOAP_18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo4_reg: LDO4 {
+				regulator-name = "VDDQ_PRE";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo5_reg: LDO5 {
+				regulator-name = "VDD18_2M";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo6_reg: LDO6 {
+				regulator-name = "VDD10_MPLL";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo7_reg: LDO7 {
+				regulator-name = "VDD10_XPLL";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo8_reg: LDO8 {
+				regulator-name = "VDD10_MIPI";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo9_reg: LDO9 {
+				regulator-name = "VDD33_LCD";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo10_reg: LDO10 {
+				regulator-name = "VDD18_MIPI";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo11_reg: LDO11 {
+				regulator-name = "VDD18_ABB1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo12_reg: LDO12 {
+				regulator-name = "VDD33_UOTG";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo13_reg: LDO13 {
+				regulator-name = "VDDIOPERI_18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo14_reg: LDO14 {
+				regulator-name = "VDD18_ABB02";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo15_reg: LDO15 {
+				regulator-name = "VDD10_USH";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo16_reg: LDO16 {
+				regulator-name = "VDD18_HSIC";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo17_reg: LDO17 {
+				regulator-name = "VDDIOAP_MMC012_28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo18_reg: LDO18 {
+				regulator-name = "VDDIOPERI_28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo19_reg: LDO19 {
+				regulator-name = "DVDD25";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo20_reg: LDO20 {
+				regulator-name = "VDD28_CAM";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo21_reg: LDO21 {
+				regulator-name = "VDD28_AF";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo22_reg: LDO22 {
+				regulator-name = "VDDA28_2M";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
 
-		key_enter {
-			keypad,row = <2>;
-			keypad,column = <1>;
-			linux,code = <KEY_ENTER>;
+			ldo23_reg: LDO23 {
+				regulator-name = "VDD28_TF";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo24_reg: LDO24 {
+				regulator-name = "VDD33_A31";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo25_reg: LDO25 {
+				regulator-name = "VDD18_CAM";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo26_reg: LDO26 {
+				regulator-name = "VDD18_A31";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo27_reg: LDO27 {
+				regulator-name = "GPS_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			ldo28_reg: LDO28 {
+				regulator-name = "DVDD12";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			buck1_reg: BUCK1 {
+				regulator-name = "vdd_mif";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt	= <1100000>;
+				regulator-always-on;
+				regulator-boot-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			buck2_reg: BUCK2 {
+				regulator-name = "vdd_arm";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt	= <1350000>;
+				regulator-always-on;
+				regulator-boot-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			buck3_reg: BUCK3 {
+				regulator-name = "vdd_int";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt	= <1200000>;
+				regulator-always-on;
+				regulator-boot-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			buck4_reg: BUCK4 {
+				regulator-name = "vdd_g3d";
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt	= <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			buck5_reg: BUCK5 {
+				regulator-name = "vdd_m12";
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt	= <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			buck6_reg: BUCK6 {
+				regulator-name = "vdd12_5m";
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt	= <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+				op_mode = <1>; /* Normal Mode */
+			};
+
+			buck9_reg: BUCK9 {
+				regulator-name = "vddf28_emmc";
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt	= <3000000>;
+				regulator-always-on;
+				regulator-boot-on;
+				op_mode = <1>; /* Normal Mode */
+			};
 		};
 	};
+};
 
-	g2d at 10800000 {
-		status = "okay";
+&keypad {
+	samsung,keypad-num-rows = <3>;
+	samsung,keypad-num-columns = <2>;
+	linux,keypad-no-autorepeat;
+	linux,keypad-wakeup;
+	pinctrl-0 = <&keypad_rows &keypad_cols>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	key_home {
+		keypad,row = <0>;
+		keypad,column = <0>;
+		linux,code = <KEY_HOME>;
 	};
 
-	sdhci at 12530000 {
-		bus-width = <4>;
-		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sd2_cd>;
-		pinctrl-names = "default";
-		vmmc-supply = <&mmc_reg>;
-		status = "okay";
+	key_down {
+		keypad,row = <0>;
+		keypad,column = <1>;
+		linux,code = <KEY_DOWN>;
 	};
 
-	mmc at 12550000 {
-		pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
-		pinctrl-names = "default";
-		status = "okay";
-
-		num-slots = <1>;
-		broken-cd;
-		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
-		bus-width = <8>;
-		cap-mmc-highspeed;
+	key_up {
+		keypad,row = <1>;
+		keypad,column = <0>;
+		linux,code = <KEY_UP>;
 	};
 
-	codec at 13400000 {
-		samsung,mfc-r = <0x43000000 0x800000>;
-		samsung,mfc-l = <0x51000000 0x800000>;
-		status = "okay";
+	key_menu {
+		keypad,row = <1>;
+		keypad,column = <1>;
+		linux,code = <KEY_MENU>;
 	};
 
-	fimd at 11c00000 {
-		pinctrl-0 = <&lcd_clk &lcd_data24 &pwm1_out>;
-		pinctrl-names = "default";
-		status = "okay";
+	key_back {
+		keypad,row = <2>;
+		keypad,column = <0>;
+		linux,code = <KEY_BACK>;
 	};
 
-	display-timings {
-		native-mode = <&timing0>;
-		timing0: timing {
-			clock-frequency = <47500000>;
-			hactive = <1024>;
-			vactive = <600>;
-			hfront-porch = <64>;
-			hback-porch = <16>;
-			hsync-len = <48>;
-			vback-porch = <64>;
-			vfront-porch = <16>;
-			vsync-len = <3>;
-		};
+	key_enter {
+		keypad,row = <2>;
+		keypad,column = <1>;
+		linux,code = <KEY_ENTER>;
 	};
+};
 
-	serial at 13800000 {
-		status = "okay";
-	};
+&mfc {
+	samsung,mfc-r = <0x43000000 0x800000>;
+	samsung,mfc-l = <0x51000000 0x800000>;
+	status = "okay";
+};
 
-	serial at 13810000 {
-		status = "okay";
-	};
+&mshc_0 {
+	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	num-slots = <1>;
+	broken-cd;
+	card-detect-delay = <200>;
+	samsung,dw-mshc-ciu-div = <3>;
+	samsung,dw-mshc-sdr-timing = <2 3>;
+	samsung,dw-mshc-ddr-timing = <1 2>;
+	bus-width = <8>;
+	cap-mmc-highspeed;
+};
 
-	serial at 13820000 {
-		status = "okay";
+&pinctrl_1 {
+	keypad_rows: keypad-rows {
+		samsung,pins = "gpx2-0", "gpx2-1", "gpx2-2";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
 	};
 
-	serial at 13830000 {
-		status = "okay";
+	keypad_cols: keypad-cols {
+		samsung,pins = "gpx1-0", "gpx1-1";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
 	};
+};
 
-	i2c at 13860000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-max-bus-freq = <20000>;
-		pinctrl-0 = <&i2c0_bus>;
-		pinctrl-names = "default";
-		status = "okay";
-
-		s5m8767_pmic at 66 {
-			compatible = "samsung,s5m8767-pmic";
-			reg = <0x66>;
-
-			s5m8767,pmic-buck-default-dvs-idx = <3>;
-
-			s5m8767,pmic-buck-dvs-gpios = <&gpx2 3 0>,
-							 <&gpx2 4 0>,
-							 <&gpx2 5 0>;
-
-			s5m8767,pmic-buck-ds-gpios = <&gpm3 5 0>,
-							<&gpm3 6 0>,
-							<&gpm3 7 0>;
-
-			s5m8767,pmic-buck2-dvs-voltage = <1250000>, <1200000>,
-							 <1200000>, <1200000>,
-							 <1200000>, <1200000>,
-							 <1200000>, <1200000>;
-
-			s5m8767,pmic-buck3-dvs-voltage = <1100000>, <1100000>,
-							 <1100000>, <1100000>,
-							 <1100000>, <1100000>,
-							 <1100000>, <1100000>;
-
-			s5m8767,pmic-buck4-dvs-voltage = <1200000>, <1200000>,
-							 <1200000>, <1200000>,
-							 <1200000>, <1200000>,
-							 <1200000>, <1200000>;
-
-			regulators {
-				ldo1_reg: LDO1 {
-					regulator-name = "VDD_ALIVE";
-					regulator-min-microvolt = <1100000>;
-					regulator-max-microvolt = <1100000>;
-					regulator-always-on;
-					regulator-boot-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo2_reg: LDO2 {
-					regulator-name = "VDDQ_M12";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo3_reg: LDO3 {
-					regulator-name = "VDDIOAP_18";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo4_reg: LDO4 {
-					regulator-name = "VDDQ_PRE";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo5_reg: LDO5 {
-					regulator-name = "VDD18_2M";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo6_reg: LDO6 {
-					regulator-name = "VDD10_MPLL";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo7_reg: LDO7 {
-					regulator-name = "VDD10_XPLL";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo8_reg: LDO8 {
-					regulator-name = "VDD10_MIPI";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo9_reg: LDO9 {
-					regulator-name = "VDD33_LCD";
-					regulator-min-microvolt = <3300000>;
-					regulator-max-microvolt = <3300000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo10_reg: LDO10 {
-					regulator-name = "VDD18_MIPI";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo11_reg: LDO11 {
-					regulator-name = "VDD18_ABB1";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo12_reg: LDO12 {
-					regulator-name = "VDD33_UOTG";
-					regulator-min-microvolt = <3300000>;
-					regulator-max-microvolt = <3300000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo13_reg: LDO13 {
-					regulator-name = "VDDIOPERI_18";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo14_reg: LDO14 {
-					regulator-name = "VDD18_ABB02";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo15_reg: LDO15 {
-					regulator-name = "VDD10_USH";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo16_reg: LDO16 {
-					regulator-name = "VDD18_HSIC";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo17_reg: LDO17 {
-					regulator-name = "VDDIOAP_MMC012_28";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <2800000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo18_reg: LDO18 {
-					regulator-name = "VDDIOPERI_28";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <2800000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo19_reg: LDO19 {
-					regulator-name = "DVDD25";
-					regulator-min-microvolt = <2500000>;
-					regulator-max-microvolt = <2500000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo20_reg: LDO20 {
-					regulator-name = "VDD28_CAM";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <2800000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo21_reg: LDO21 {
-					regulator-name = "VDD28_AF";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <2800000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo22_reg: LDO22 {
-					regulator-name = "VDDA28_2M";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <2800000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo23_reg: LDO23 {
-					regulator-name = "VDD28_TF";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <2800000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo24_reg: LDO24 {
-					regulator-name = "VDD33_A31";
-					regulator-min-microvolt = <3300000>;
-					regulator-max-microvolt = <3300000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo25_reg: LDO25 {
-					regulator-name = "VDD18_CAM";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo26_reg: LDO26 {
-					regulator-name = "VDD18_A31";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo27_reg: LDO27 {
-					regulator-name = "GPS_1V8";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				ldo28_reg: LDO28 {
-					regulator-name = "DVDD12";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
-					regulator-always-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				buck1_reg: BUCK1 {
-					regulator-name = "vdd_mif";
-					regulator-min-microvolt = <950000>;
-					regulator-max-microvolt	= <1100000>;
-					regulator-always-on;
-					regulator-boot-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				buck2_reg: BUCK2 {
-					regulator-name = "vdd_arm";
-					regulator-min-microvolt = <900000>;
-					regulator-max-microvolt	= <1350000>;
-					regulator-always-on;
-					regulator-boot-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				buck3_reg: BUCK3 {
-					regulator-name = "vdd_int";
-					regulator-min-microvolt = <900000>;
-					regulator-max-microvolt	= <1200000>;
-					regulator-always-on;
-					regulator-boot-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				buck4_reg: BUCK4 {
-					regulator-name = "vdd_g3d";
-					regulator-min-microvolt = <750000>;
-					regulator-max-microvolt	= <1500000>;
-					regulator-always-on;
-					regulator-boot-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				buck5_reg: BUCK5 {
-					regulator-name = "vdd_m12";
-					regulator-min-microvolt = <750000>;
-					regulator-max-microvolt	= <1500000>;
-					regulator-always-on;
-					regulator-boot-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				buck6_reg: BUCK6 {
-					regulator-name = "vdd12_5m";
-					regulator-min-microvolt = <750000>;
-					regulator-max-microvolt	= <1500000>;
-					regulator-always-on;
-					regulator-boot-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-
-				buck9_reg: BUCK9 {
-					regulator-name = "vddf28_emmc";
-					regulator-min-microvolt = <750000>;
-					regulator-max-microvolt	= <3000000>;
-					regulator-always-on;
-					regulator-boot-on;
-					op_mode = <1>; /* Normal Mode */
-				};
-			};
-		};
-	};
+&rtc {
+	status = "okay";
+};
 
-	fixed-rate-clocks {
-		xxti {
-			compatible = "samsung,clock-xxti";
-			clock-frequency = <0>;
-		};
+&sdhci_2 {
+	bus-width = <4>;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sd2_cd>;
+	pinctrl-names = "default";
+	vmmc-supply = <&mmc_reg>;
+	status = "okay";
+};
 
-		xusbxti {
-			compatible = "samsung,clock-xusbxti";
-			clock-frequency = <24000000>;
-		};
-	};
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
+&watchdog {
+	status = "okay";
 };
-- 
2.1.4
