From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Thu, 14 Dec 2017 17:33:48 +0000
Subject: [RESEND PATCH v2 01/15] dt-bindings: soc: qcom: Add bindings for APR
 bus
In-Reply-To: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
Message-ID: <20171214173402.19074-2-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add dt bindings for Qualcomm APR bus driver

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/soc/qcom/qcom,apr.txt      | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
new file mode 100644
index 000000000000..4e93213ae98d
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
@@ -0,0 +1,28 @@
+Qualcomm APR (Asynchronous Packet Router) binding
+
+This binding describes the Qualcomm APR. APR is a IPC protocol for
+communication between Application processor and QDSP. APR is mainly
+used for audio/voice services on the QDSP.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,apr-<SOC-NAME>" example: "qcom,apr-msm8996"
+
+
+- qcom,smd-channel:
+	Usage: required
+	Value type: <string>
+	Definition: standard SMD property specifying the SMD channel used for
+		    communication with the APR on QDSP.
+		    Should be "apr_audio_svc".
+		    Described in soc/qcom/qcom,smd.txt
+
+= EXAMPLE
+The following example represents a QDSP based sound card on a MSM8996 device
+which uses apr as communication between Apps and QDSP.
+
+	apr {
+		compatible = "qcom,apr-msm8996";
+		qcom,smd-channels = "apr_audio_svc";
+	};
-- 
2.15.0
