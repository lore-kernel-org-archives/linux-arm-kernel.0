From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sun, 17 May 2015 17:26:15 +0900
Subject: [PATCH v4 8/8] ARM: dts: Use labels for overriding nodes in
 exynos5422-odroidxu3
In-Reply-To: <1431851175-32624-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431851175-32624-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431851175-32624-9-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 568 ++++++++++++++---------------
 1 file changed, 284 insertions(+), 284 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index 6403757011ba..f3f753183f48 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -28,10 +28,6 @@
 		linux,stdout-path = &serial_2;
 	};
 
-	fimd at 14400000 {
-		status = "okay";
-	};
-
 	firmware at 02073000 {
 		compatible = "samsung,secure-firmware";
 		reg = <0x02073000 0x1000>;
@@ -44,229 +40,6 @@
 		};
 	};
 
-	hsi2c_4: i2c at 12CA0000 {
-		status = "okay";
-
-		s2mps11_pmic at 66 {
-			compatible = "samsung,s2mps11-pmic";
-			reg = <0x66>;
-			s2mps11,buck2-ramp-delay = <12>;
-			s2mps11,buck34-ramp-delay = <12>;
-			s2mps11,buck16-ramp-delay = <12>;
-			s2mps11,buck6-ramp-enable = <1>;
-			s2mps11,buck2-ramp-enable = <1>;
-			s2mps11,buck3-ramp-enable = <1>;
-			s2mps11,buck4-ramp-enable = <1>;
-
-			s2mps11_osc: clocks {
-				#clock-cells = <1>;
-				clock-output-names = "s2mps11_ap",
-						"s2mps11_cp", "s2mps11_bt";
-			};
-
-			regulators {
-				ldo1_reg: LDO1 {
-					regulator-name = "vdd_ldo1";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-				};
-
-				ldo3_reg: LDO3 {
-					regulator-name = "vdd_ldo3";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				ldo5_reg: LDO5 {
-					regulator-name = "vdd_ldo5";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				ldo6_reg: LDO6 {
-					regulator-name = "vdd_ldo6";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-				};
-
-				ldo7_reg: LDO7 {
-					regulator-name = "vdd_ldo7";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				ldo8_reg: LDO8 {
-					regulator-name = "vdd_ldo8";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				ldo9_reg: LDO9 {
-					regulator-name = "vdd_ldo9";
-					regulator-min-microvolt = <3000000>;
-					regulator-max-microvolt = <3000000>;
-					regulator-always-on;
-				};
-
-				ldo10_reg: LDO10 {
-					regulator-name = "vdd_ldo10";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				ldo11_reg: LDO11 {
-					regulator-name = "vdd_ldo11";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-				};
-
-				ldo12_reg: LDO12 {
-					regulator-name = "vdd_ldo12";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				ldo13_reg: LDO13 {
-					regulator-name = "vdd_ldo13";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <2800000>;
-					regulator-always-on;
-				};
-
-				ldo15_reg: LDO15 {
-					regulator-name = "vdd_ldo15";
-					regulator-min-microvolt = <3100000>;
-					regulator-max-microvolt = <3100000>;
-					regulator-always-on;
-				};
-
-				ldo16_reg: LDO16 {
-					regulator-name = "vdd_ldo16";
-					regulator-min-microvolt = <2200000>;
-					regulator-max-microvolt = <2200000>;
-					regulator-always-on;
-				};
-
-				ldo17_reg: LDO17 {
-					regulator-name = "tsp_avdd";
-					regulator-min-microvolt = <3300000>;
-					regulator-max-microvolt = <3300000>;
-					regulator-always-on;
-				};
-
-				ldo19_reg: LDO19 {
-					regulator-name = "vdd_sd";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <2800000>;
-					regulator-always-on;
-				};
-
-				ldo24_reg: LDO24 {
-					regulator-name = "tsp_io";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <2800000>;
-					regulator-always-on;
-				};
-
-				ldo26_reg: LDO26 {
-					regulator-name = "vdd_ldo26";
-					regulator-min-microvolt = <3000000>;
-					regulator-max-microvolt = <3000000>;
-					regulator-always-on;
-				};
-
-				buck1_reg: BUCK1 {
-					regulator-name = "vdd_mif";
-					regulator-min-microvolt = <800000>;
-					regulator-max-microvolt = <1300000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck2_reg: BUCK2 {
-					regulator-name = "vdd_arm";
-					regulator-min-microvolt = <800000>;
-					regulator-max-microvolt = <1500000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck3_reg: BUCK3 {
-					regulator-name = "vdd_int";
-					regulator-min-microvolt = <800000>;
-					regulator-max-microvolt = <1400000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck4_reg: BUCK4 {
-					regulator-name = "vdd_g3d";
-					regulator-min-microvolt = <800000>;
-					regulator-max-microvolt = <1400000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck5_reg: BUCK5 {
-					regulator-name = "vdd_mem";
-					regulator-min-microvolt = <800000>;
-					regulator-max-microvolt = <1400000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck6_reg: BUCK6 {
-					regulator-name = "vdd_kfc";
-					regulator-min-microvolt = <800000>;
-					regulator-max-microvolt = <1500000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck7_reg: BUCK7 {
-					regulator-name = "vdd_1.0v_ldo";
-					regulator-min-microvolt = <800000>;
-					regulator-max-microvolt = <1500000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck8_reg: BUCK8 {
-					regulator-name = "vdd_1.8v_ldo";
-					regulator-min-microvolt = <800000>;
-					regulator-max-microvolt = <1500000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck9_reg: BUCK9 {
-					regulator-name = "vdd_2.8v_ldo";
-					regulator-min-microvolt = <3000000>;
-					regulator-max-microvolt = <3750000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-
-				buck10_reg: BUCK10 {
-					regulator-name = "vdd_vmem";
-					regulator-min-microvolt = <2850000>;
-					regulator-max-microvolt = <2850000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
-			};
-		};
-	};
-
 	emmc_pwrseq: pwrseq {
 		pinctrl-0 = <&emmc_nrst_pin>;
 		pinctrl-names = "default";
@@ -274,17 +47,6 @@
 		reset-gpios = <&gpd1 0 1>;
 	};
 
-	i2c_2: i2c at 12C80000 {
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-max-bus-freq = <66000>;
-		status = "okay";
-
-		hdmiddc at 50 {
-			compatible = "samsung,exynos4210-hdmiddc";
-			reg = <0x50>;
-		};
-	};
-
 	leds {
 		compatible = "gpio-leds";
 		heartbeat {
@@ -351,6 +113,245 @@
 			<19200000>;
 };
 
+&fimd {
+	status = "okay";
+};
+
+
+&hdmi {
+	status = "okay";
+	hpd-gpio = <&gpx3 7 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_hpd_irq>;
+
+	vdd_osc-supply = <&ldo7_reg>;
+	vdd_pll-supply = <&ldo6_reg>;
+	vdd-supply = <&ldo6_reg>;
+};
+
+&hsi2c_4 {
+	status = "okay";
+
+	s2mps11_pmic at 66 {
+		compatible = "samsung,s2mps11-pmic";
+		reg = <0x66>;
+		s2mps11,buck2-ramp-delay = <12>;
+		s2mps11,buck34-ramp-delay = <12>;
+		s2mps11,buck16-ramp-delay = <12>;
+		s2mps11,buck6-ramp-enable = <1>;
+		s2mps11,buck2-ramp-enable = <1>;
+		s2mps11,buck3-ramp-enable = <1>;
+		s2mps11,buck4-ramp-enable = <1>;
+
+		s2mps11_osc: clocks {
+			#clock-cells = <1>;
+			clock-output-names = "s2mps11_ap",
+					"s2mps11_cp", "s2mps11_bt";
+		};
+
+		regulators {
+			ldo1_reg: LDO1 {
+				regulator-name = "vdd_ldo1";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
+
+			ldo3_reg: LDO3 {
+				regulator-name = "vdd_ldo3";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo5_reg: LDO5 {
+				regulator-name = "vdd_ldo5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo6_reg: LDO6 {
+				regulator-name = "vdd_ldo6";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
+
+			ldo7_reg: LDO7 {
+				regulator-name = "vdd_ldo7";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo8_reg: LDO8 {
+				regulator-name = "vdd_ldo8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo9_reg: LDO9 {
+				regulator-name = "vdd_ldo9";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+			};
+
+			ldo10_reg: LDO10 {
+				regulator-name = "vdd_ldo10";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo11_reg: LDO11 {
+				regulator-name = "vdd_ldo11";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
+
+			ldo12_reg: LDO12 {
+				regulator-name = "vdd_ldo12";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo13_reg: LDO13 {
+				regulator-name = "vdd_ldo13";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+			};
+
+			ldo15_reg: LDO15 {
+				regulator-name = "vdd_ldo15";
+				regulator-min-microvolt = <3100000>;
+				regulator-max-microvolt = <3100000>;
+				regulator-always-on;
+			};
+
+			ldo16_reg: LDO16 {
+				regulator-name = "vdd_ldo16";
+				regulator-min-microvolt = <2200000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-always-on;
+			};
+
+			ldo17_reg: LDO17 {
+				regulator-name = "tsp_avdd";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			ldo19_reg: LDO19 {
+				regulator-name = "vdd_sd";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+			};
+
+			ldo24_reg: LDO24 {
+				regulator-name = "tsp_io";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+			};
+
+			ldo26_reg: LDO26 {
+				regulator-name = "vdd_ldo26";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+			};
+
+			buck1_reg: BUCK1 {
+				regulator-name = "vdd_mif";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck2_reg: BUCK2 {
+				regulator-name = "vdd_arm";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck3_reg: BUCK3 {
+				regulator-name = "vdd_int";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck4_reg: BUCK4 {
+				regulator-name = "vdd_g3d";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck5_reg: BUCK5 {
+				regulator-name = "vdd_mem";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck6_reg: BUCK6 {
+				regulator-name = "vdd_kfc";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck7_reg: BUCK7 {
+				regulator-name = "vdd_1.0v_ldo";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck8_reg: BUCK8 {
+				regulator-name = "vdd_1.8v_ldo";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck9_reg: BUCK9 {
+				regulator-name = "vdd_2.8v_ldo";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck10_reg: BUCK10 {
+				regulator-name = "vdd_vmem";
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <2850000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
 &hsi2c_5 {
 	status = "okay";
 	max98090: max98090 at 10 {
@@ -364,19 +365,50 @@
 	};
 };
 
-&i2s0 {
+&i2c_0 {
 	status = "okay";
+	/* A15 cluster: VDD_ARM */
+	ina231 at 40 {
+		compatible = "ti,ina231";
+		reg = <0x40>;
+		shunt-resistor = <10000>;
+	};
+
+	/* memory: VDD_MEM */
+	ina231 at 41 {
+		compatible = "ti,ina231";
+		reg = <0x41>;
+		shunt-resistor = <10000>;
+	};
+
+	/* GPU: VDD_G3D */
+	ina231 at 44 {
+		compatible = "ti,ina231";
+		reg = <0x44>;
+		shunt-resistor = <10000>;
+	};
+
+	/* A7 cluster: VDD_KFC */
+	ina231 at 45 {
+		compatible = "ti,ina231";
+		reg = <0x45>;
+		shunt-resistor = <10000>;
+	};
 };
 
-&hdmi {
+&i2c_2 {
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-max-bus-freq = <66000>;
 	status = "okay";
-	hpd-gpio = <&gpx3 7 0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&hdmi_hpd_irq>;
 
-	vdd_osc-supply = <&ldo7_reg>;
-	vdd_pll-supply = <&ldo6_reg>;
-	vdd-supply = <&ldo6_reg>;
+	hdmiddc at 50 {
+		compatible = "samsung,exynos4210-hdmiddc";
+		reg = <0x50>;
+	};
+};
+
+&i2s0 {
+	status = "okay";
 };
 
 &mfc {
@@ -432,6 +464,12 @@
 	};
 };
 
+&rtc {
+	status = "okay";
+	clocks = <&clock CLK_RTC>, <&s2mps11_osc S2MPS11_CLK_AP>;
+	clock-names = "rtc", "rtc_src";
+};
+
 &usbdrd_dwc3_0 {
 	dr_mode = "host";
 };
@@ -439,41 +477,3 @@
 &usbdrd_dwc3_1 {
 	dr_mode = "otg";
 };
-
-&i2c_0 {
-	status = "okay";
-
-	/* A15 cluster: VDD_ARM */
-	ina231 at 40 {
-		compatible = "ti,ina231";
-		reg = <0x40>;
-		shunt-resistor = <10000>;
-	};
-
-	/* memory: VDD_MEM */
-	ina231 at 41 {
-		compatible = "ti,ina231";
-		reg = <0x41>;
-		shunt-resistor = <10000>;
-	};
-
-	/* GPU: VDD_G3D */
-	ina231 at 44 {
-		compatible = "ti,ina231";
-		reg = <0x44>;
-		shunt-resistor = <10000>;
-	};
-
-	/* A7 cluster: VDD_KFC */
-	ina231 at 45 {
-		compatible = "ti,ina231";
-		reg = <0x45>;
-		shunt-resistor = <10000>;
-	};
-};
-
-&rtc {
-	status = "okay";
-	clocks = <&clock CLK_RTC>, <&s2mps11_osc S2MPS11_CLK_AP>;
-	clock-names = "rtc", "rtc_src";
-};
-- 
2.1.4
