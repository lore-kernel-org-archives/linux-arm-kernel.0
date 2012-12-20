From: pengw@nvidia.com (Bryan Wu)
Date: Thu, 20 Dec 2012 11:41:28 -0800
Subject: [PATCH 1/2] ARM: DT: tegra: Add Tegra30 Beaver board support
Message-ID: <1356032489-27619-1-git-send-email-pengw@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for Tegra30 Beaver board in upstream kernel.

Beaver board is a Tegra30 SoC based development board, it has
following features:
 - T30 or T33 SoC (Qual core ARM Cortex A9)
 - 2 GB DDR3L
 - 16 GB EMMC
 - 1 SD slot
 - 1 USB Standart A port and 1 USB micro AB port
 - PCI-E Gig Ethernet
 - Audio input/output
 - SATA port
 - HDMI output
 - UART and JTAG

Signed-off-by: Bryan Wu <pengw@nvidia.com>
---
 arch/arm/boot/dts/Makefile           |    3 +-
 arch/arm/boot/dts/tegra30-beaver.dts |  374 ++++++++++++++++++++++++++++++++++
 2 files changed, 376 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/tegra30-beaver.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d077ef8..a71025c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -144,7 +144,8 @@ dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
 	tegra20-ventana.dtb \
 	tegra20-whistler.dtb \
 	tegra30-cardhu-a02.dtb \
