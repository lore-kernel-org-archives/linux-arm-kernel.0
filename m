From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 21 Mar 2014 10:31:45 +0100
Subject: [PATCH RFC v2 3/6] drm/tilcd: dts: Add the video output port
In-Reply-To: <cover.1395397665.git.moinejf@free.fr>
References: <cover.1395397665.git.moinejf@free.fr>
Message-ID: <c4ed6b6a68b7445ed8625b07596c2e8e0879f809.1395397665.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The connection between the video source and sink must follow
the media video interface.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 Documentation/devicetree/bindings/drm/tilcdc/tilcdc.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/drm/tilcdc/tilcdc.txt b/Documentation/devicetree/bindings/drm/tilcdc/tilcdc.txt
index fff10da..d0de848 100644
--- a/Documentation/devicetree/bindings/drm/tilcdc/tilcdc.txt
+++ b/Documentation/devicetree/bindings/drm/tilcdc/tilcdc.txt
@@ -18,6 +18,12 @@ Optional properties:
  - max-pixelclock: The maximum pixel clock that can be supported
    by the lcd controller in KHz.
 
+Optional nodes:
+
+ - port: reference of the video sink as described in media/video-interfaces.
+   This reference is required when the video sink is the TDA19988 HDMI
+   transmitter.
+
 Example:
 
 	fb: fb at 4830e000 {
@@ -27,3 +33,11 @@ Example:
 		interrupts = <36>;
 		ti,hwmods = "lcdc";
 	};
+
+	&fb {
+		port {
+			lcd_0: endpoint at 0 {
+				remote-endpoint = <&hdmi_0>;
+			};
+		};
+	};
-- 
1.9.1
