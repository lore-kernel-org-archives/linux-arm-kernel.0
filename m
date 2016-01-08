From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 8 Jan 2016 10:08:58 +0800
Subject: [PATCH 2/2] regulator: add documentation for ACT8945A's regulator DT
 bindings
In-Reply-To: <1452218938-10621-1-git-send-email-wenyou.yang@atmel.com>
References: <1452218938-10621-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1452218938-10621-3-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for the DT bindings of the regulator
subdevice of ACT8945A MFD.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 .../bindings/regulator/act8945a-regulator.txt      |   78 ++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/act8945a-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
new file mode 100644
index 0000000..f67ff86
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
@@ -0,0 +1,78 @@
+Device-Tree bindings for regulators of Active-semi ACT8945A Multi-Function Device
+
+Required properties:
+ - compatible: "active-semi,act8945a-regulator"
+
+Optional properties:
+- active-semi,vsel-high: Indicates if the VSEL pin is set to logic-high.
+  If this property is missing, assume the VSEL pin is set to logic-low.
+
+Optional input supply properties:
+  - vp1-supply: The input supply for DCDC_REG1
+  - vp2-supply: The input supply for DCDC_REG2
+  - vp3-supply: The input supply for DCDC_REG3
+  - inl45-supply: The input supply for LDO_REG1 and LDO_REG2
+  - inl67-supply: The input supply for LDO_REG3 and LDO_REG4
+
+Any standard regulator properties can be used to configure the single regulator.
+
+The valid names for regulators are:
+	DCDC_REG1, DCDC_REG2, DCDC_REG3, LDO_REG1, LDO_REG2, LDO_REG3, LDO_REG4.
+
+Example:
+
+	pmic {
+		compatible = "active-semi,act8945a-regulator";
+		active-semi,vsel-high;
+
+		regulators {
+			vdd_1v35_reg: DCDC_REG1 {
+				regulator-name = "VDD_1V35";
+				regulator-min-microvolt = <1350000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
+			};
+
+			vdd_1v2_reg: DCDC_REG2 {
+				regulator-name = "VDD_1V2";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-always-on;
+			};
+
+			vdd_3v3_reg: DCDC_REG3 {
+				regulator-name = "VDD_3V3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd_fuse_reg: LDO_REG1 {
+				regulator-name = "VDD_FUSE";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-always-on;
+			};
+
+			vdd_3v3_lp_reg: LDO_REG2 {
+				regulator-name = "VDD_3V3_LP";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd_led_reg: LDO_REG3 {
+				regulator-name = "VDD_LED";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd_sdhc_1v8_reg: LDO_REG4 {
+				regulator-name = "VDD_SDHC_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+		};
+	};
-- 
1.7.9.5
