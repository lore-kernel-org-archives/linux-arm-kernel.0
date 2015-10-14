From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 14 Oct 2015 10:59:56 +0800
Subject: [PATCH] ARM: dts: at91: sama5d2_xplained: add regulator nodes
Message-ID: <1444791596-8858-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add regulator nodes of PMIC ACT8945A chip on the board.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 arch/arm/boot/dts/at91-sama5d2_xplained.dts |   57 +++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index dc23979..e07c2b2 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -122,6 +122,63 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_i2c0_default>;
 				status = "okay";
+
+				pmic: act8865 at 5b {
+					compatible = "active-semi,act8865";
+					reg = <0x5b>;
+					active-semi,vsel-high;
+					status = "okay";
+
+					regulators {
+						vdd_1v35_reg: DCDC_REG1 {
+							regulator-name = "VDD_1V35";
+							regulator-min-microvolt = <1350000>;
+							regulator-max-microvolt = <1350000>;
+							regulator-always-on;
+						};
+
+						vdd_1v2_reg: DCDC_REG2 {
+							regulator-name = "VDD_1V2";
+							regulator-min-microvolt = <1100000>;
+							regulator-max-microvolt = <1300000>;
+							regulator-always-on;
+						};
+
+						vdd_3v3_reg: DCDC_REG3 {
+							regulator-name = "VDD_3V3";
+							regulator-min-microvolt = <3300000>;
+							regulator-max-microvolt = <3300000>;
+							regulator-always-on;
+						};
+
+						vdd_fuse_reg: LDO_REG1 {
+							regulator-name = "VDD_FUSE";
+							regulator-min-microvolt = <2500000>;
+							regulator-max-microvolt = <2500000>;
+							regulator-always-on;
+						};
+
+						vdd_3v3_lp_reg: LDO_REG2 {
+							regulator-name = "VDD_3V3_LP";
+							regulator-min-microvolt = <3300000>;
+							regulator-max-microvolt = <3300000>;
+							regulator-always-on;
+						};
+
+						vdd_led_reg: LDO_REG3 {
+							regulator-name = "VDD_LED";
+							regulator-min-microvolt = <3300000>;
+							regulator-max-microvolt = <3300000>;
+							regulator-always-on;
+						};
+
+						vdd_sdhc_1v8_reg: LDO_REG4 {
+							regulator-name = "VDD_SDHC_1V8";
+							regulator-min-microvolt = <1800000>;
+							regulator-max-microvolt = <1800000>;
+						};
+					};
+				};
 			};
 
 			uart3: serial at fc008000 {
-- 
1.7.9.5
