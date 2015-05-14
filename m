From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Thu, 14 May 2015 19:12:18 +0900
Subject: [PATCH v5 11/13] ARM: dts: Use labels for overriding nodes in
 exynos4412-trats2
In-Reply-To: <1431598340-3319-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431598340-3319-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431598340-3319-12-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 1332 ++++++++++++++++---------------
 1 file changed, 667 insertions(+), 665 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index c032cde11d5c..4d0cf22acea3 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -131,411 +131,6 @@
 		};
 	};
 
-	adc: adc at 126C0000 {
-		vdd-supply = <&ldo3_reg>;
-		status = "okay";
-	};
-
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
-			interrupt-parent = <&gpm2>;
-			interrupts = <3 2>;
-			x-size = <720>;
-			y-size = <1280>;
-			avdd-supply = <&ldo23_reg>;
-			vdd-supply = <&ldo24_reg>;
-		};
-	};
-
-	i2c_0: i2c at 13860000 {
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-slave-addr = <0x10>;
-		samsung,i2c-max-bus-freq = <400000>;
-		pinctrl-0 = <&i2c0_bus>;
-		pinctrl-names = "default";
-		status = "okay";
-
-		s5c73m3 at 3c {
-			compatible = "samsung,s5c73m3";
-			reg = <0x3c>;
-			standby-gpios = <&gpm0 1 1>;   /* ISP_STANDBY */
-			xshutdown-gpios = <&gpf1 3 1>; /* ISP_RESET */
-			vdd-int-supply = <&buck9_reg>;
-			vddio-cis-supply = <&ldo9_reg>;
-			vdda-supply = <&ldo17_reg>;
-			vddio-host-supply = <&ldo18_reg>;
-			vdd-af-supply = <&cam_af_reg>;
-			vdd-reg-supply = <&cam_io_reg>;
-			clock-frequency = <24000000>;
-			/* CAM_A_CLKOUT */
-			clocks = <&camera 0>;
-			clock-names = "cis_extclk";
-			port {
-				s5c73m3_ep: endpoint {
-					remote-endpoint = <&csis0_ep>;
-					data-lanes = <1 2 3 4>;
-				};
-			};
-		};
-	};
-
-	i2c at 138A0000 {
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-slave-addr = <0x10>;
-		samsung,i2c-max-bus-freq = <100000>;
-		pinctrl-0 = <&i2c4_bus>;
-		pinctrl-names = "default";
-		status = "okay";
-
-		wm1811: wm1811 at 1a {
-			compatible = "wlf,wm1811";
-			reg = <0x1a>;
-			clocks = <&pmu_system_controller 0>;
-			clock-names = "MCLK1";
-			DCVDD-supply = <&ldo3_reg>;
-			DBVDD1-supply = <&ldo3_reg>;
-			wlf,ldo1ena = <&gpj0 4 0>;
-		};
-	};
-
-	i2c at 138D0000 {
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-slave-addr = <0x10>;
-		samsung,i2c-max-bus-freq = <100000>;
-		pinctrl-0 = <&i2c7_bus>;
-		pinctrl-names = "default";
-		status = "okay";
-
-		max77686: max77686_pmic at 09 {
-			compatible = "maxim,max77686";
-			interrupt-parent = <&gpx0>;
-			interrupts = <7 0>;
-			reg = <0x09>;
-			#clock-cells = <1>;
-
-			voltage-regulators {
-				ldo1_reg: ldo1 {
-					regulator-compatible = "LDO1";
-					regulator-name = "VALIVE_1.0V_AP";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-				};
-
-				ldo2_reg: ldo2 {
-					regulator-compatible = "LDO2";
-					regulator-name = "VM1M2_1.2V_AP";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
-					regulator-always-on;
-					regulator-state-mem {
-						regulator-on-in-suspend;
-					};
-				};
-
-				ldo3_reg: ldo3 {
-					regulator-compatible = "LDO3";
-					regulator-name = "VCC_1.8V_AP";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				ldo4_reg: ldo4 {
-					regulator-compatible = "LDO4";
-					regulator-name = "VCC_2.8V_AP";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <2800000>;
-					regulator-always-on;
-				};
-
-				ldo5_reg: ldo5 {
-					regulator-compatible = "LDO5";
-					regulator-name = "VCC_1.8V_IO";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				ldo6_reg: ldo6 {
-					regulator-compatible = "LDO6";
-					regulator-name = "VMPLL_1.0V_AP";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-					regulator-state-mem {
-						regulator-on-in-suspend;
-					};
-				};
-
-				ldo7_reg: ldo7 {
-					regulator-compatible = "LDO7";
-					regulator-name = "VPLL_1.0V_AP";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-					regulator-state-mem {
-						regulator-on-in-suspend;
-					};
-				};
-
-				ldo8_reg: ldo8 {
-					regulator-compatible = "LDO8";
-					regulator-name = "VMIPI_1.0V";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-state-mem {
-						regulator-off-in-suspend;
-					};
-				};
-
-				ldo9_reg: ldo9 {
-					regulator-compatible = "LDO9";
-					regulator-name = "CAM_ISP_MIPI_1.2V";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
-				};
-
-				ldo10_reg: ldo10 {
-					regulator-compatible = "LDO10";
-					regulator-name = "VMIPI_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-state-mem {
-						regulator-off-in-suspend;
-					};
-				};
-
-				ldo11_reg: ldo11 {
-					regulator-compatible = "LDO11";
-					regulator-name = "VABB1_1.95V";
-					regulator-min-microvolt = <1950000>;
-					regulator-max-microvolt = <1950000>;
-					regulator-always-on;
-					regulator-state-mem {
-						regulator-off-in-suspend;
-					};
-				};
-
-				ldo12_reg: ldo12 {
-					regulator-compatible = "LDO12";
-					regulator-name = "VUOTG_3.0V";
-					regulator-min-microvolt = <3000000>;
-					regulator-max-microvolt = <3000000>;
-					regulator-state-mem {
-						regulator-off-in-suspend;
-					};
-				};
-
-				ldo13_reg: ldo13 {
-					regulator-compatible = "LDO13";
-					regulator-name = "NFC_AVDD_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-				};
-
-				ldo14_reg: ldo14 {
-					regulator-compatible = "LDO14";
-					regulator-name = "VABB2_1.95V";
-					regulator-min-microvolt = <1950000>;
-					regulator-max-microvolt = <1950000>;
-					regulator-always-on;
-					regulator-state-mem {
-						regulator-off-in-suspend;
-					};
-				};
-
-				ldo15_reg: ldo15 {
-					regulator-compatible = "LDO15";
-					regulator-name = "VHSIC_1.0V";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-state-mem {
-						regulator-on-in-suspend;
-					};
-				};
-
-				ldo16_reg: ldo16 {
-					regulator-compatible = "LDO16";
-					regulator-name = "VHSIC_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-state-mem {
-						regulator-on-in-suspend;
-					};
-				};
-
-				ldo17_reg: ldo17 {
-					regulator-compatible = "LDO17";
-					regulator-name = "CAM_SENSOR_CORE_1.2V";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
-				};
-
-				ldo18_reg: ldo18 {
-					regulator-compatible = "LDO18";
-					regulator-name = "CAM_ISP_SEN_IO_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-				};
-
-				ldo19_reg: ldo19 {
-					regulator-compatible = "LDO19";
-					regulator-name = "VT_CAM_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-				};
-
-				ldo20_reg: ldo20 {
-					regulator-compatible = "LDO20";
-					regulator-name = "VDDQ_PRE_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-				};
-
-				ldo21_reg: ldo21 {
-					regulator-compatible = "LDO21";
-					regulator-name = "VTF_2.8V";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <2800000>;
-					maxim,ena-gpios = <&gpy2 0 GPIO_ACTIVE_HIGH>;
-				};
-
-				ldo22_reg: ldo22 {
-					regulator-compatible = "LDO22";
-					regulator-name = "VMEM_VDD_2.8V";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <2800000>;
-					maxim,ena-gpios = <&gpk0 2 GPIO_ACTIVE_HIGH>;
-				};
-
-				ldo23_reg: ldo23 {
-					regulator-compatible = "LDO23";
-					regulator-name = "TSP_AVDD_3.3V";
-					regulator-min-microvolt = <3300000>;
-					regulator-max-microvolt = <3300000>;
-				};
-
-				ldo24_reg: ldo24 {
-					regulator-compatible = "LDO24";
-					regulator-name = "TSP_VDD_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-				};
-
-				ldo25_reg: ldo25 {
-					regulator-compatible = "LDO25";
-					regulator-name = "LCD_VCC_3.3V";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <2800000>;
-				};
-
-				ldo26_reg: ldo26 {
-					regulator-compatible = "LDO26";
-					regulator-name = "MOTOR_VCC_3.0V";
-					regulator-min-microvolt = <3000000>;
-					regulator-max-microvolt = <3000000>;
-				};
-
-				buck1_reg: buck1 {
-					regulator-compatible = "BUCK1";
-					regulator-name = "vdd_mif";
-					regulator-min-microvolt = <850000>;
-					regulator-max-microvolt = <1100000>;
-					regulator-always-on;
-					regulator-boot-on;
-					regulator-state-mem {
-						regulator-off-in-suspend;
-					};
-				};
-
-				buck2_reg: buck2 {
-					regulator-compatible = "BUCK2";
-					regulator-name = "vdd_arm";
-					regulator-min-microvolt = <850000>;
-					regulator-max-microvolt = <1500000>;
-					regulator-always-on;
-					regulator-boot-on;
-					regulator-state-mem {
-						regulator-on-in-suspend;
-					};
-				};
-
-				buck3_reg: buck3 {
-					regulator-compatible = "BUCK3";
-					regulator-name = "vdd_int";
-					regulator-min-microvolt = <850000>;
-					regulator-max-microvolt = <1150000>;
-					regulator-always-on;
-					regulator-boot-on;
-					regulator-state-mem {
-						regulator-off-in-suspend;
-					};
-				};
-
-				buck4_reg: buck4 {
-					regulator-compatible = "BUCK4";
-					regulator-name = "vdd_g3d";
-					regulator-min-microvolt = <850000>;
-					regulator-max-microvolt = <1150000>;
-					regulator-boot-on;
-					regulator-state-mem {
-						regulator-off-in-suspend;
-					};
-				};
-
-				buck5_reg: buck5 {
-					regulator-compatible = "BUCK5";
-					regulator-name = "VMEM_1.2V_AP";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
-					regulator-always-on;
-				};
-
-				buck6_reg: buck6 {
-					regulator-compatible = "BUCK6";
-					regulator-name = "VCC_SUB_1.35V";
-					regulator-min-microvolt = <1350000>;
-					regulator-max-microvolt = <1350000>;
-					regulator-always-on;
-				};
-
-				buck7_reg: buck7 {
-					regulator-compatible = "BUCK7";
-					regulator-name = "VCC_SUB_2.0V";
-					regulator-min-microvolt = <2000000>;
-					regulator-max-microvolt = <2000000>;
-					regulator-always-on;
-				};
-
-				buck8_reg: buck8 {
-					regulator-compatible = "BUCK8";
-					regulator-name = "VMEM_VDDF_3.0V";
-					regulator-min-microvolt = <2850000>;
-					regulator-max-microvolt = <2850000>;
-					maxim,ena-gpios = <&gpk0 2 GPIO_ACTIVE_HIGH>;
-				};
-
-				buck9_reg: buck9 {
-					regulator-compatible = "BUCK9";
-					regulator-name = "CAM_ISP_CORE_1.2V";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1200000>;
-					maxim,ena-gpios = <&gpm0 3 GPIO_ACTIVE_HIGH>;
-				};
-			};
-		};
-	};
-
 	i2c_max77693: i2c-gpio-1 {
 		compatible = "i2c-gpio";
 		gpios = <&gpm2 0 GPIO_ACTIVE_HIGH>, <&gpm2 1 GPIO_ACTIVE_HIGH>;
@@ -598,54 +193,6 @@
 		};
 	};
 
-	mmc at 12550000 {
-		num-slots = <1>;
-		broken-cd;
-		non-removable;
-		card-detect-delay = <200>;
-		vmmc-supply = <&ldo22_reg>;
-		clock-frequency = <400000000>;
-		samsung,dw-mshc-ciu-div = <0>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
-		pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
-		pinctrl-names = "default";
-		status = "okay";
-		bus-width = <8>;
-		cap-mmc-highspeed;
-	};
-
-	sdhci at 12530000 {
-		bus-width = <4>;
-		cd-gpios = <&gpx3 4 0>;
-		cd-inverted;
-		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4>;
-		pinctrl-names = "default";
-		vmmc-supply = <&ldo21_reg>;
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
-	tmu at 100C0000 {
-		vtmu-supply = <&ldo10_reg>;
-		status = "okay";
-	};
-
 	i2c_ak8975: i2c-gpio-0 {
 		compatible = "i2c-gpio";
 		gpios = <&gpy2 4 0>, <&gpy2 5 0>;
@@ -677,90 +224,6 @@
 		};
 	};
 
-	spi_1: spi at 13930000 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&spi1_bus>;
-		cs-gpios = <&gpb 5 0>;
-		status = "okay";
-
-		s5c73m3_spi: s5c73m3 {
-			compatible = "samsung,s5c73m3";
-			spi-max-frequency = <50000000>;
-			reg = <0>;
-			controller-data {
-				samsung,spi-feedback-delay = <2>;
-			};
-		};
-	};
-
-	pwm: pwm at 139D0000 {
-		pinctrl-0 = <&pwm0_out>;
-		pinctrl-names = "default";
-		samsung,pwm-outputs = <0>;
-		status = "okay";
-	};
-
-	dsi_0: dsi at 11C80000 {
-		vddcore-supply = <&ldo8_reg>;
-		vddio-supply = <&ldo10_reg>;
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
-			compatible = "samsung,s6e8aa0";
-			reg = <0>;
-			vdd3-supply = <&lcd_vdd3_reg>;
-			vci-supply = <&ldo25_reg>;
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
-					clock-frequency = <0>;
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
 	camera: camera {
 		pinctrl-0 = <&cam_port_a_clk_active &cam_port_b_clk_active>;
 		pinctrl-names = "default";
@@ -770,124 +233,7 @@
 		assigned-clock-parents = <&clock CLK_XUSBXTI>,
 					 <&clock CLK_XUSBXTI>;
 
-		fimc_0: fimc at 11800000 {
-			status = "okay";
-			assigned-clocks = <&clock CLK_MOUT_FIMC0>,
-					<&clock CLK_SCLK_FIMC0>;
-			assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
-			assigned-clock-rates = <0>, <176000000>;
-		};
-
-		fimc_1: fimc at 11810000 {
-			status = "okay";
-			assigned-clocks = <&clock CLK_MOUT_FIMC1>,
-					<&clock CLK_SCLK_FIMC1>;
-			assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
-			assigned-clock-rates = <0>, <176000000>;
-		};
-
-		fimc_2: fimc at 11820000 {
-			status = "okay";
-			assigned-clocks = <&clock CLK_MOUT_FIMC2>,
-					<&clock CLK_SCLK_FIMC2>;
-			assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
-			assigned-clock-rates = <0>, <176000000>;
-		};
-
-		fimc_3: fimc at 11830000 {
-			status = "okay";
-			assigned-clocks = <&clock CLK_MOUT_FIMC3>,
-					<&clock CLK_SCLK_FIMC3>;
-			assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
-			assigned-clock-rates = <0>, <176000000>;
-		};
-
-		csis_0: csis at 11880000 {
-			status = "okay";
-			vddcore-supply = <&ldo8_reg>;
-			vddio-supply = <&ldo10_reg>;
-			assigned-clocks = <&clock CLK_MOUT_CSIS0>,
-					<&clock CLK_SCLK_CSIS0>;
-			assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
-			assigned-clock-rates = <0>, <176000000>;
-
-			/* Camera C (3) MIPI CSI-2 (CSIS0) */
-			port at 3 {
-				reg = <3>;
-				csis0_ep: endpoint {
-					remote-endpoint = <&s5c73m3_ep>;
-					data-lanes = <1 2 3 4>;
-					samsung,csis-hs-settle = <12>;
-				};
-			};
-		};
-
-		csis_1: csis at 11890000 {
-			status = "okay";
-			vddcore-supply = <&ldo8_reg>;
-			vddio-supply = <&ldo10_reg>;
-			assigned-clocks = <&clock CLK_MOUT_CSIS1>,
-					<&clock CLK_SCLK_CSIS1>;
-			assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
-			assigned-clock-rates = <0>, <176000000>;
-
-			/* Camera D (4) MIPI CSI-2 (CSIS1) */
-			port at 4 {
-				reg = <4>;
-				csis1_ep: endpoint {
-					remote-endpoint = <&is_s5k6a3_ep>;
-					data-lanes = <1>;
-					samsung,csis-hs-settle = <18>;
-					samsung,csis-wclk;
-				};
-			};
-		};
-
-		fimc_lite_0: fimc-lite at 12390000 {
-			status = "okay";
-		};
 
-		fimc_lite_1: fimc-lite at 123A0000 {
-			status = "okay";
-		};
-
-		fimc-is at 12000000 {
-			pinctrl-0 = <&fimc_is_uart>;
-			pinctrl-names = "default";
-			status = "okay";
-
-			i2c1_isp: i2c-isp at 12140000 {
-				pinctrl-0 = <&fimc_is_i2c1>;
-				pinctrl-names = "default";
-
-				s5k6a3 at 10 {
-					compatible = "samsung,s5k6a3";
-					reg = <0x10>;
-					svdda-supply = <&cam_io_reg>;
-					svddio-supply = <&ldo19_reg>;
-					afvdd-supply = <&ldo19_reg>;
-					clock-frequency = <24000000>;
-					/* CAM_B_CLKOUT */
-					clocks = <&camera 1>;
-					clock-names = "extclk";
-					samsung,camclk-out = <1>;
-					gpios = <&gpm1 6 0>;
-
-					port {
-						is_s5k6a3_ep: endpoint {
-							remote-endpoint = <&csis1_ep>;
-							data-lanes = <1>;
-						};
-					};
-				};
-			};
-		};
-	};
-
-	i2s0: i2s at 03830000 {
-		pinctrl-0 = <&i2s0_bus>;
-		pinctrl-names = "default";
-		status = "okay";
 	};
 
 	sound {
@@ -902,17 +248,6 @@
 			"SPK", "SPKOUTRP";
 	};
 
-	exynos-usbphy at 125B0000 {
-		status = "okay";
-	};
-
-	hsotg at 12480000 {
-		vusb_d-supply = <&ldo15_reg>;
-		vusb_a-supply = <&ldo12_reg>;
-		dr_mode = "peripheral";
-		status = "okay";
-	};
-
 	thermistor-ap at 0 {
 		compatible = "ntc,ncp15wb473";
 		pullup-uv = <1800000>;	 /* VCC_1.8V_AP */
@@ -945,6 +280,619 @@
 	};
 };
 
+&adc {
+	vdd-supply = <&ldo3_reg>;
+	status = "okay";
+};
+
+&csis_0 {
+	status = "okay";
+	vddcore-supply = <&ldo8_reg>;
+	vddio-supply = <&ldo10_reg>;
+	assigned-clocks = <&clock CLK_MOUT_CSIS0>,
+			<&clock CLK_SCLK_CSIS0>;
+	assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+	assigned-clock-rates = <0>, <176000000>;
+
+	/* Camera C (3) MIPI CSI-2 (CSIS0) */
+	port at 3 {
+		reg = <3>;
+		csis0_ep: endpoint {
+			remote-endpoint = <&s5c73m3_ep>;
+			data-lanes = <1 2 3 4>;
+			samsung,csis-hs-settle = <12>;
+		};
+	};
+};
+
+&csis_1 {
+	status = "okay";
+	vddcore-supply = <&ldo8_reg>;
+	vddio-supply = <&ldo10_reg>;
+	assigned-clocks = <&clock CLK_MOUT_CSIS1>,
+			<&clock CLK_SCLK_CSIS1>;
+	assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+	assigned-clock-rates = <0>, <176000000>;
+
+	/* Camera D (4) MIPI CSI-2 (CSIS1) */
+	port at 4 {
+		reg = <4>;
+		csis1_ep: endpoint {
+			remote-endpoint = <&is_s5k6a3_ep>;
+			data-lanes = <1>;
+			samsung,csis-hs-settle = <18>;
+			samsung,csis-wclk;
+		};
+	};
+};
+
+&dsi_0 {
+	vddcore-supply = <&ldo8_reg>;
+	vddio-supply = <&ldo10_reg>;
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
+		compatible = "samsung,s6e8aa0";
+		reg = <0>;
+		vdd3-supply = <&lcd_vdd3_reg>;
+		vci-supply = <&ldo25_reg>;
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
+				clock-frequency = <0>;
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
+&fimc_0 {
+	status = "okay";
+	assigned-clocks = <&clock CLK_MOUT_FIMC0>,
+			<&clock CLK_SCLK_FIMC0>;
+	assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+	assigned-clock-rates = <0>, <176000000>;
+};
+
+&fimc_1 {
+	status = "okay";
+	assigned-clocks = <&clock CLK_MOUT_FIMC1>,
+			<&clock CLK_SCLK_FIMC1>;
+	assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+	assigned-clock-rates = <0>, <176000000>;
+};
+
+&fimc_2 {
+	status = "okay";
+	assigned-clocks = <&clock CLK_MOUT_FIMC2>,
+			<&clock CLK_SCLK_FIMC2>;
+	assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+	assigned-clock-rates = <0>, <176000000>;
+};
+
+&fimc_3 {
+	status = "okay";
+	assigned-clocks = <&clock CLK_MOUT_FIMC3>,
+			<&clock CLK_SCLK_FIMC3>;
+	assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+	assigned-clock-rates = <0>, <176000000>;
+};
+
+&fimc_is {
+	pinctrl-0 = <&fimc_is_uart>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	i2c1_isp: i2c-isp at 12140000 {
+		pinctrl-0 = <&fimc_is_i2c1>;
+		pinctrl-names = "default";
+
+		s5k6a3 at 10 {
+			compatible = "samsung,s5k6a3";
+			reg = <0x10>;
+			svdda-supply = <&cam_io_reg>;
+			svddio-supply = <&ldo19_reg>;
+			afvdd-supply = <&ldo19_reg>;
+			clock-frequency = <24000000>;
+			/* CAM_B_CLKOUT */
+			clocks = <&camera 1>;
+			clock-names = "extclk";
+			samsung,camclk-out = <1>;
+			gpios = <&gpm1 6 0>;
+
+			port {
+				is_s5k6a3_ep: endpoint {
+					remote-endpoint = <&csis1_ep>;
+					data-lanes = <1>;
+				};
+			};
+		};
+	};
+};
+
+&fimc_lite_0 {
+	status = "okay";
+};
+
+&fimc_lite_1 {
+	status = "okay";
+};
+
+&fimd {
+	status = "okay";
+};
+
+&hsotg {
+	vusb_d-supply = <&ldo15_reg>;
+	vusb_a-supply = <&ldo12_reg>;
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&i2c_0 {
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-slave-addr = <0x10>;
+	samsung,i2c-max-bus-freq = <400000>;
+	pinctrl-0 = <&i2c0_bus>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	s5c73m3 at 3c {
+		compatible = "samsung,s5c73m3";
+		reg = <0x3c>;
+		standby-gpios = <&gpm0 1 1>;   /* ISP_STANDBY */
+		xshutdown-gpios = <&gpf1 3 1>; /* ISP_RESET */
+		vdd-int-supply = <&buck9_reg>;
+		vddio-cis-supply = <&ldo9_reg>;
+		vdda-supply = <&ldo17_reg>;
+		vddio-host-supply = <&ldo18_reg>;
+		vdd-af-supply = <&cam_af_reg>;
+		vdd-reg-supply = <&cam_io_reg>;
+		clock-frequency = <24000000>;
+		/* CAM_A_CLKOUT */
+		clocks = <&camera 0>;
+		clock-names = "cis_extclk";
+		port {
+			s5c73m3_ep: endpoint {
+				remote-endpoint = <&csis0_ep>;
+				data-lanes = <1 2 3 4>;
+			};
+		};
+	};
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
+		interrupt-parent = <&gpm2>;
+		interrupts = <3 2>;
+		x-size = <720>;
+		y-size = <1280>;
+		avdd-supply = <&ldo23_reg>;
+		vdd-supply = <&ldo24_reg>;
+	};
+};
+
+&i2c_4 {
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-slave-addr = <0x10>;
+	samsung,i2c-max-bus-freq = <100000>;
+	pinctrl-0 = <&i2c4_bus>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	wm1811: wm1811 at 1a {
+		compatible = "wlf,wm1811";
+		reg = <0x1a>;
+		clocks = <&pmu_system_controller 0>;
+		clock-names = "MCLK1";
+		DCVDD-supply = <&ldo3_reg>;
+		DBVDD1-supply = <&ldo3_reg>;
+		wlf,ldo1ena = <&gpj0 4 0>;
+	};
+};
+
+&i2c_7 {
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-slave-addr = <0x10>;
+	samsung,i2c-max-bus-freq = <100000>;
+	pinctrl-0 = <&i2c7_bus>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	max77686: max77686_pmic at 09 {
+		compatible = "maxim,max77686";
+		interrupt-parent = <&gpx0>;
+		interrupts = <7 0>;
+		reg = <0x09>;
+		#clock-cells = <1>;
+
+		voltage-regulators {
+			ldo1_reg: ldo1 {
+				regulator-compatible = "LDO1";
+				regulator-name = "VALIVE_1.0V_AP";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
+
+			ldo2_reg: ldo2 {
+				regulator-compatible = "LDO2";
+				regulator-name = "VM1M2_1.2V_AP";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo3_reg: ldo3 {
+				regulator-compatible = "LDO3";
+				regulator-name = "VCC_1.8V_AP";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo4_reg: ldo4 {
+				regulator-compatible = "LDO4";
+				regulator-name = "VCC_2.8V_AP";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+			};
+
+			ldo5_reg: ldo5 {
+				regulator-compatible = "LDO5";
+				regulator-name = "VCC_1.8V_IO";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo6_reg: ldo6 {
+				regulator-compatible = "LDO6";
+				regulator-name = "VMPLL_1.0V_AP";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo7_reg: ldo7 {
+				regulator-compatible = "LDO7";
+				regulator-name = "VPLL_1.0V_AP";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo8_reg: ldo8 {
+				regulator-compatible = "LDO8";
+				regulator-name = "VMIPI_1.0V";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo9_reg: ldo9 {
+				regulator-compatible = "LDO9";
+				regulator-name = "CAM_ISP_MIPI_1.2V";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			ldo10_reg: ldo10 {
+				regulator-compatible = "LDO10";
+				regulator-name = "VMIPI_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo11_reg: ldo11 {
+				regulator-compatible = "LDO11";
+				regulator-name = "VABB1_1.95V";
+				regulator-min-microvolt = <1950000>;
+				regulator-max-microvolt = <1950000>;
+				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo12_reg: ldo12 {
+				regulator-compatible = "LDO12";
+				regulator-name = "VUOTG_3.0V";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo13_reg: ldo13 {
+				regulator-compatible = "LDO13";
+				regulator-name = "NFC_AVDD_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			ldo14_reg: ldo14 {
+				regulator-compatible = "LDO14";
+				regulator-name = "VABB2_1.95V";
+				regulator-min-microvolt = <1950000>;
+				regulator-max-microvolt = <1950000>;
+				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo15_reg: ldo15 {
+				regulator-compatible = "LDO15";
+				regulator-name = "VHSIC_1.0V";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo16_reg: ldo16 {
+				regulator-compatible = "LDO16";
+				regulator-name = "VHSIC_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			ldo17_reg: ldo17 {
+				regulator-compatible = "LDO17";
+				regulator-name = "CAM_SENSOR_CORE_1.2V";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			ldo18_reg: ldo18 {
+				regulator-compatible = "LDO18";
+				regulator-name = "CAM_ISP_SEN_IO_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			ldo19_reg: ldo19 {
+				regulator-compatible = "LDO19";
+				regulator-name = "VT_CAM_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			ldo20_reg: ldo20 {
+				regulator-compatible = "LDO20";
+				regulator-name = "VDDQ_PRE_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			ldo21_reg: ldo21 {
+				regulator-compatible = "LDO21";
+				regulator-name = "VTF_2.8V";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				maxim,ena-gpios = <&gpy2 0 GPIO_ACTIVE_HIGH>;
+			};
+
+			ldo22_reg: ldo22 {
+				regulator-compatible = "LDO22";
+				regulator-name = "VMEM_VDD_2.8V";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				maxim,ena-gpios = <&gpk0 2 GPIO_ACTIVE_HIGH>;
+			};
+
+			ldo23_reg: ldo23 {
+				regulator-compatible = "LDO23";
+				regulator-name = "TSP_AVDD_3.3V";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo24_reg: ldo24 {
+				regulator-compatible = "LDO24";
+				regulator-name = "TSP_VDD_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			ldo25_reg: ldo25 {
+				regulator-compatible = "LDO25";
+				regulator-name = "LCD_VCC_3.3V";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+			};
+
+			ldo26_reg: ldo26 {
+				regulator-compatible = "LDO26";
+				regulator-name = "MOTOR_VCC_3.0V";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+			};
+
+			buck1_reg: buck1 {
+				regulator-compatible = "BUCK1";
+				regulator-name = "vdd_mif";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			buck2_reg: buck2 {
+				regulator-compatible = "BUCK2";
+				regulator-name = "vdd_arm";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			buck3_reg: buck3 {
+				regulator-compatible = "BUCK3";
+				regulator-name = "vdd_int";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1150000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			buck4_reg: buck4 {
+				regulator-compatible = "BUCK4";
+				regulator-name = "vdd_g3d";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1150000>;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			buck5_reg: buck5 {
+				regulator-compatible = "BUCK5";
+				regulator-name = "VMEM_1.2V_AP";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+			};
+
+			buck6_reg: buck6 {
+				regulator-compatible = "BUCK6";
+				regulator-name = "VCC_SUB_1.35V";
+				regulator-min-microvolt = <1350000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
+			};
+
+			buck7_reg: buck7 {
+				regulator-compatible = "BUCK7";
+				regulator-name = "VCC_SUB_2.0V";
+				regulator-min-microvolt = <2000000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-always-on;
+			};
+
+			buck8_reg: buck8 {
+				regulator-compatible = "BUCK8";
+				regulator-name = "VMEM_VDDF_3.0V";
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <2850000>;
+				maxim,ena-gpios = <&gpk0 2 GPIO_ACTIVE_HIGH>;
+			};
+
+			buck9_reg: buck9 {
+				regulator-compatible = "BUCK9";
+				regulator-name = "CAM_ISP_CORE_1.2V";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1200000>;
+				maxim,ena-gpios = <&gpm0 3 GPIO_ACTIVE_HIGH>;
+			};
+		};
+	};
+};
+
+&i2s0 {
+	pinctrl-0 = <&i2s0_bus>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&mshc_0 {
+	num-slots = <1>;
+	broken-cd;
+	non-removable;
+	card-detect-delay = <200>;
+	vmmc-supply = <&ldo22_reg>;
+	clock-frequency = <400000000>;
+	samsung,dw-mshc-ciu-div = <0>;
+	samsung,dw-mshc-sdr-timing = <2 3>;
+	samsung,dw-mshc-ddr-timing = <1 2>;
+	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
+	pinctrl-names = "default";
+	status = "okay";
+	bus-width = <8>;
+	cap-mmc-highspeed;
+};
+
 &pmu_system_controller {
 	assigned-clocks = <&pmu_system_controller 0>;
 	assigned-clock-parents =  <&clock CLK_XUSBXTI>;
@@ -1306,8 +1254,62 @@
 	};
 };
 
+&pwm {
+	pinctrl-0 = <&pwm0_out>;
+	pinctrl-names = "default";
+	samsung,pwm-outputs = <0>;
+	status = "okay";
+};
+
 &rtc {
 	status = "okay";
 	clocks = <&clock CLK_RTC>, <&max77686 MAX77686_CLK_AP>;
 	clock-names = "rtc", "rtc_src";
 };
+
+&sdhci_2 {
+	bus-width = <4>;
+	cd-gpios = <&gpx3 4 0>;
+	cd-inverted;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4>;
+	pinctrl-names = "default";
+	vmmc-supply = <&ldo21_reg>;
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
+&spi_1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_bus>;
+	cs-gpios = <&gpb 5 0>;
+	status = "okay";
+
+	s5c73m3_spi: s5c73m3 {
+		compatible = "samsung,s5c73m3";
+		spi-max-frequency = <50000000>;
+		reg = <0>;
+		controller-data {
+			samsung,spi-feedback-delay = <2>;
+		};
+	};
+};
+
+&tmu {
+	vtmu-supply = <&ldo10_reg>;
+	status = "okay";
+};
-- 
2.1.4
