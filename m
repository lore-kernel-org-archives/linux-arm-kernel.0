From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Tue, 13 Feb 2018 16:58:18 +0000
Subject: [PATCH v3 06/25] dt-bindings: sound: qcom: Add bindings for q6adm
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180213165837.1620-7-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6adm.txt       | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
new file mode 100644
index 000000000000..e493dccfe116
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
@@ -0,0 +1,31 @@
+Qualcomm Audio Device Manager (Q6ADM) binding
+
+Q6ADM is one of the APR audio service on Q6DSP.
+Please refer to qcom,apr.txt for details of the coommon apr service bindings
+used by the apr service device.
+
+- but must contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,adm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		    example "qcom,adm-v2.0"
+
+- qcom,apr-svc-id
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Must be 8 for Audio Device Manager Service.
+
+- qcom,apr-svc-name
+	Usage: required
+	Value type: <stringlist>
+	Definition: Must be "ADM"
+
+= EXAMPLE
+
+q6adm: q6adm {
+	compatible = "qcom,q6adm-v2.0";
+	qcom,apr-svc-name = "ADM";
+	qcom,apr-svc-id = <APR_SVC_ADM>;
+};
-- 
2.15.1
