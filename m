From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 21 May 2015 17:44:45 +0100
Subject: [PATCH v5 09/11] nvmem: qfprom: Add bindings for qfprom
In-Reply-To: <1432226535-8640-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1432226535-8640-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1432226685-9081-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds bindings for qfprom found in QCOM SOCs. QFPROM driver
is based on simple nvmem framework.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qfprom.txt | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qfprom.txt

diff --git a/Documentation/devicetree/bindings/nvmem/qfprom.txt b/Documentation/devicetree/bindings/nvmem/qfprom.txt
new file mode 100644
index 0000000..8a8d55f
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/qfprom.txt
@@ -0,0 +1,35 @@
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
+bindings/nvmem/nvmem.txt
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
+Are device nodes which consume nvmem data cells.
+
+For example:
+
+	tsens {
+		...
+		nvmem-cell = <&tsens_calibration>;
+		nvmem-cell-names = "calibration";
+	};
-- 
1.9.1
