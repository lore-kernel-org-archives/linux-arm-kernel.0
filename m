From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 18 Mar 2014 10:15:45 +0200
Subject: [PATCHv2 6/8] Doc/DT: Add DT binding documentation for Sony acx565akm
 panel
In-Reply-To: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
References: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1395130547-18633-7-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT binding documentation for Sony acx565akm panel

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Sebastian Reichel <sre@debian.org>
Reviewed-by: Archit Taneja <archit@ti.com>
---
 .../devicetree/bindings/video/sony,acx565akm.txt   | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/sony,acx565akm.txt

diff --git a/Documentation/devicetree/bindings/video/sony,acx565akm.txt b/Documentation/devicetree/bindings/video/sony,acx565akm.txt
new file mode 100644
index 000000000000..e12333280749
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/sony,acx565akm.txt
@@ -0,0 +1,30 @@
+Sony ACX565AKM SDI Panel
+========================
+
+Required properties:
+- compatible: "sony,acx565akm"
+
+Optional properties:
+- label: a symbolic name for the panel
+- reset-gpios: panel reset gpio
+
+Required nodes:
+- Video port for SDI input
+
+Example
+-------
+
+acx565akm at 2 {
+	compatible = "sony,acx565akm";
+	spi-max-frequency = <6000000>;
+	reg = <2>;
+
+	label = "lcd";
+	reset-gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* 90 */
+
+	port {
+		lcd_in: endpoint {
+			remote-endpoint = <&sdi_out>;
+		};
+	};
+};
-- 
1.8.3.2
