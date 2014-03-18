From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 18 Mar 2014 10:15:47 +0200
Subject: [PATCHv2 8/8] Doc/DT: Add DT binding documentation for tpd12s015
 encoder
In-Reply-To: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
References: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1395130547-18633-9-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT binding documentation for tpd12s015 encoder

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Archit Taneja <archit@ti.com>
---
 .../devicetree/bindings/video/ti,tpd12s015.txt     | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ti,tpd12s015.txt

diff --git a/Documentation/devicetree/bindings/video/ti,tpd12s015.txt b/Documentation/devicetree/bindings/video/ti,tpd12s015.txt
new file mode 100644
index 000000000000..26e6d32e3f20
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/ti,tpd12s015.txt
@@ -0,0 +1,44 @@
+TPD12S015 HDMI level shifter and ESD protection chip
+====================================================
+
+Required properties:
+- compatible: "ti,tpd12s015"
+
+Optional properties:
+- gpios: CT CP HPD, LS OE and HPD gpios
+
+Required nodes:
+- Video port 0 for HDMI input
+- Video port 1 for HDMI output
+
+Example
+-------
+
+tpd12s015: encoder at 1 {
+	compatible = "ti,tpd12s015";
+
+	gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,	/* 60, CT CP HPD */
+		<&gpio2 9 GPIO_ACTIVE_HIGH>,	/* 41, LS OE */
+		<&gpio2 31 GPIO_ACTIVE_HIGH>;	/* 63, HPD */
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			reg = <0>;
+
+			tpd12s015_in: endpoint at 0 {
+				remote-endpoint = <&hdmi_out>;
+			};
+		};
+
+		port at 1 {
+			reg = <1>;
+
+			tpd12s015_out: endpoint at 0 {
+				remote-endpoint = <&hdmi_connector_in>;
+			};
+		};
+	};
+};
-- 
1.8.3.2
