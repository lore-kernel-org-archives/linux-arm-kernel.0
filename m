From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sun, 17 May 2015 17:09:51 +0900
Subject: [PATCH v6 05/13] ARM: dts: Use labels for overriding nodes in
 exynos4210-trats
In-Reply-To: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431850195-9558-10-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts | 592 ++++++++++++++++-----------------
 1 file changed, 296 insertions(+), 296 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 32c5fd8f6269..98f3ce65cb9a 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -89,42 +89,6 @@
 		};
 	};
 
-	hsotg at 12480000 {
-		vusb_d-supply = <&vusb_reg>;
-		vusb_a-supply = <&vusbdac_reg>;
-		dr_mode = "peripheral";
-		status = "okay";
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
-	exynos-usbphy at 125B0000 {
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
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -158,201 +122,6 @@
 		};
 	};
 
-	i2c at 13890000 {
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-slave-addr = <0x10>;
-		samsung,i2c-max-bus-freq = <400000>;
-		pinctrl-0 = <&i2c3_bus>;
-		pinctrl-names = "default";
-		status = "okay";
-
-		mms114-touchscreen at 48 {
-			compatible = "melfas,mms114";
-			reg = <0x48>;
-			interrupt-parent = <&gpx0>;
-			interrupts = <4 2>;
-			x-size = <720>;
-			y-size = <1280>;
-			avdd-supply = <&tsp_reg>;
-			vdd-supply = <&tsp_reg>;
-		};
-	};
-
-	i2c at 138B0000 {
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-slave-addr = <0x10>;
-		samsung,i2c-max-bus-freq = <100000>;
-		pinctrl-0 = <&i2c5_bus>;
-		pinctrl-names = "default";
-		status = "okay";
-
-		max8997_pmic at 66 {
-			compatible = "maxim,max8997-pmic";
-
-			reg = <0x66>;
-
-			max8997,pmic-buck1-uses-gpio-dvs;
-			max8997,pmic-buck2-uses-gpio-dvs;
-			max8997,pmic-buck5-uses-gpio-dvs;
-
-			max8997,pmic-ignore-gpiodvs-side-effect;
-			max8997,pmic-buck125-default-dvs-idx = <0>;
-
-			max8997,pmic-buck125-dvs-gpios = <&gpx0 5 0>,
-						         <&gpx0 6 0>,
-							 <&gpl0 0 0>;
-
-			max8997,pmic-buck1-dvs-voltage = <1350000>, <1300000>,
-							 <1250000>, <1200000>,
-							 <1150000>, <1100000>,
-							 <1000000>, <950000>;
-
-			max8997,pmic-buck2-dvs-voltage = <1100000>, <1000000>,
-							 <950000>,  <900000>,
-							 <1100000>, <1000000>,
-							 <950000>,  <900000>;
-
-			max8997,pmic-buck5-dvs-voltage = <1200000>, <1200000>,
-							 <1200000>, <1200000>,
-							 <1200000>, <1200000>,
-							 <1200000>, <1200000>;
-
-			regulators {
-				valive_reg: LDO2 {
-				     regulator-name = "VALIVE_1.1V_C210";
-				     regulator-min-microvolt = <1100000>;
-				     regulator-max-microvolt = <1100000>;
-				     regulator-always-on;
-				};
-
-				vusb_reg: LDO3 {
-				     regulator-name = "VUSB_1.1V_C210";
-				     regulator-min-microvolt = <1100000>;
-				     regulator-max-microvolt = <1100000>;
-				};
-
-				vmipi_reg: LDO4 {
-				     regulator-name = "VMIPI_1.8V";
-				     regulator-min-microvolt = <1800000>;
-				     regulator-max-microvolt = <1800000>;
-				};
-
-				vpda_reg: LDO6 {
-				     regulator-name = "VCC_1.8V_PDA";
-				     regulator-min-microvolt = <1800000>;
-				     regulator-max-microvolt = <1800000>;
-				     regulator-always-on;
-				};
-
-				vcam_reg: LDO7 {
-				     regulator-name = "CAM_ISP_1.8V";
-				     regulator-min-microvolt = <1800000>;
-				     regulator-max-microvolt = <1800000>;
-				};
-
-				vusbdac_reg: LDO8 {
-				     regulator-name = "VUSB/VDAC_3.3V_C210";
-				     regulator-min-microvolt = <3300000>;
-				     regulator-max-microvolt = <3300000>;
-				};
-
-				vccpda_reg: LDO9 {
-				     regulator-name = "VCC_2.8V_PDA";
-				     regulator-min-microvolt = <2800000>;
-				     regulator-max-microvolt = <2800000>;
-				     regulator-always-on;
-				};
-
-				vpll_reg: LDO10 {
-				     regulator-name = "VPLL_1.1V_C210";
-				     regulator-min-microvolt = <1100000>;
-				     regulator-max-microvolt = <1100000>;
-				     regulator-always-on;
-				};
-
-				vtcam_reg: LDO12 {
-				     regulator-name = "VT_CAM_1.8V";
-				     regulator-min-microvolt = <1800000>;
-				     regulator-max-microvolt = <1800000>;
-				};
-
-				vcclcd_reg: LDO13 {
-				     regulator-name = "VCC_3.3V_LCD";
-				     regulator-min-microvolt = <3300000>;
-				     regulator-max-microvolt = <3300000>;
-				};
-
-				vlcd_reg: LDO15 {
-				     regulator-name = "VLCD_2.2V";
-				     regulator-min-microvolt = <2200000>;
-				     regulator-max-microvolt = <2200000>;
-				};
-
-				camsensor_reg: LDO16 {
-				     regulator-name = "CAM_SENSOR_IO_1.8V";
-				     regulator-min-microvolt = <1800000>;
-				     regulator-max-microvolt = <1800000>;
-				};
-
-				vddq_reg: LDO21 {
-				     regulator-name = "VDDQ_M1M2_1.2V";
-				     regulator-min-microvolt = <1200000>;
-				     regulator-max-microvolt = <1200000>;
-				     regulator-always-on;
-				};
-
-				varm_breg: BUCK1 {
-				     /*
-				      * HACK: The real name is VARM_1.2V_C210,
-				      * but exynos-cpufreq does not support
-				      * DT-based regulator lookup yet.
-				      */
-				     regulator-name = "vdd_arm";
-				     regulator-min-microvolt = <900000>;
-				     regulator-max-microvolt = <1350000>;
-				     regulator-always-on;
-				};
-
-				vint_breg: BUCK2 {
-				     regulator-name = "VINT_1.1V_C210";
-				     regulator-min-microvolt = <900000>;
-				     regulator-max-microvolt = <1100000>;
-				     regulator-always-on;
-				};
-
-				camisp_breg: BUCK4 {
-				     regulator-name = "CAM_ISP_CORE_1.2V";
-				     regulator-min-microvolt = <1200000>;
-				     regulator-max-microvolt = <1200000>;
-				};
-
-				vmem_breg: BUCK5 {
-				     regulator-name = "VMEM_1.2V_C210";
-				     regulator-min-microvolt = <1200000>;
-				     regulator-max-microvolt = <1200000>;
-				     regulator-always-on;
-				};
-
-				vccsub_breg: BUCK7 {
-				     regulator-name = "VCC_SUB_2.0V";
-				     regulator-min-microvolt = <2000000>;
-				     regulator-max-microvolt = <2000000>;
-				     regulator-always-on;
-				};
-
-				safe1_sreg: ESAFEOUT1 {
-				     regulator-name = "SAFEOUT1";
-				     regulator-always-on;
-				};
-
-				safe2_sreg: ESAFEOUT2 {
-				     regulator-name = "SAFEOUT2";
-				     regulator-boot-on;
-				};
-			};
-		};
-	};
-
 	fixed-rate-clocks {
 		xxti {
 			compatible = "samsung,clock-xxti";
@@ -365,71 +134,6 @@
 		};
 	};
 
