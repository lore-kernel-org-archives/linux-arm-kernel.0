From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Thu, 26 Apr 2018 10:45:45 +0100
Subject: [PATCH v6 03/24] ASoC: qdsp6: dt-bindings: Add q6core dt bindings
In-Reply-To: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180426094606.4775-4-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add DT bindings for Q6CORE DSP module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,q6core.txt       | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6core.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6core.txt b/Documentation/devicetree/bindings/sound/qcom,q6core.txt
new file mode 100644
index 000000000000..bd14e9a93490
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6core.txt
@@ -0,0 +1,21 @@
+Qualcomm ADSP Core service binding
+
+Q6CORE is one of the APR audio service on Q6DSP.
+Please refer to qcom,apr.txt for details of the coommon apr service bindings
+used by the apr service device.
+
+- but must contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6core-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		   Or "qcom,q6core" where the version number can be queried
+		   from DSP.
+		   example "qcom,q6core-v2.0"
+
+= EXAMPLE
+q6core at 3 {
+	compatible = "qcom,q6core";
+	reg = <APR_SVC_ADSP_CORE>;
+};
-- 
2.16.2
