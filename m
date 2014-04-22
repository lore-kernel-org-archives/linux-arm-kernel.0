From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 22 Apr 2014 11:28:02 +0800
Subject: [PATCH v2.0] ARM: dts: at91-sama5d3_xplained: add the regulator
 device node
Message-ID: <1398137282-4864-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
Hi Nicolas,

This patch is based on the branch: at91-3.16-dt
	git://github.com/at91linux/linux-at91.git

Best Regards,
Wenyou Yang

Changelog:
v2.0
 1./ Remove vddana_reg's property: regulator-always-on.

 arch/arm/boot/dts/at91-sama5d3_xplained.dts |   41 +++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index ce13755..8361617 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -48,6 +48,47 @@
 
 			i2c1: i2c at f0018000 {
 				status = "okay";
+
+				pmic: act8865 at 5b {
+					compatible = "active-semi,act8865";
+					reg = <0x5b>;
+					status = "okay";
+
+					regulators {
+						vcc_1v8_reg: DCDC_REG1 {
+							regulator-name = "VCC_1V8";
+							regulator-min-microvolt = <1800000>;
+							regulator-max-microvolt = <1800000>;
+							regulator-always-on;
+						};
+
+						vcc_1v2_reg: DCDC_REG2 {
+							regulator-name = "VCC_1V2";
+							regulator-min-microvolt = <1200000>;
+							regulator-max-microvolt = <1200000>;
+							regulator-always-on;
+						};
+
+						vcc_3v3_reg: DCDC_REG3 {
+							regulator-name = "VCC_3V3";
+							regulator-min-microvolt = <3300000>;
+							regulator-max-microvolt = <3300000>;
+							regulator-always-on;
+						};
+
+						vddfuse_reg: LDO_REG1 {
+							regulator-name = "FUSE_2V5";
+							regulator-min-microvolt = <2500000>;
+							regulator-max-microvolt = <2500000>;
+						};
+
+						vddana_reg: LDO_REG2 {
+							regulator-name = "VDDANA";
+							regulator-min-microvolt = <3300000>;
+							regulator-max-microvolt = <3300000>;
+						};
+					};
+				};
 			};
 
 			macb0: ethernet at f0028000 {
-- 
1.7.9.5
