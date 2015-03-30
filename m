From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 30 Mar 2015 22:58:32 +0100
Subject: [PATCH v4 08/10] eeprom: qfprom: Add bindings for qfprom
In-Reply-To: <1427752492-17039-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1427752492-17039-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1427752712-17389-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds bindings for qfprom found in QCOM SOCs. QFPROM driver
is based on simple eeprom framework.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/eeprom/qfprom.txt          | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/eeprom/qfprom.txt

diff --git a/Documentation/devicetree/bindings/eeprom/qfprom.txt b/Documentation/devicetree/bindings/eeprom/qfprom.txt
new file mode 100644
index 0000000..21a7104
--- /dev/null
+++ b/Documentation/devicetree/bindings/eeprom/qfprom.txt
@@ -0,0 +1,34 @@
+= Qualcomm QFPROM device tree bindings =
+
+This binding is intended to represent QFPROM which is found in most QCOM SOCs.
+
+Required properties:
+- compatible: should be "qcom,qfprom"
+- reg: Should contain registers location and length
+
+= Data cells =
+Are child nodes of qfprom, bindings of which as described in
+bindings/eeprom/eeprom.txt
+
+Example:
+
+	qfprom: qfprom at 00700000 {
+		compatible 	= "qcom,qfprom";
+		reg		= <0x00700000 0x8000>;
+		...
+		/* Data cells */
+		tsens_calibration: calib at 404 {
+			reg = <0x4404 0x10>;
+		};
+	};
+
+
+= Data consumers =
+Are device nodes which consume eeprom data cells.
+
+For example:
+
+	tsens {
+		...
+		calibration = <&tsens_calibration>;
+	};
-- 
1.9.1
