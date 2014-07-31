From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 01 Aug 2014 03:27:09 +0900
Subject: [GIT PULL] Samsung 2nd DT updates for v3.17
In-Reply-To: <53DA88D6.9010700@samsung.com>
References: <53DA88D6.9010700@samsung.com>
Message-ID: <53DA8A7D.9080100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/14 03:20, Kukjin Kim wrote:

Hi Arnd and Olof,

Probably you may see merge conflict when you merge this branch into 
arm-soc because of cros-ec-keyboard related patches from Stephen.

Here is my preferred resolution.

diff --cc arch/arm/boot/dts/exynos5250-snow.dts
index c682c88,7c4bdaa..f2b8c41
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@@ -344,4 -433,167 +344,169 @@@
   	};
   };

+ &i2c_0 {
+ 	max77686 at 09 {
+ 		compatible = "maxim,max77686";
+ 		interrupt-parent = <&gpx3>;
+ 		interrupts = <2 0>;
+ 		pinctrl-names = "default";
+ 		pinctrl-0 = <&max77686_irq>;
+ 		wakeup-source;
+ 		reg = <0x09>;
+ 		#clock-cells = <1>;
+
+ 		voltage-regulators {
+ 			ldo1_reg: LDO1 {
+ 				regulator-name = "P1.0V_LDO_OUT1";
+ 				regulator-min-microvolt = <1000000>;
+ 				regulator-max-microvolt = <1000000>;
+ 				regulator-always-on;
+ 			};
+
+ 			ldo2_reg: LDO2 {
+ 				regulator-name = "P1.8V_LDO_OUT2";
+ 				regulator-min-microvolt = <1800000>;
+ 				regulator-max-microvolt = <1800000>;
+ 				regulator-always-on;
+ 			};
+
+ 			ldo3_reg: LDO3 {
+ 				regulator-name = "P1.8V_LDO_OUT3";
+ 				regulator-min-microvolt = <1800000>;
+ 				regulator-max-microvolt = <1800000>;
+ 				regulator-always-on;
+ 			};
+
+ 			ldo7_reg: LDO7 {
+ 				regulator-name = "P1.1V_LDO_OUT7";
+ 				regulator-min-microvolt = <1100000>;
+ 				regulator-max-microvolt = <1100000>;
+ 				regulator-always-on;
+ 			};
+
+ 			ldo8_reg: LDO8 {
+ 				regulator-name = "P1.0V_LDO_OUT8";
+ 				regulator-min-microvolt = <1000000>;
+ 				regulator-max-microvolt = <1000000>;
+ 				regulator-always-on;
+ 			};
+
+ 			ldo10_reg: LDO10 {
+ 				regulator-name = "P1.8V_LDO_OUT10";
+ 				regulator-min-microvolt = <1800000>;
+ 				regulator-max-microvolt = <1800000>;
+ 				regulator-always-on;
+ 			};
+
+ 			ldo12_reg: LDO12 {
+ 				regulator-name = "P3.0V_LDO_OUT12";
+ 				regulator-min-microvolt = <3000000>;
+ 				regulator-max-microvolt = <3000000>;
+ 				regulator-always-on;
+ 			};
+
+ 			ldo14_reg: LDO14 {
+ 				regulator-name = "P1.8V_LDO_OUT14";
+ 				regulator-min-microvolt = <1800000>;
+ 				regulator-max-microvolt = <1800000>;
+ 				regulator-always-on;
+ 			};
+
+ 			ldo15_reg: LDO15 {
+ 				regulator-name = "P1.0V_LDO_OUT15";
+ 				regulator-min-microvolt = <1000000>;
+ 				regulator-max-microvolt = <1000000>;
+ 				regulator-always-on;
+ 			};
+
+ 			ldo16_reg: LDO16 {
+ 				regulator-name = "P1.8V_LDO_OUT16";
+ 				regulator-min-microvolt = <1800000>;
+ 				regulator-max-microvolt = <1800000>;
+ 				regulator-always-on;
+ 			};
+
+ 			buck1_reg: BUCK1 {
+ 				regulator-name = "vdd_mif";
+ 				regulator-min-microvolt = <950000>;
+ 				regulator-max-microvolt = <1300000>;
+ 				regulator-always-on;
+ 				regulator-boot-on;
+ 			};
+
+ 			buck2_reg: BUCK2 {
+ 				regulator-name = "vdd_arm";
+ 				regulator-min-microvolt = <850000>;
+ 				regulator-max-microvolt = <1350000>;
+ 				regulator-always-on;
+ 				regulator-boot-on;
+ 			};
+
+ 			buck3_reg: BUCK3 {
+ 				regulator-name = "vdd_int";
+ 				regulator-min-microvolt = <900000>;
+ 				regulator-max-microvolt = <1200000>;
+ 				regulator-always-on;
+ 				regulator-boot-on;
+ 			};
+
+ 			buck4_reg: BUCK4 {
+ 				regulator-name = "vdd_g3d";
+ 				regulator-min-microvolt = <850000>;
+ 				regulator-max-microvolt = <1300000>;
+ 				regulator-always-on;
+ 				regulator-boot-on;
+ 			};
+
+ 			buck5_reg: BUCK5 {
+ 				regulator-name = "P1.8V_BUCK_OUT5";
+ 				regulator-min-microvolt = <1800000>;
+ 				regulator-max-microvolt = <1800000>;
+ 				regulator-always-on;
+ 				regulator-boot-on;
+ 			};
+
+ 			buck6_reg: BUCK6 {
+ 				regulator-name = "P1.35V_BUCK_OUT6";
+ 				regulator-min-microvolt = <1350000>;
+ 				regulator-max-microvolt = <1350000>;
+ 				regulator-always-on;
+ 			};
+
+ 			buck7_reg: BUCK7 {
+ 				regulator-name = "P2.0V_BUCK_OUT7";
+ 				regulator-min-microvolt = <2000000>;
+ 				regulator-max-microvolt = <2000000>;
+ 				regulator-always-on;
+ 			};
+
+ 			buck8_reg: BUCK8 {
+ 				regulator-name = "P2.85V_BUCK_OUT8";
+ 				regulator-min-microvolt = <2850000>;
+ 				regulator-max-microvolt = <2850000>;
+ 				regulator-always-on;
+ 			};
+ 		};
+ 	};
+ };
+
+ &i2c_1 {
+ 	trackpad {
+ 		reg = <0x67>;
+ 		compatible = "cypress,cyapa";
+ 		interrupts = <2 0>;
+ 		interrupt-parent = <&gpx1>;
+ 		wakeup-source;
+ 	};
+ };
+
+ &pinctrl_0 {
+ 	max77686_irq: max77686-irq {
+ 		samsung,pins = "gpx3-2";
+ 		samsung,pin-function = <0>;
+ 		samsung,pin-pud = <0>;
+ 		samsung,pin-drv = <0>;
+ 	};
+ };
++
  +#include "cros-ec-keyboard.dtsi"


