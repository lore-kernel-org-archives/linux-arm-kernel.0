From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Fri,  9 Mar 2018 23:09:57 +0200
Subject: [PATCH v4 6/7] dt-bindings: Introduce interconnect consumers bindings
In-Reply-To: <20180309210958.16672-1-georgi.djakov@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
Message-ID: <20180309210958.16672-7-georgi.djakov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for the interconnect consumer bindings, that will allow
to link a device node (consumer) to its interconnect controller hardware.

Tha aim is to enable drivers to request a framework API to configure an
interconnect path by providing their struct device pointer and a name.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/interconnect.txt         | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
index 70612bb201e4..7935abf10c4b 100644
--- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -45,3 +45,26 @@ Examples:
 			status = "okay";
 		};
 
+= interconnect consumers =
+
+The interconnect consumers are device nodes which consume the interconnect
+path(s) provided by the interconnect provider. There can be multiple
+interconnect providers on a SoC and the consumer may consume multiple paths
+from different providers depending on usecase and the components it has to
+interact with.
+
+Required-properties:
+interconnects: Pairs of phandles and interconnect provider specifier to denote
+		the source and the destination port of the interconnect path.
+interconnect-names: List of interconnect path name strings sorted in the same
+		order as the interconnects property. Consumers drivers will use
+		interconnect-names to match interconnect paths with interconnect
+		specifiers.
+
+Example:
+
+	sdhci at 7864000 {
+		...
+		interconnects = <&pnoc 78 &bimc 512>
+		interconnect-names = "memory";
+	};
