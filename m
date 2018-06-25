From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 25 Jun 2018 15:31:06 +0100
Subject: [PATCH 02/11] ASoC: q6asm: dt-bindings: add compatible string to dais
In-Reply-To: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180625143115.8346-3-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible string to dais so that it can support DT based module
autoloading.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,q6asm.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
index 2178eb91146f..f9c7bd8c1bc0 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
@@ -17,6 +17,11 @@ used by the apr service device.
 = ASM DAIs (Digial Audio Interface)
 "dais" subnode of the ASM node represents dai specific configuration
 
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6asm-dais".
+
 - #sound-dai-cells
 	Usage: required
 	Value type: <u32>
@@ -28,6 +33,7 @@ q6asm at 7 {
 	compatible = "qcom,q6asm";
 	reg = <APR_SVC_ASM>;
 	q6asmdai: dais {
+		compatible = "qcom,q6asm-dais";
 		#sound-dai-cells = <1>;
 	};
 };
-- 
2.16.2