Thanks,
Kukjin


> The following changes since commit
> 6da287ad0266cca1fa8f88fb8b1c466e8164671f:
>
> Merge branch 'v3.17-next/power-exynos' into v3.17-next/dt-samsung-2
> (2014-07-29 06:09:42 +0900)
>
> are available in the git repository at:
>
>
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-dt-2
>
> for you to fetch changes up to a9408a6bba0de106d702fe5fa36fdc545116e9ab:
>
> ARM: dts: Add missing pinctrl for uart0/1 for exynos3250 (2014-07-30
> 07:57:32 +0900)
>
> ----------------------------------------------------------------
> Samsung DT 2nd updates for v3.17
>
> This is based on tags/exynos-power because this DT changes
> are depending PMU cleanup.
>
> Fixes boot for exynos5260 and exynos5410,
> - Since exynos cannot boot without obtaining PMU address via
> DT from now on, add PMU node for exynos5260 and exynos5410
>
> For preparing exynos5250-spring,
> - move max77686 and cypress,cyapa trackpad from exynos5250-
> cros-common to exynos5250-snow DT file
> (Note exynos5250-spring is not included in this branch yet)
>
> For exynos3250,
> - add TMU node and remove duplicated interrupt-parent
> - add missing pinctrl property for uart0 and uart1
>
> For exynos5250-smdk5250 board
> - add max77686 pmic interrupt property which is connected to
> gpx3
>
> ----------------------------------------------------------------
> Andreas Faerber (5):
> ARM: dts: Document exynos5410 PMU
> ARM: dts: Add PMU to exynos5410
> ARM: EXYNOS: Add support for Exynos5410 PMU
> ARM: dts: max77686 is exynos5250-snow only
> ARM: dts: cypress,cyapa trackpad is exynos5250-Snow only
>
> Chanwoo Choi (3):
> ARM: dts: Add TMU dt node to monitor the temperature for exynos3250
> ARM: dts: Remove duplicate 'interrput-parent' property for exynos3250
> ARM: dts: Add missing pinctrl for uart0/1 for exynos3250
>
> Thomas Abraham (1):
> ARM: dts: Specify MAX77686 pmic interrupt for exynos5250-smdk5250
>
> Vikas Sajjan (2):
> ARM: dts: Add PMU DT node for exynos5260 SoC
> ARM: EXYNOS: Add exynos5260 PMU compatible string to DT match table
>
> .../devicetree/bindings/arm/samsung/pmu.txt | 2 +
> arch/arm/boot/dts/exynos3250.dtsi | 15 +-
> arch/arm/boot/dts/exynos5250-cros-common.dtsi | 159 --------------------
> arch/arm/boot/dts/exynos5250-smdk5250.dts | 2 +
> arch/arm/boot/dts/exynos5250-snow.dts | 165 +++++++++++++++++++++
> arch/arm/boot/dts/exynos5260.dtsi | 5 +
> arch/arm/boot/dts/exynos5410.dtsi | 5 +
> arch/arm/mach-exynos/exynos.c | 2 +
> 8 files changed, 194 insertions(+), 161 deletions(-)
