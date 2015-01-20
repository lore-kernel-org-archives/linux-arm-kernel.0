From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Tue, 20 Jan 2015 22:08:52 +0530
Subject: [PATCH V9 11/14] Documentation: bridge: Add documentation for ps8622
 DT properties
In-Reply-To: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1421771935-31618-12-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for DT properties supported by ps8622/ps8625
eDP-LVDS converter.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
Tested-by: Rahul Sharma <rahul.sharma@samsung.com>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Tested-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 .../devicetree/bindings/video/bridge/ps8622.txt    |   31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/bridge/ps8622.txt

diff --git a/Documentation/devicetree/bindings/video/bridge/ps8622.txt b/Documentation/devicetree/bindings/video/bridge/ps8622.txt
new file mode 100644
index 0000000..c989c38
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/bridge/ps8622.txt
@@ -0,0 +1,31 @@
+ps8622-bridge bindings
+
+Required properties:
+	- compatible: "parade,ps8622" or "parade,ps8625"
+	- reg: first i2c address of the bridge
+	- sleep-gpios: OF device-tree gpio specification for PD_ pin.
+	- reset-gpios: OF device-tree gpio specification for RST_ pin.
+
+Optional properties:
+	- lane-count: number of DP lanes to use
+	- use-external-pwm: backlight will be controlled by an external PWM
+	- video interfaces: Device node can contain video interface port
+			    nodes for panel according to [1].
+
+[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
+
+Example:
+	lvds-bridge at 48 {
+		compatible = "parade,ps8622";
+		reg = <0x48>;
+		sleep-gpios = <&gpc3 6 1 0 0>;
+		reset-gpios = <&gpc3 1 1 0 0>;
+		lane-count = <1>;
+		ports {
+			port at 0 {
+				bridge_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
+			};
+		};
+	};
-- 
1.7.9.5