-	tegra30-cardhu-a04.dtb
+	tegra30-cardhu-a04.dtb \
+	tegra30-beaver.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2p-ca5s.dtb \
 	vexpress-v2p-ca9.dtb \
 	vexpress-v2p-ca15-tc1.dtb \
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
new file mode 100644
index 0000000..0f296a4
--- /dev/null
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -0,0 +1,374 @@
+/dts-v1/;
+
+/include/ "tegra30.dtsi"
+
+/ {
+	model = "NVIDIA Tegra30 Beaver evaluation board";
+	compatible = "nvidia,beaver", "nvidia,tegra30";
+
+	memory {
+		reg = <0x80000000 0x80000000>;
+	};
+
+	pinmux {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			sdmmc1_clk_pz0 {
+				nvidia,pins = "sdmmc1_clk_pz0";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <0>;
+				nvidia,tristate = <0>;
+			};
+			sdmmc1_cmd_pz1 {
+				nvidia,pins =	"sdmmc1_cmd_pz1",
+						"sdmmc1_dat0_py7",
+						"sdmmc1_dat1_py6",
+						"sdmmc1_dat2_py5",
+						"sdmmc1_dat3_py4";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <2>;
+				nvidia,tristate = <0>;
+			};
+			sdmmc3_clk_pa6 {
+				nvidia,pins = "sdmmc3_clk_pa6";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <0>;
+				nvidia,tristate = <0>;
+			};
+			sdmmc3_cmd_pa7 {
+				nvidia,pins =	"sdmmc3_cmd_pa7",
+						"sdmmc3_dat0_pb7",
+						"sdmmc3_dat1_pb6",
+						"sdmmc3_dat2_pb5",
+						"sdmmc3_dat3_pb4";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <2>;
+				nvidia,tristate = <0>;
+			};
+			sdmmc4_clk_pcc4 {
+				nvidia,pins =	"sdmmc4_clk_pcc4",
+						"sdmmc4_rst_n_pcc3";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <0>;
+				nvidia,tristate = <0>;
+			};
+			sdmmc4_dat0_paa0 {
+				nvidia,pins =	"sdmmc4_dat0_paa0",
+						"sdmmc4_dat1_paa1",
+						"sdmmc4_dat2_paa2",
+						"sdmmc4_dat3_paa3",
+						"sdmmc4_dat4_paa4",
+						"sdmmc4_dat5_paa5",
+						"sdmmc4_dat6_paa6",
+						"sdmmc4_dat7_paa7";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <2>;
+				nvidia,tristate = <0>;
+			};
+			dap2_fs_pa2 {
+				nvidia,pins =	"dap2_fs_pa2",
+						"dap2_sclk_pa3",
+						"dap2_din_pa4",
+						"dap2_dout_pa5";
+				nvidia,function = "i2s1";
+				nvidia,pull = <0>;
+				nvidia,tristate = <0>;
+			};
+			sdio3 {
+				nvidia,pins = "drive_sdio3";
+				nvidia,high-speed-mode = <0>;
+				nvidia,schmitt = <0>;
+				nvidia,pull-down-strength = <46>;
+				nvidia,pull-up-strength = <42>;
+				nvidia,slew-rate-rising = <1>;
+				nvidia,slew-rate-falling = <1>;
+			};
+		};
+	};
+
+	serial at 70006000 {
+		status = "okay";
+		clock-frequency = <408000000>;
+	};
+
+	i2c at 7000c000 {
+		status = "okay";
+		clock-frequency = <100000>;
+	};
+
+	i2c at 7000c400 {
+		status = "okay";
+		clock-frequency = <100000>;
+	};
+
+	i2c at 7000c500 {
+		status = "okay";
+		clock-frequency = <100000>;
+	};
+
+	i2c at 7000c700 {
+		status = "okay";
+		clock-frequency = <100000>;
+	};
+
+	i2c at 7000d000 {
+		status = "okay";
+		clock-frequency = <100000>;
+
+		tps62361 {
+			compatible = "ti,tps62361";
+			reg = <0x60>;
+
+			regulator-name = "tps62361-vout";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1500000>;
+			regulator-boot-on;
+			regulator-always-on;
+			ti,vsel0-state-high;
+			ti,vsel1-state-high;
+		};
+
+		pmic: tps65911 at 2d {
+			compatible = "ti,tps65911";
+			reg = <0x2d>;
+
+			interrupts = <0 86 0x4>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+
+			ti,system-power-controller;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			vcc1-supply = <&vdd_5v_in_reg>;
+			vcc2-supply = <&vdd_5v_in_reg>;
+			vcc3-supply = <&vio_reg>;
+			vcc4-supply = <&vdd_5v_in_reg>;
+			vcc5-supply = <&vdd_5v_in_reg>;
+			vcc6-supply = <&vdd2_reg>;
+			vcc7-supply = <&vdd_5v_in_reg>;
+			vccio-supply = <&vdd_5v_in_reg>;
+
+			regulators {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				vdd1_reg: vdd1 {
+					regulator-name = "vddio_ddr_1v2";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+				};
+
+				vdd2_reg: vdd2 {
+					regulator-name = "vdd_1v5_gen";
+					regulator-min-microvolt = <1500000>;
+					regulator-max-microvolt = <1500000>;
+					regulator-always-on;
+				};
+
+				vddctrl_reg: vddctrl {
+					regulator-name = "vdd_cpu,vdd_sys";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+				};
+
+				vio_reg: vio {
+					regulator-name = "vdd_1v8_gen";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				ldo1_reg: ldo1 {
+					regulator-name = "vdd_pexa,vdd_pexb";
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+				};
+
+				ldo2_reg: ldo2 {
+					regulator-name = "vdd_sata,avdd_plle";
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+				};
+
+				/* LDO3 is not connected to anything */
+
+				ldo4_reg: ldo4 {
+					regulator-name = "vdd_rtc";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+				};
+
+				ldo5_reg: ldo5 {
+					regulator-name = "vddio_sdmmc,avdd_vdac";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+
+				ldo6_reg: ldo6 {
+					regulator-name = "avdd_dsi_csi,pwrdet_mipi";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+				};
+
+				ldo7_reg: ldo7 {
+					regulator-name = "vdd_pllm,x,u,a_p_c_s";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+				};
+
+				ldo8_reg: ldo8 {
+					regulator-name = "vdd_ddr_hs";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+				};
+			};
+		};
+	};
+
+	spi at 7000da00 {
+		status = "okay";
+		spi-max-frequency = <25000000>;
+		spi-flash at 1 {
+			compatible = "winbond,w25q32";
+			reg = <1>;
+			spi-max-frequency = <20000000>;
+		};
+	};
+
+	ahub {
+		i2s at 70080400 {
+			status = "okay";
+		};
+	};
+
+	pmc {
+		status = "okay";
+		nvidia,invert-interrupt;
+	};
+
+	sdhci at 78000000 {
+		status = "okay";
+		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
+		wp-gpios = <&gpio 155 0>; /* gpio PT3 */
+		power-gpios = <&gpio 31 0>; /* gpio PD7 */
+		bus-width = <4>;
+	};
+
+	sdhci at 78000600 {
+		status = "okay";
+		bus-width = <8>;
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vdd_5v_in_reg: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "vdd_5v_in";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
+
+		chargepump_5v_reg: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "chargepump_5v";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-boot-on;
+			regulator-always-on;
+			enable-active-high;
+			gpio = <&pmic 0 0>; /* PMIC TPS65911 GPIO0 */
+		};
+
+		ddr_reg: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "vdd_ddr";
+			regulator-min-microvolt = <1500000>;
+			regulator-max-microvolt = <1500000>;
+			regulator-always-on;
+			regulator-boot-on;
+			enable-active-high;
+			gpio = <&pmic 7 0>; /* PMIC TPS65911 GPIO7 */
+			vin-supply = <&vdd_5v_in_reg>;
+		};
+
+		vdd_5v_sata_reg: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "vdd_5v_sata";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+			regulator-boot-on;
+			enable-active-high;
+			gpio = <&gpio 30 0>; /* gpio PD6 */
+			vin-supply = <&vdd_5v_in_reg>;
+		};
+
+		usb1_vbus_reg: regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "usb1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			gpio = <&gpio 68 0>; /* GPIO PI4 */
+			gpio-open-drain;
+			vin-supply = <&vdd_5v_in_reg>;
+		};
+
+		usb3_vbus_reg: regulator at 5 {
+			compatible = "regulator-fixed";
+			reg = <5>;
+			regulator-name = "usb3_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			gpio = <&gpio 63 0>; /* GPIO PH7 */
+			gpio-open-drain;
+			vin-supply = <&vdd_5v_in_reg>;
+		};
+
+		sys_3v3_reg: regulator at 6 {
+			compatible = "regulator-fixed";
+			reg = <6>;
+			regulator-name = "sys_3v3,vdd_3v3_alw";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+			regulator-boot-on;
+			enable-active-high;
+			gpio = <&pmic 6 0>; /* PMIC TPS65911 GPIO6 */
+			vin-supply = <&vdd_5v_in_reg>;
+		};
+
+		sys_3v3_pexs_reg: regulator at 7 {
+			compatible = "regulator-fixed";
+			reg = <7>;
+			regulator-name = "sys_3v3_pexs";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+			regulator-boot-on;
+			enable-active-high;
+			gpio = <&gpio 95 0>; /* gpio PL7 */
+			vin-supply = <&sys_3v3_reg>;
+		};
+	};
+};
-- 
1.7.10.4
