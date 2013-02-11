From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Sun, 10 Feb 2013 16:36:24 -0800
Subject: [PATCH V2] ARM: dts: exynos5250-arndale: Add PMIC node entry
Message-ID: <1360542984-31552-1-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added S5M8767 PMIC DT nodes for Arndale board. Only the used
LDO's/BUCK are defined here. Also the nodes describe the default/reset
state LDO's and no power mangement tuning is implemented. The usage
desription can be found in s5m8767 device tree binding documentation.

Cc: Tushar Behera <tushar.behera@linaro.org>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
This patch is based on Samsung kernel maintainer's for-next tree.
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-next

The s5m8767 DT support is already accepted by regulator's maintainer and is
present in the tree,
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Changes since V1:
* Removed un-necessary status field settings.
* Added entries for LDO's 22,23,25,26 and BUCK9  
 
 arch/arm/boot/dts/exynos5250-arndale.dts |  257 +++++++++++++++++++++++++++++-
 1 files changed, 256 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 63572f9..f50f09c 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -25,7 +25,262 @@
 	};
 
 	i2c at 12C60000 {
-		status = "disabled";
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <20000>;
+		samsung,i2c-slave-addr = <0x66>;
+		gpios = <&gpb3 0 2 3 0>,
+			<&gpb3 1 2 3 0>;
+
+		s5m8767_pmic at 66 {
+			compatible = "samsung,s5m8767-pmic";
+			reg = <0x66>;
+
+			s5m8767,pmic-buck2-dvs-voltage = <1300000>;
+			s5m8767,pmic-buck3-dvs-voltage = <1100000>;
+			s5m8767,pmic-buck4-dvs-voltage = <1200000>;
+			s5m8767,pmic-buck-dvs-gpios = <&gpd1 0 1 0 0>,
+							<&gpd1 1 1 0 0>,
+							<&gpd1 2 1 0 0>;
+			s5m8767,pmic-buck-ds-gpios = <&gpx2 3 1 0 0>,
+							<&gpx2 4 1 0 0>,
+							<&gpx2 5 1 0 0>;
+			regulators {
+				ldo1_reg: LDO1 {
+					regulator-name = "VDD_ALIVE_1.0V";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1100000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				ldo2_reg: LDO2 {
+					regulator-name = "VDD_28IO_DP_1.35V";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				ldo3_reg: LDO3 {
+					regulator-name = "VDD_COMMON1_1.8V";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				ldo4_reg: LDO4 {
+					regulator-name = "VDD_IOPERI_1.8V";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					op_mode = <1>;
+				};
+
+				ldo5_reg: LDO5 {
+					regulator-name = "VDD_EXT_1.8V";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				ldo6_reg: LDO6 {
+					regulator-name = "VDD_MPLL_1.1V";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1100000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				ldo7_reg: LDO7 {
+					regulator-name = "VDD_XPLL_1.1V";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1100000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				ldo8_reg: LDO8 {
+					regulator-name = "VDD_COMMON2_1.0V";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				ldo9_reg: LDO9 {
+					regulator-name = "VDD_33ON_3.0V";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+					op_mode = <1>;
+				};
+
+				ldo10_reg: LDO10 {
+					regulator-name = "VDD_COMMON3_1.8V";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				ldo11_reg: LDO11 {
+					regulator-name = "VDD_ABB2_1.8V";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				ldo12_reg: LDO12 {
+					regulator-name = "VDD_USB_3.0V";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				ldo13_reg: LDO13 {
+					regulator-name = "VDDQ_C2C_W_1.8V";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				ldo14_reg: LDO14 {
+					regulator-name = "VDD18_ABB0_3_1.8V";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				ldo15_reg: LDO15 {
+					regulator-name = "VDD10_COMMON4_1.0V";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				ldo16_reg: LDO16 {
+					regulator-name = "VDD18_HSIC_1.8V";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				ldo17_reg: LDO17 {
+					regulator-name = "VDDQ_MMC2_3_2.8V";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				ldo18_reg: LDO18 {
+					regulator-name = "VDD_33ON_2.8V";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					op_mode = <1>;
+				};
+
+				ldo22_reg: LDO22 {
+					regulator-name = "EXT_33_OFF";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					op_mode = <1>;
+				};
+
+				ldo23_reg: LDO23 {
+					regulator-name = "EXT_28_OFF";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					op_mode = <1>;
+				};
+
+				ldo25_reg: LDO25 {
+					regulator-name = "PVDD_LDO25";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					op_mode = <1>;
+				};
+
+				ldo26_reg: LDO26 {
+					regulator-name = "EXT_18_OFF";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					op_mode = <1>;
+				};
+
+				buck1_reg: BUCK1 {
+					regulator-name = "vdd_mif";
+					regulator-min-microvolt = <950000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				buck2_reg: BUCK2 {
+					regulator-name = "vdd_arm";
+					regulator-min-microvolt = <925000>;
+					regulator-max-microvolt = <1300000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				buck3_reg: BUCK3 {
+					regulator-name = "vdd_int";
+					regulator-min-microvolt = <900000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				buck4_reg: BUCK4 {
+					regulator-name = "vdd_g3d";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				buck5_reg: BUCK5 {
+					regulator-name = "VDD_MEM_1.35V";
+					regulator-min-microvolt = <750000>;
+					regulator-max-microvolt = <1355000>;
+					regulator-always-on;
+					regulator-boot-on;
+					op_mode = <1>;
+				};
+
+				buck9_reg: BUCK9 {
+					regulator-name = "VDD_33_OFF_EXT1";
+					regulator-min-microvolt = <750000>;
+					regulator-max-microvolt = <3000000>;
+					op_mode = <1>;
+				};
+			};
+		};
 	};
 
 	i2c at 12C70000 {
-- 
1.7.5.4
