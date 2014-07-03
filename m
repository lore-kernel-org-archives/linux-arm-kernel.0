From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 3 Jul 2014 16:39:58 +0300
Subject: [PATCH 2/4] Doc/DT: Add SiI9022 binding documentation
In-Reply-To: <1404394800-18138-1-git-send-email-tomi.valkeinen@ti.com>
References: <1404394800-18138-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1404394800-18138-3-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT binding documentation for Silicon Image SiI9022 HDMI encoder.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree at vger.kernel.org
---
 .../devicetree/bindings/video/sil,sii9022.txt      | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/sil,sii9022.txt

diff --git a/Documentation/devicetree/bindings/video/sil,sii9022.txt b/Documentation/devicetree/bindings/video/sil,sii9022.txt
new file mode 100644
index 000000000000..0cd926636998
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/sil,sii9022.txt
@@ -0,0 +1,53 @@
+Silicon Image SiI9022 HDMI Encoder
+==================================
+
+Silicon Image SiI9022 is an HDMI encoder that encodes parallel RGB
+signal to HDMI signal. The SiI9022 is controlled with i2c command, and
+it has a single reset pin and single interrupt pin.
+
+Required properties:
+- compatible: "sil,sii9022"
+
+Optional properties:
+- reset-gpio: reset gpio
+- interrupts: interrupt line
+
+Required nodes:
+- Video port 0 for parallel video input
+- Video port 1 for HDMI output
+
+Example
+-------
+
+&i2c2 {
+	sii9022: sii9022 at 3b {
+		compatible = "sil,sii9022";
+		reg = <0x3b>;
+
+		reset-gpio = <&gpio2 1 GPIO_ACTIVE_LOW>;
+
+		interrupt-parent = <&gpio1>;
+		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+
+				sii9022_in: endpoint {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+
+				sii9022_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+};
-- 
1.9.1
