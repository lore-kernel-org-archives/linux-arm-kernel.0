From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 26 Jun 2018 10:20:05 +0100
Subject: [PATCH v2 01/12] ASoC: q6adm: dt-bindings: add compatible string to
 routing
In-Reply-To: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180626092016.9296-2-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible string to routing so that it can support DT based module
autoloading.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,q6adm.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
index cb709e5dbc44..bbae426cdfb1 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
@@ -18,6 +18,11 @@ used by the apr service device.
 = ADM routing
 "routing" subnode of the ADM node represents adm routing specific configuration
 
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6adm-routing".
+
 - #sound-dai-cells
 	Usage: required
 	Value type: <u32>
@@ -28,6 +33,7 @@ q6adm at 8 {
 	compatible = "qcom,q6adm";
 	reg = <APR_SVC_ADM>;
 	q6routing: routing {
+		compatible = "qcom,q6adm-routing";
 		#sound-dai-cells = <0>;
 	};
 };
-- 
2.16.2
