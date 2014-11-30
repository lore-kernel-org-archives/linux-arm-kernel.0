From: marek@goldelico.com (Marek Belisko)
Date: Sun, 30 Nov 2014 14:07:46 +0100
Subject: [PATCH v3 2/3] Documentation: DT: Add documentation for ti,
 opa362 bindings
In-Reply-To: <1417352867-7436-1-git-send-email-marek@goldelico.com>
References: <1417352867-7436-1-git-send-email-marek@goldelico.com>
Message-ID: <1417352867-7436-3-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 .../devicetree/bindings/video/ti,opa362.txt        | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ti,opa362.txt

diff --git a/Documentation/devicetree/bindings/video/ti,opa362.txt b/Documentation/devicetree/bindings/video/ti,opa362.txt
new file mode 100644
index 0000000..4747ef9
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/ti,opa362.txt
@@ -0,0 +1,38 @@
+OPA362 analog video amplifier
+
+Required properties:
+- compatible: "ti,opa362"
+- gpio: enable/disable output gpio
+
+Required node:
+- Video port 0 for opa362 input
+- Video port 1 for opa362 output
+
+Example:
+
+tv_amp: opa362 {
+	compatible = "ti,opa362";
+	gpios = <&gpio1 23 0>;  /* GPIO to enable video out amplifier */
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			reg = <0>;
+			opa_in: endpoint at 0 {
+				remote-endpoint = <&venc_out>;
+			};
+		};
+
+		port at 1 {
+			reg = <1>;
+			opa_out: endpoint at 0 {
+				remote-endpoint = <&tv_connector_in>;
+			};
+		};
+	};
+};
+
+
+
-- 
1.9.1
