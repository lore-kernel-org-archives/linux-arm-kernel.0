From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 18 Mar 2014 10:15:46 +0200
Subject: [PATCHv2 7/8] Doc/DT: Add DT binding documentation for TFP410 encoder
In-Reply-To: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
References: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1395130547-18633-8-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT binding documentation for TFP410 encoder

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Archit Taneja <archit@ti.com>
---
 .../devicetree/bindings/video/ti,tfp410.txt        | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ti,tfp410.txt

diff --git a/Documentation/devicetree/bindings/video/ti,tfp410.txt b/Documentation/devicetree/bindings/video/ti,tfp410.txt
new file mode 100644
index 000000000000..2cbe32a3d0bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/ti,tfp410.txt
@@ -0,0 +1,41 @@
+TFP410 DPI to DVI encoder
+=========================
+
+Required properties:
+- compatible: "ti,tfp410"
+
+Optional properties:
+- powerdown-gpios: power-down gpio
+
+Required nodes:
+- Video port 0 for DPI input
+- Video port 1 for DVI output
+
+Example
+-------
+
+tfp410: encoder at 0 {
+	compatible = "ti,tfp410";
+	powerdown-gpios = <&twl_gpio 2 GPIO_ACTIVE_LOW>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			reg = <0>;
+
+			tfp410_in: endpoint at 0 {
+				remote-endpoint = <&dpi_out>;
+			};
+		};
+
+		port at 1 {
+			reg = <1>;
+
+			tfp410_out: endpoint at 0 {
+				remote-endpoint = <&dvi_connector_in>;
+			};
+		};
+	};
+};
-- 
1.8.3.2
