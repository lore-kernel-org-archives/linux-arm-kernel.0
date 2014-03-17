From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 17 Mar 2014 10:17:37 +0100
Subject: [PATCH RFC 3/5] drm/i2c: tda998x: Add required properties
In-Reply-To: <cover.1395049204.git.moinejf@free.fr>
References: <cover.1395049204.git.moinejf@free.fr>
Message-ID: <d00abf5be3ca443fa0a370f454b4ef77873e933f.1395049204.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C address of the HDMI subdevice is needed for the driver to be
loaded and initialized at system startup time.

The origin of the video must be indicated by a reverse phandle
according to the media video interface.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 Documentation/devicetree/bindings/drm/i2c/tda998x.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
index d7df01c..c9fbb0f 100644
--- a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
+++ b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
@@ -3,6 +3,8 @@ Device-Tree bindings for the NXP TDA998x HDMI transmitter
 Required properties;
   - compatible: must be "nxp,tda998x"
 
+  - reg: must be <0x70>
+
 Optional properties:
   - interrupts: interrupt number and trigger type
 	default: polling
@@ -15,6 +17,10 @@ Optional properties:
   - video-ports: 24 bits value which defines how the video controller
 	output is wired to the TDA998x input - default: <0x230145>
 
+Required nodes:
+
+  - port: reference of the video source as described in media/video-interfaces
+
 Example:
 
 	tda998x: hdmi-encoder {
@@ -24,4 +30,10 @@ Example:
 		interrupts = <27 2>;		/* falling edge */
 		pinctrl-0 = <&pmx_camera>;
 		pinctrl-names = "default";
+
+		port {
+			tda998x_0: endpoint at 0 {
+				remote-endpoint = <&lcd0_0>;
+			};
+		};
 	};
-- 
1.9.0
