From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 21 Mar 2014 10:48:43 +0100
Subject: [PATCH RFC v2 1/6] drm/i2c: tda998x: Add the required port property
In-Reply-To: <cover.1395397665.git.moinejf@free.fr>
References: <cover.1395397665.git.moinejf@free.fr>
Message-ID: <2ad6cd1afa7800826da991ae522ef54368fe8d78.1395397665.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the media video interface, the video source and sink
ports must be identified by mutual phandles.

This patch adds the 'port' property of the tda998x (sink side).

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 Documentation/devicetree/bindings/drm/i2c/tda998x.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
index e3f3d65..10c5b5e 100644
--- a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
+++ b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
@@ -17,13 +17,22 @@ Optional properties:
   - video-ports: 24 bits value which defines how the video controller
 	output is wired to the TDA998x input - default: <0x230145>
 
+Required nodes:
+  - port: reference of the video source as described in media/video-interfaces
+
 Example:
 
-	tda998x: hdmi-encoder {
+	hdmi: hdmi-encoder {
 		compatible = "nxp,tda19988";
 		reg = <0x70>;
 		interrupt-parent = <&gpio0>;
 		interrupts = <27 2>;		/* falling edge */
 		pinctrl-0 = <&pmx_camera>;
 		pinctrl-names = "default";
+
+		port {
+			hdmi_0: endpoint at 0 {
+				remote-endpoint = <&lcd0_0>;
+			};
+		};
 	};
-- 
1.9.1