-	dsi_0: dsi at 11C80000 {
-		vddcore-supply = <&vusb_reg>;
-		vddio-supply = <&vmipi_reg>;
-		samsung,pll-clock-frequency = <24000000>;
-		status = "okay";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port at 1 {
-				reg = <1>;
-
-				dsi_out: endpoint {
-					remote-endpoint = <&dsi_in>;
-					samsung,burst-clock-frequency = <500000000>;
-					samsung,esc-clock-frequency = <20000000>;
-				};
-			};
-		};
-
-		panel at 0 {
-			reg = <0>;
-			compatible = "samsung,s6e8aa0";
-			vdd3-supply = <&vcclcd_reg>;
-			vci-supply = <&vlcd_reg>;
-			reset-gpios = <&gpy4 5 0>;
-			power-on-delay= <50>;
-			reset-delay = <100>;
-			init-delay = <100>;
-			flip-horizontal;
-			flip-vertical;
-			panel-width-mm = <58>;
-			panel-height-mm = <103>;
-
-			display-timings {
-				timing-0 {
-					clock-frequency = <57153600>;
-					hactive = <720>;
-					vactive = <1280>;
-					hfront-porch = <5>;
-					hback-porch = <5>;
-					hsync-len = <5>;
-					vfront-porch = <13>;
-					vback-porch = <1>;
-					vsync-len = <2>;
-				};
-			};
-
-			port {
-				dsi_in: endpoint {
-					remote-endpoint = <&dsi_out>;
-				};
-			};
-		};
-	};
-
-	fimd at 11c00000 {
-		status = "okay";
-	};
-
-	tmu at 100C0000 {
-		status = "okay";
-	};
-
 	thermal-zones {
 		cpu_thermal: cpu-thermal {
 			cooling-maps {
@@ -483,3 +187,299 @@
 		};
 	};
 };
