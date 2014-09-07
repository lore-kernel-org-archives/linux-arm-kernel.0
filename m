From: info@lategoodbye.de (Stefan Wahren)
Date: Sun,  7 Sep 2014 13:37:47 +0200
Subject: [PATCH RFC 1/3] DT: add binding for MXS regulator
In-Reply-To: <1410089869-6611-1-git-send-email-info@lategoodbye.de>
References: <1410089869-6611-1-git-send-email-info@lategoodbye.de>
Message-ID: <1410089869-6611-2-git-send-email-info@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the Device tree bindings for the Freescale MXS on-chip
regulators.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../bindings/regulator/mxs-regulator.txt           | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mxs-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/mxs-regulator.txt b/Documentation/devicetree/bindings/regulator/mxs-regulator.txt
new file mode 100644
index 0000000..c3226cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mxs-regulator.txt
@@ -0,0 +1,38 @@
+MXS regulators
+
+Required node properties:
+- compatible: Should be "fsl,<soc>-power", where soc is "imx23" or "imx28"
+- reg: Offset and length of the register set for the device
+
+Required regulator properties:
+- compatible: Must be "fsl,mxs-regulator"
+- reg: Offset of the register set for the regulator
+- mxs-max-reg-val: Maximum value of this register
+
+Optional regulator properties:
+- mxs-default-microvolt: initial voltage of the regulator
+
+Any regulator property defined as part of the core regulator
+binding, defined in regulator.txt, can also be used.
+
+Example:
+
+	power: power at 80044000 {
+		compatible = "fsl,imx28-power";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x80044000 0x2000>;
+
+		reg_vddio: regulator-vddio at 80044060 {
+			reg = <0x80044060>;
+			compatible = "fsl,mxs-regulator";
+			regulator-name = "vddio";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3600000>;
+			regulator-microvolt-offset = <80000>;
+			regulator-always-on;
+			mxs-max-reg-val = <0x10>;
+			mxs-default-microvolt = <3300000>;
+		};
+	};
+
-- 
1.8.1.4
