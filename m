From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 17 Dec 2013 13:36:36 +0800
Subject: [PATCH 2/3 v2] regulator: act8865: add device tree binding doc
In-Reply-To: <1387258597-21866-1-git-send-email-wenyou.yang@atmel.com>
References: <1387258597-21866-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1387258597-21866-3-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 .../bindings/regulator/act8865-regulator.txt       |   56 ++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/act8865-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
new file mode 100644
index 0000000..04fc911
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
@@ -0,0 +1,56 @@
+ACT8865 regulator
+-------------------
+
+Required properties:
+- compatible: "active-semi,act8865"
+- reg: I2C slave address
+
+Example:
+--------
+
+	i2c1: i2c at f0018000 {
+		status = "okay";
+
+		pmic: act8865 at 5b {
+			compatible = "active-semi,act8865";
+			reg = <0x5b>;
+
+			regulators {
+				vcc_1v8_reg: DCDC_REG1 {
+					regulator-name = "DCDC_REG1";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				vcc_1v2_reg: DCDC_REG2 {
+					regulator-name = "DCDC_REG2";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1300000>;
+					regulator-suspend-mem-microvolt = <1150000>;
+					regulator-suspend-standby-microvolt = <1150000>;
+					regulator-always-on;
+				};
+
+				vcc_3v3_reg: DCDC_REG3 {
+					regulator-name = "DCDC_REG3";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+
+				vddfuse_reg: LDO_REG4 {
+					regulator-name = "LDO_REG4";
+					regulator-min-microvolt = <2500000>;
+					regulator-max-microvolt = <2500000>;
+				};
+
+				vddana_reg: LDO_REG5 {
+					regulator-name = "LDO_REG5";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+			};
+		};
+	};
-- 
1.7.9.5
