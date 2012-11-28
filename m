From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed, 28 Nov 2012 16:21:40 +0530
Subject: [PATCH] ARM: DTS: CROS5250: Add max77686 device tree support
Message-ID: <1354099900-24779-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos5250 based chromebooks have a max77686 pmic on i2c channel 0.
Add support for the pmic in the common cros5250 dts file.
Tested after enabling cpufreq support for exynos5250 SoC and varying the
arm frequency/voltage using the userspace governer.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/boot/dts/cros5250-common.dtsi |  137 ++++++++++++++++++++++++++++++++
 1 files changed, 137 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/cros5250-common.dtsi b/arch/arm/boot/dts/cros5250-common.dtsi
index fddd174..7849824 100644
--- a/arch/arm/boot/dts/cros5250-common.dtsi
+++ b/arch/arm/boot/dts/cros5250-common.dtsi
@@ -24,6 +24,143 @@
 		samsung,i2c-max-bus-freq = <378000>;
 		gpios = <&gpb3 0 2 3 0>,
 			<&gpb3 1 2 3 0>;
+
+		max77686 at 09 {
+			compatible = "maxim,max77686";
+			reg = <0x09>;
+
+			voltage-regulators {
+				ldo1_reg: LDO1 {
+					regulator-name = "vdd_alive";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+				};
+
+				ldo2_reg: LDO2 {
+					regulator-name = "vdd_micom";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				ldo3_reg: LDO3 {
+					regulator-name = "vdd_rtc";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				ldo7_reg: LDO7 {
+					regulator-name = "vdd10_xpll";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1100000>;
+					regulator-always-on;
+				};
+
+				ldo8_reg: LDO8 {
+					regulator-name = "vdd10_mipihdmi";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+				};
+
+				ldo10_reg: LDO10 {
+					regulator-name = "vdd18_mipihdmi";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				ldo12_reg: LDO12 {
+					regulator-name = "vdd33_usb3";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-always-on;
+				};
+
+				ldo14_reg: LDO14 {
+					regulator-name = "vdd18_abb0";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				ldo15_reg: LDO15 {
+					regulator-name = "vdd10_hsic";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+				};
+
+				ldo16_reg: LDO16 {
+					regulator-name = "vdd18_hsic";
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
+					regulator-name = "vdd18_adc";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				buck6_reg: BUCK6 {
+					regulator-name = "vdd_bat1";
+					regulator-min-microvolt = <1350000>;
+					regulator-max-microvolt = <1350000>;
+					regulator-always-on;
+				};
+
+				buck7_reg: BUCK7 {
+					regulator-name = "vdd_bat2";
+					regulator-min-microvolt = <2000000>;
+					regulator-max-microvolt = <2000000>;
+					regulator-always-on;
+				};
+
+				buck8_reg: BUCK8 {
+					regulator-name = "vdd_emmc";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+					regulator-always-on;
+				};
+			};
+		};
 	};
 
 	i2c at 12C70000 {
-- 
1.7.8.6
