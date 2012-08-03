From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  3 Aug 2012 12:11:24 -0600
Subject: [PATCH] ARM: dt: tegra: whistler: add regulators
Message-ID: <1344017484-29395-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Whistler uses a Maxim 8907 regulator. Instantiate this.

The voltage settings were derived from the schematic. The only exception
is the BBAT voltage; the schematic says 1.2v, but the HW can't go that
low, so use the HW default of 2.4v instead.

Almost all regulators list all driven supply signal names in their
regulator-names property. The exception is nvvdd_sv3, which is in turn
named 12 more different names on the schematic, so these were omitted
for brevity.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20-whistler.dts |  294 ++++++++++++++++++++++++++++++++
 1 files changed, 294 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index 6916310..7338baa 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -261,6 +261,285 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
+
+		max8907 at 3c {
+			compatible = "maxim,max8907";
+			reg = <0x3c>;
+			interrupts = <0 86 0x4>;
+
+			mbatt-supply = <&usb0_vbus_reg>;
+			in-v1-supply = <&mbatt_reg>;
+			in-v2-supply = <&mbatt_reg>;
+			in-v3-supply = <&mbatt_reg>;
+			in1-supply = <&mbatt_reg>;
+			in2-supply = <&nvvdd_sv3_reg>;
+			in3-supply = <&mbatt_reg>;
+			in4-supply = <&mbatt_reg>;
+			in5-supply = <&mbatt_reg>;
+			in6-supply = <&mbatt_reg>;
+			in7-supply = <&mbatt_reg>;
+			in8-supply = <&mbatt_reg>;
+			in9-supply = <&mbatt_reg>;
+			in10-supply = <&mbatt_reg>;
+			in11-supply = <&mbatt_reg>;
+			in12-supply = <&mbatt_reg>;
+			in13-supply = <&mbatt_reg>;
+			in14-supply = <&mbatt_reg>;
+			in15-supply = <&mbatt_reg>;
+			in16-supply = <&mbatt_reg>;
+			in17-supply = <&nvvdd_sv3_reg>;
+			in18-supply = <&nvvdd_sv3_reg>;
+			in19-supply = <&mbatt_reg>;
+			in20-supply = <&mbatt_reg>;
+			lxw-supply = <&mbatt_reg>;
+
+			regulators {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mbatt_reg: regulator at 0 {
+					reg = <0>;
+					regulator-compatible = "mbatt";
+					regulator-name = "vbat_pmu";
+					regulator-always-on;
+				};
+
+				regulator at 1 {
+					reg = <1>;
+					regulator-compatible = "sd1";
+					regulator-name = "nvvdd_sv1,vdd_cpu_pmu";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+				};
+
+				regulator at 2 {
+					reg = <2>;
+					regulator-compatible = "sd2";
+					regulator-name = "nvvdd_sv2,vdd_core";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+				};
+
+				nvvdd_sv3_reg: regulator at 3 {
+					reg = <3>;
+					regulator-compatible = "sd3";
+					regulator-name = "nvvdd_sv3";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				regulator at 4 {
+					reg = <4>;
+					regulator-compatible = "ldo1";
+					regulator-name = "nvvdd_ldo1,vddio_rx_ddr,vcore_acc";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+
+				regulator at 5 {
+					reg = <5>;
+					regulator-compatible = "ldo2";
+					regulator-name = "nvvdd_ldo2,avdd_pll*";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1100000>;
+					regulator-always-on;
+				};
+
+				regulator at 6 {
+					reg = <6>;
+					regulator-compatible = "ldo3";
+					regulator-name = "nvvdd_ldo3,vcom_1v8b";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				regulator at 7 {
+					reg = <7>;
+					regulator-compatible = "ldo4";
+					regulator-name = "nvvdd_ldo4,avdd_usb*";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+
+				regulator at 8 {
+					reg = <8>;
+					regulator-compatible = "ldo5";
+					regulator-name = "nvvdd_ldo5,vcore_mmc,avdd_lcd1,vddio_1wire";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					regulator-always-on;
+				};
+
+				regulator at 9 {
+					reg = <9>;
+					regulator-compatible = "ldo6";
+					regulator-name = "nvvdd_ldo6,avdd_hdmi_pll";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
+				regulator at 10 {
+					reg = <10>;
+					regulator-compatible = "ldo7";
+					regulator-name = "nvvdd_ldo7,avddio_audio";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					regulator-always-on;
+				};
+
+				regulator at 11 {
+					reg = <11>;
+					regulator-compatible = "ldo8";
+					regulator-name = "nvvdd_ldo8,vcom_3v0,vcore_cmps";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+				};
+
+				regulator at 12 {
+					reg = <12>;
+					regulator-compatible = "ldo9";
+					regulator-name = "nvvdd_ldo9,avdd_cam*";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+				};
+
+				regulator at 13 {
+					reg = <13>;
+					regulator-compatible = "ldo10";
+					regulator-name = "nvvdd_ldo10,avdd_usb_ic_3v0";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-always-on;
+				};
+
+				regulator at 14 {
+					reg = <14>;
+					regulator-compatible = "ldo11";
+					regulator-name = "nvvdd_ldo11,vddio_pex_clk,vcom_33,avdd_hdmi";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				regulator at 15 {
+					reg = <15>;
+					regulator-compatible = "ldo12";
+					regulator-name = "nvvdd_ldo12,vddio_sdio";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					regulator-always-on;
+				};
+
+				regulator at 16 {
+					reg = <16>;
+					regulator-compatible = "ldo13";
+					regulator-name = "nvvdd_ldo13,vcore_phtn,vdd_af";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+				};
+
+				regulator at 17 {
+					reg = <17>;
+					regulator-compatible = "ldo14";
+					regulator-name = "nvvdd_ldo14,avdd_vdac";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+				};
+
+				regulator at 18 {
+					reg = <18>;
+					regulator-compatible = "ldo15";
+					regulator-name = "nvvdd_ldo15,vcore_temp,vddio_hdcp";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				regulator at 19 {
+					reg = <19>;
+					regulator-compatible = "ldo16";
+					regulator-name = "nvvdd_ldo16,vdd_dbrtr";
+					regulator-min-microvolt = <1300000>;
+					regulator-max-microvolt = <1300000>;
+				};
+
+				regulator at 20 {
+					reg = <20>;
+					regulator-compatible = "ldo17";
+					regulator-name = "nvvdd_ldo17,vddio_mipi";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+				};
+
+				regulator at 21 {
+					reg = <21>;
+					regulator-compatible = "ldo18";
+					regulator-name = "nvvdd_ldo18,vddio_vi,vcore_cam*";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
+				regulator at 22 {
+					reg = <22>;
+					regulator-compatible = "ldo19";
+					regulator-name = "nvvdd_ldo19,avdd_lcd2,vddio_lx";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+				};
+
+				regulator at 23 {
+					reg = <23>;
+					regulator-compatible = "ldo20";
+					regulator-name = "nvvdd_ldo20,vddio_ddr_1v2,vddio_hsic,vcom_1v2";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+				};
+
+				regulator at 24 {
+					reg = <24>;
+					regulator-compatible = "out5v";
+					regulator-name = "usb0_vbus_reg";
+				};
+
+				regulator at 25 {
+					reg = <25>;
+					regulator-compatible = "out33v";
+					regulator-name = "pmu_out3v3";
+				};
+
+				regulator at 26 {
+					reg = <26>;
+					regulator-compatible = "bbat";
+					regulator-name = "pmu_bbat";
+					regulator-min-microvolt = <2400000>;
+					regulator-max-microvolt = <2400000>;
+					regulator-always-on;
+				};
+
+				regulator at 27 {
+					reg = <27>;
+					regulator-compatible = "sdby";
+					regulator-name = "vdd_aon";
+					regulator-always-on;
+				};
+
+				regulator at 28 {
+					reg = <28>;
+					regulator-compatible = "vrtc";
+					regulator-name = "vrtc,pmu_vccadc";
+					regulator-always-on;
+				};
+			};
+		};
+	};
+
+	pmc {
+		nvidia,invert-interrupt;
 	};
 
 	usb at c5000000 {
@@ -284,6 +563,21 @@
 		bus-width = <8>;
 	};
 
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb0_vbus_reg: regulator {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "usb0_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
+	};
+
 	sound {
 		compatible = "nvidia,tegra-audio-wm8753-whistler",
 			     "nvidia,tegra-audio-wm8753";
-- 
1.7.0.4
