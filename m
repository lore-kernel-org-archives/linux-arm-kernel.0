From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Fri,  1 Dec 2017 08:49:35 +0100
Subject: [PATCH v5 2/5] dt-bindings: gps: add w2sg00x4 bindings documentation
 (GPS module with UART))
In-Reply-To: <cover.1512114576.git.hns@goldelico.com>
References: <cover.1512114576.git.hns@goldelico.com>
Message-ID: <c72470e3ae1b8c912ce675c8bf514c49c4d1a158.1512114576.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add bindings documentation for Wi2Wi W2SG00x4 GPS module.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/gps/wi2wi,w2sg0004.txt     | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gps/wi2wi,w2sg0004.txt

diff --git a/Documentation/devicetree/bindings/gps/wi2wi,w2sg0004.txt b/Documentation/devicetree/bindings/gps/wi2wi,w2sg0004.txt
new file mode 100644
index 000000000000..bcf307382afb
--- /dev/null
+++ b/Documentation/devicetree/bindings/gps/wi2wi,w2sg0004.txt
@@ -0,0 +1,24 @@
+Wi2Wi GPS module connected through UART
+
+Should be a subnode of the SoC UART it is connected to.
+
+Required properties:
+- compatible:	should be one of (depending on precise model)
+	"wi2wi,w2sg0004"
+	"wi2wi,w2sg0084"
+- enable-gpio:	the GPIO that controls the module's power toggle
+	input. A positive impulse of sufficent length toggles the
+	power state.
+
+Optional properties:
+- lna-supply:	an (optional) LNA regulator that is enabled together with the GPS receiver
+
+Example:
+
+&uart2 {
+	w2sg0004: gps {
+		compatible = "wi2wi,w2sg0004";
+		lna-supply = <&vsim>;   /* LNA regulator */
+		enable-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;    /* GPIO_145: trigger for turning on/off w2sg0004 */
+        };
+};
-- 
2.12.2
