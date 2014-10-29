From: zyw@rock-chips.com (Chris Zhong)
Date: Wed, 29 Oct 2014 19:52:05 +0800
Subject: [PATCH v6 7/7] ARM: dts: add suspend voltage setting for RK808
In-Reply-To: <1414583525-17395-1-git-send-email-zyw@rock-chips.com>
References: <1414583525-17395-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1414583525-17395-8-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

global_pwroff would be pull to high when RK3288 entering suspend,
this pin is a sleep signal for RK808, so RK808 could goto sleep
mode, and some regulators would be disable.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>

---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rk3288-evb-rk808.dts |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-evb-rk808.dts b/arch/arm/boot/dts/rk3288-evb-rk808.dts
index ff522f8..319fcb6 100644
--- a/arch/arm/boot/dts/rk3288-evb-rk808.dts
+++ b/arch/arm/boot/dts/rk3288-evb-rk808.dts
@@ -27,7 +27,7 @@
 		interrupt-parent = <&gpio0>;
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int>;
+		pinctrl-0 = <&pmic_int &global_pwroff>;
 		rockchip,system-power-controller;
 		wakeup-source;
 		#clock-cells = <1>;
@@ -46,6 +46,7 @@
 				regulator-min-microvolt = <750000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-name = "vdd_arm";
+				regulator-suspend-mem-disabled;
 			};
 
 			vdd_gpu: DCDC_REG2 {
@@ -54,12 +55,14 @@
 				regulator-min-microvolt = <850000>;
 				regulator-max-microvolt = <1250000>;
 				regulator-name = "vdd_gpu";
+				regulator-suspend-mem-disabled;
 			};
 
 			vcc_ddr: DCDC_REG3 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-name = "vcc_ddr";
+				regulator-suspend-mem-enabled;
 			};
 
 			vcc_io: DCDC_REG4 {
@@ -68,6 +71,7 @@
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vcc_io";
+				regulator-suspend-mem-microvolt = <3300000>;
 			};
 
 			vccio_pmu: LDO_REG1 {
@@ -76,6 +80,7 @@
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vccio_pmu";
+				regulator-suspend-mem-microvolt = <3300000>;
 			};
 
 			vcc_tp: LDO_REG2 {
@@ -84,6 +89,7 @@
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vcc_tp";
+				regulator-suspend-mem-disabled;
 			};
 
 			vdd_10: LDO_REG3 {
@@ -92,6 +98,7 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-name = "vdd_10";
+				regulator-suspend-mem-microvolt = <1000000>;
 			};
 
 			vcc18_lcd: LDO_REG4 {
@@ -100,6 +107,7 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-name = "vcc18_lcd";
+				regulator-suspend-mem-disabled;
 			};
 
 			vccio_sd: LDO_REG5 {
@@ -108,6 +116,7 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vccio_sd";
+				regulator-suspend-mem-disabled;
 			};
 
 			vdd10_lcd: LDO_REG6 {
@@ -116,6 +125,7 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-name = "vdd10_lcd";
+				regulator-suspend-mem-disabled;
 			};
 
 			vcc_18: LDO_REG7 {
@@ -124,6 +134,7 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-name = "vcc_18";
+				regulator-suspend-mem-microvolt = <1800000>;
 			};
 
 			vcca_codec: LDO_REG8 {
@@ -132,18 +143,21 @@
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vcca_codec";
+				regulator-suspend-mem-disabled;
 			};
 
 			vcc_wl: SWITCH_REG1 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-name = "vcc_wl";
+				regulator-suspend-mem-enabled;
 			};
 
 			vcc_lcd: SWITCH_REG2 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-name = "vcc_lcd";
+				regulator-suspend-mem-disabled;
 			};
 		};
 	};
-- 
1.7.9.5
