From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 5 Feb 2016 12:33:31 +0800
Subject: [PATCH v5 2/2] regulator: add documentation for ACT8945A's regulator
 DT bindings
In-Reply-To: <1454646811-19472-1-git-send-email-wenyou.yang@atmel.com>
References: <1454646811-19472-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1454646811-19472-3-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for the DT bindings of the regulator
subdevice of ACT8945A MFD.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes in v5:
 - due the mfd cell .of_compatible removal, update the compatibe
   description and example

Changes in v4: None
Changes in v3: None
Changes in v2:
 - add Acked-by Rob Herring.

 .../bindings/regulator/act8945a-regulator.txt      |   80 ++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/act8945a-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
new file mode 100644
index 0000000..5c80a77
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
@@ -0,0 +1,80 @@
+Device-Tree bindings for regulators of Active-semi ACT8945A Multi-Function Device
+
+Required properties:
+ - compatible: "active-semi,act8945a", please refer to ../mfd/act8945a.txt.
+
+Optional properties:
+- active-semi,vsel-high: Indicates if the VSEL pin is set to logic-high.
+  If this property is missing, assume the VSEL pin is set to logic-low.
+
+Optional input supply properties:
+  - vp1-supply: The input supply for REG_DCDC1
+  - vp2-supply: The input supply for REG_DCDC2
+  - vp3-supply: The input supply for REG_DCDC3
+  - inl45-supply: The input supply for REG_LDO1 and REG_LDO2
+  - inl67-supply: The input supply for REG_LDO3 and REG_LDO4
+
+Any standard regulator properties can be used to configure the single regulator.
+
+The valid names for regulators are:
+	REG_DCDC1, REG_DCDC2, REG_DCDC3, REG_LDO1, REG_LDO2, REG_LDO3, REG_LDO4.
+
+Example:
+	pmic at 5b {
+		compatible = "active-semi,act8945a";
+		reg = <0x5b>;
+		status = "okay";
+
+		active-semi,vsel-high;
+
+		regulators {
+			vdd_1v35_reg: REG_DCDC1 {
+				regulator-name = "VDD_1V35";
+				regulator-min-microvolt = <1350000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
+			};
+
+			vdd_1v2_reg: REG_DCDC2 {
+				regulator-name = "VDD_1V2";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-always-on;
+			};
+
+			vdd_3v3_reg: REG_DCDC3 {
+				regulator-name = "VDD_3V3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd_fuse_reg: REG_LDO1 {
+				regulator-name = "VDD_FUSE";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-always-on;
+			};
+
+			vdd_3v3_lp_reg: REG_LDO2 {
+				regulator-name = "VDD_3V3_LP";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd_led_reg: REG_LDO3 {
+				regulator-name = "VDD_LED";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd_sdhc_1v8_reg: REG_LDO4 {
+				regulator-name = "VDD_SDHC_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+		};
+	};
-- 
1.7.9.5
