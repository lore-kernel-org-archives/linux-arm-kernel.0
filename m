From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Sat, 10 Mar 2018 02:24:37 +0000
Subject: [PATCH v4 05/24] ASoC: qdsp6: dt-bindings: Add q6adm dt bindings
In-Reply-To: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180310022456.26739-6-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add DT bindings for ADM (Audio Device Manager) DSP module.
This module implements mixer controls to setup the connections between
AFE ports and ASM streams.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6adm.txt       | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
new file mode 100644
index 000000000000..ddd93c80bd8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
@@ -0,0 +1,34 @@
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
+		   Or "qcom,adm" where the version number can be queried
+		   from DSP.
+		   example "qcom,adm-v2.0"
+
+
+= ADM routing
+"routing" subnode of the ADM node represents adm routing specific configuration
+
+- #sound-dai-cells
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Must be 0
+
+= EXAMPLE
+q6adm: q6adm {
+	compatible = "qcom,q6adm";
+	qcom,apr-svc-name = "ADM";
+	qcom,apr-svc-id = <APR_SVC_ADM>;
+	q6routing: routing {
+		#sound-dai-cells = <0>;
+	};
+};
-- 
2.15.1
