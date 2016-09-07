From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed,  7 Sep 2016 09:02:13 +0800
Subject: [PATCH v1 2/2] ARM: dts: use definition in rockchip pinctrl header to
 describe gpios on Popmetal-RK3288
In-Reply-To: <1473210053-23743-1-git-send-email-andy.yan@rock-chips.com>
References: <1473210053-23743-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1473210133-23792-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use definition in rockchip pinctrl header to describe
gpios, this will make it more clear.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v1:
- use new GPIO pin definition

 arch/arm/boot/dts/rk3288-popmetal.dts | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index f8c6f01..953e2ed 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -72,7 +72,7 @@
 		pinctrl-0 = <&pwrbtn>;
 
 		power {
-			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
 			linux,input-type = <1>;
@@ -83,7 +83,7 @@
 
 	ir: ir-receiver {
 		compatible = "gpio-ir-receiver";
-		gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
+		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&ir_int>;
 	};
@@ -98,7 +98,7 @@
 
 	vcc_sd: sdmmc-regulator {
 		compatible = "regulator-fixed";
-		gpio = <&gpio7 11 GPIO_ACTIVE_LOW>;
+		gpio = <&gpio7 RK_PB3 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdmmc_pwr>;
 		regulator-name = "vcc_sd";
@@ -132,7 +132,7 @@
 	vcc28_dvp: vcc28-dvp-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PC1 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&dvp_pwr>;
 		regulator-name = "vcc28_dvp";
@@ -178,7 +178,7 @@
 	phy-supply = <&vcc_lan>;
 	phy-mode = "rgmii";
 	clock_in_out = "input";
-	snps,reset-gpio = <&gpio4 7 0>;
+	snps,reset-gpio = <&gpio4 RK_PB0 0>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 1000000>;
 	assigned-clocks = <&cru SCLK_MAC>;
@@ -447,43 +447,43 @@
 &pinctrl {
 	ak8963 {
 		comp_int: comp-int {
-			rockchip,pins = <8 1 RK_FUNC_GPIO &pcfg_pull_up>;
+			rockchip,pins = <8 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
 	buttons {
 		pwrbtn: pwrbtn {
-			rockchip,pins = <0 5 RK_FUNC_GPIO &pcfg_pull_up>;
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
 	dvp {
 		dvp_pwr: dvp-pwr {
-			rockchip,pins = <0 17 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <0 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 
 	ir {
 		ir_int: ir-int {
-			rockchip,pins = <0 6 RK_FUNC_GPIO &pcfg_pull_up>;
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
 	mma8452 {
 		gsensor_int: gsensor-int {
-			rockchip,pins = <8 0 RK_FUNC_GPIO &pcfg_pull_up>;
+			rockchip,pins = <8 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
 	pmic {
 		pmic_int: pmic-int {
-			rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO &pcfg_pull_up>;
+			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
 	sdmmc {
 		sdmmc_pwr: sdmmc-pwr {
-			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <7 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 };
-- 
2.7.4
