From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Sat, 10 Mar 2018 02:24:38 +0000
Subject: [PATCH v4 06/24] ASoC: qdsp6: dt-bindings: Add q6asm dt bindings
In-Reply-To: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180310022456.26739-7-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add DT bindings for ASM (Audio Stream Manager) DSP module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6asm.txt       | 34 ++++++++++++++++++++++
 include/dt-bindings/sound/qcom,q6asm.h             | 22 ++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
 create mode 100644 include/dt-bindings/sound/qcom,q6asm.h

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
new file mode 100644
index 000000000000..84703747db3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
@@ -0,0 +1,34 @@
+Qualcomm Audio Stream Manager (Q6ASM) binding
+
+Q6ASM is one of the APR audio service on Q6DSP.
+Please refer to qcom,apr.txt for details of the coommon apr service bindings
+used by the apr service device.
+
+- but must contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		    Or "qcom,asm" where the version number can be queried
+		    from DSP.
+		    example "qcom,asm-v2.0"
+
+= ASM DAIs (Digial Audio Interface)
+"dais" subnode of the ASM node represents dai specific configuration
+
+- #sound-dai-cells
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Must be 1
+
+= EXAMPLE
+
+q6asm: q6asm {
+	compatible = "qcom,q6asm";
+	qcom,apr-svc-name = "ASM";
+	qcom,apr-svc-id = <APR_SVC_ASM>;
+	q6asmdai: dais {
+		#sound-dai-cells = <1>;
+	};
+};
diff --git a/include/dt-bindings/sound/qcom,q6asm.h b/include/dt-bindings/sound/qcom,q6asm.h
new file mode 100644
index 000000000000..2e11b15d930d
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,q6asm.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __DT_BINDINGS_Q6_ASM_H__
+#define __DT_BINDINGS_Q6_ASM_H__
+
+#define	MSM_FRONTEND_DAI_MULTIMEDIA1	0
+#define	MSM_FRONTEND_DAI_MULTIMEDIA2	1
+#define	MSM_FRONTEND_DAI_MULTIMEDIA3	2
+#define	MSM_FRONTEND_DAI_MULTIMEDIA4	3
+#define	MSM_FRONTEND_DAI_MULTIMEDIA5	4
+#define	MSM_FRONTEND_DAI_MULTIMEDIA6	5
+#define	MSM_FRONTEND_DAI_MULTIMEDIA7	6
+#define	MSM_FRONTEND_DAI_MULTIMEDIA8	7
+#define	MSM_FRONTEND_DAI_MULTIMEDIA9	8
+#define	MSM_FRONTEND_DAI_MULTIMEDIA10	9
+#define	MSM_FRONTEND_DAI_MULTIMEDIA11	10
+#define	MSM_FRONTEND_DAI_MULTIMEDIA12	11
+#define	MSM_FRONTEND_DAI_MULTIMEDIA13	12
+#define	MSM_FRONTEND_DAI_MULTIMEDIA14	13
+#define	MSM_FRONTEND_DAI_MULTIMEDIA15	14
+#define	MSM_FRONTEND_DAI_MULTIMEDIA16	15
+
+#endif /* __DT_BINDINGS_Q6_ASM_H__ */
-- 
2.15.1