+
+&dsi_0 {
+	vddcore-supply = <&vusb_reg>;
+	vddio-supply = <&vmipi_reg>;
+	samsung,pll-clock-frequency = <24000000>;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 1 {
+			reg = <1>;
+
+			dsi_out: endpoint {
+				remote-endpoint = <&dsi_in>;
+				samsung,burst-clock-frequency = <500000000>;
+				samsung,esc-clock-frequency = <20000000>;
+			};
+		};
+	};
+
+	panel at 0 {
+		reg = <0>;
+		compatible = "samsung,s6e8aa0";
+		vdd3-supply = <&vcclcd_reg>;
+		vci-supply = <&vlcd_reg>;
+		reset-gpios = <&gpy4 5 0>;
+		power-on-delay= <50>;
+		reset-delay = <100>;
+		init-delay = <100>;
+		flip-horizontal;
+		flip-vertical;
+		panel-width-mm = <58>;
+		panel-height-mm = <103>;
+
+		display-timings {
+			timing-0 {
+				clock-frequency = <57153600>;
+				hactive = <720>;
+				vactive = <1280>;
+				hfront-porch = <5>;
+				hback-porch = <5>;
+				hsync-len = <5>;
+				vfront-porch = <13>;
+				vback-porch = <1>;
+				vsync-len = <2>;
+			};
+		};
+
+		port {
+			dsi_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+};
+
+&exynos_usbphy {
+	status = "okay";
+};
+
+&fimd {
+	status = "okay";
+};
+
+&hsotg {
+	vusb_d-supply = <&vusb_reg>;
+	vusb_a-supply = <&vusbdac_reg>;
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&i2c_3 {
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-slave-addr = <0x10>;
+	samsung,i2c-max-bus-freq = <400000>;
+	pinctrl-0 = <&i2c3_bus>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	mms114-touchscreen at 48 {
+		compatible = "melfas,mms114";
+		reg = <0x48>;
+		interrupt-parent = <&gpx0>;
+		interrupts = <4 2>;
+		x-size = <720>;
+		y-size = <1280>;
+		avdd-supply = <&tsp_reg>;
+		vdd-supply = <&tsp_reg>;
+	};
+};
+
+&i2c_5 {
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-slave-addr = <0x10>;
+	samsung,i2c-max-bus-freq = <100000>;
+	pinctrl-0 = <&i2c5_bus>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	max8997_pmic at 66 {
+		compatible = "maxim,max8997-pmic";
+
+		reg = <0x66>;
+
+		max8997,pmic-buck1-uses-gpio-dvs;
+		max8997,pmic-buck2-uses-gpio-dvs;
+		max8997,pmic-buck5-uses-gpio-dvs;
+
+		max8997,pmic-ignore-gpiodvs-side-effect;
+		max8997,pmic-buck125-default-dvs-idx = <0>;
+
+		max8997,pmic-buck125-dvs-gpios = <&gpx0 5 0>,
+						 <&gpx0 6 0>,
+						 <&gpl0 0 0>;
+
+		max8997,pmic-buck1-dvs-voltage = <1350000>, <1300000>,
+						 <1250000>, <1200000>,
+						 <1150000>, <1100000>,
+						 <1000000>, <950000>;
+
+		max8997,pmic-buck2-dvs-voltage = <1100000>, <1000000>,
+						 <950000>,  <900000>,
+						 <1100000>, <1000000>,
+						 <950000>,  <900000>;
+
+		max8997,pmic-buck5-dvs-voltage = <1200000>, <1200000>,
+						 <1200000>, <1200000>,
+						 <1200000>, <1200000>,
+						 <1200000>, <1200000>;
+
+		regulators {
+			valive_reg: LDO2 {
+			     regulator-name = "VALIVE_1.1V_C210";
+			     regulator-min-microvolt = <1100000>;
+			     regulator-max-microvolt = <1100000>;
+			     regulator-always-on;
+			};
+
+			vusb_reg: LDO3 {
+			     regulator-name = "VUSB_1.1V_C210";
+			     regulator-min-microvolt = <1100000>;
+			     regulator-max-microvolt = <1100000>;
+			};
+
+			vmipi_reg: LDO4 {
+			     regulator-name = "VMIPI_1.8V";
+			     regulator-min-microvolt = <1800000>;
+			     regulator-max-microvolt = <1800000>;
+			};
+
+			vpda_reg: LDO6 {
+			     regulator-name = "VCC_1.8V_PDA";
+			     regulator-min-microvolt = <1800000>;
+			     regulator-max-microvolt = <1800000>;
+			     regulator-always-on;
+			};
+
+			vcam_reg: LDO7 {
+			     regulator-name = "CAM_ISP_1.8V";
+			     regulator-min-microvolt = <1800000>;
+			     regulator-max-microvolt = <1800000>;
+			};
+
+			vusbdac_reg: LDO8 {
+			     regulator-name = "VUSB/VDAC_3.3V_C210";
+			     regulator-min-microvolt = <3300000>;
+			     regulator-max-microvolt = <3300000>;
+			};
+
+			vccpda_reg: LDO9 {
+			     regulator-name = "VCC_2.8V_PDA";
+			     regulator-min-microvolt = <2800000>;
+			     regulator-max-microvolt = <2800000>;
+			     regulator-always-on;
+			};
+
+			vpll_reg: LDO10 {
+			     regulator-name = "VPLL_1.1V_C210";
+			     regulator-min-microvolt = <1100000>;
+			     regulator-max-microvolt = <1100000>;
+			     regulator-always-on;
+			};
+
+			vtcam_reg: LDO12 {
+			     regulator-name = "VT_CAM_1.8V";
+			     regulator-min-microvolt = <1800000>;
+			     regulator-max-microvolt = <1800000>;
+			};
+
+			vcclcd_reg: LDO13 {
+			     regulator-name = "VCC_3.3V_LCD";
+			     regulator-min-microvolt = <3300000>;
+			     regulator-max-microvolt = <3300000>;
+			};
+
+			vlcd_reg: LDO15 {
+			     regulator-name = "VLCD_2.2V";
+			     regulator-min-microvolt = <2200000>;
+			     regulator-max-microvolt = <2200000>;
+			};
+
+			camsensor_reg: LDO16 {
+			     regulator-name = "CAM_SENSOR_IO_1.8V";
+			     regulator-min-microvolt = <1800000>;
+			     regulator-max-microvolt = <1800000>;
+			};
+
+			vddq_reg: LDO21 {
+			     regulator-name = "VDDQ_M1M2_1.2V";
+			     regulator-min-microvolt = <1200000>;
+			     regulator-max-microvolt = <1200000>;
+			     regulator-always-on;
+			};
+
+			varm_breg: BUCK1 {
+			     /*
+			      * HACK: The real name is VARM_1.2V_C210,
+			      * but exynos-cpufreq does not support
+			      * DT-based regulator lookup yet.
+			      */
+			     regulator-name = "vdd_arm";
+			     regulator-min-microvolt = <900000>;
+			     regulator-max-microvolt = <1350000>;
+			     regulator-always-on;
+			};
+
+			vint_breg: BUCK2 {
+			     regulator-name = "VINT_1.1V_C210";
+			     regulator-min-microvolt = <900000>;
+			     regulator-max-microvolt = <1100000>;
+			     regulator-always-on;
+			};
+
+			camisp_breg: BUCK4 {
+			     regulator-name = "CAM_ISP_CORE_1.2V";
+			     regulator-min-microvolt = <1200000>;
+			     regulator-max-microvolt = <1200000>;
+			};
+
+			vmem_breg: BUCK5 {
+			     regulator-name = "VMEM_1.2V_C210";
+			     regulator-min-microvolt = <1200000>;
+			     regulator-max-microvolt = <1200000>;
+			     regulator-always-on;
+			};
+
+			vccsub_breg: BUCK7 {
+			     regulator-name = "VCC_SUB_2.0V";
+			     regulator-min-microvolt = <2000000>;
+			     regulator-max-microvolt = <2000000>;
+			     regulator-always-on;
+			};
+
+			safe1_sreg: ESAFEOUT1 {
+			     regulator-name = "SAFEOUT1";
+			     regulator-always-on;
+			};
+
+			safe2_sreg: ESAFEOUT2 {
+			     regulator-name = "SAFEOUT2";
+			     regulator-boot-on;
+			};
+		};
+	};
+};
+
+&sdhci_0 {
+	bus-width = <8>;
+	non-removable;
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus8>;
+	pinctrl-names = "default";
+	vmmc-supply = <&vemmc_reg>;
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
+&tmu {
+	status = "okay";
+};
-- 
2.1.4
