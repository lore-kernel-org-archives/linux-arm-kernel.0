From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 17 Mar 2014 10:31:45 +0100
Subject: [PATCH RFC 4/5] drm/tilcd: dts: Add the video sink
In-Reply-To: <cover.1395049204.git.moinejf@free.fr>
References: <cover.1395049204.git.moinejf@free.fr>
Message-ID: <f23ca5eb0aa076b149723b2c9cd67a840344db60.1395049204.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The connection between the video source and sink must follow
the media video interface.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 Documentation/devicetree/bindings/drm/tilcdc/slave.txt | 18 ------------------
 .../devicetree/bindings/drm/tilcdc/tilcdc.txt          |  6 ++++++
 2 files changed, 6 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/drm/tilcdc/slave.txt

diff --git a/Documentation/devicetree/bindings/drm/tilcdc/slave.txt b/Documentation/devicetree/bindings/drm/tilcdc/slave.txt
deleted file mode 100644
index 3d2c524..0000000
--- a/Documentation/devicetree/bindings/drm/tilcdc/slave.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Device-Tree bindings for tilcdc DRM encoder slave output driver
-
-Required properties:
- - compatible: value should be "ti,tilcdc,slave".
- - i2c: the phandle for the i2c device the encoder slave is connected to
-
-Recommended properties:
- - pinctrl-names, pinctrl-0: the pincontrol settings to configure
-   muxing properly for pins that connect to TFP410 device
-
-Example:
-
-	hdmi {
-		compatible = "ti,tilcdc,slave";
-		i2c = <&i2c0>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&nxp_hdmi_bonelt_pins>;
-	};
diff --git a/Documentation/devicetree/bindings/drm/tilcdc/tilcdc.txt b/Documentation/devicetree/bindings/drm/tilcdc/tilcdc.txt
index fff10da..425e288 100644
--- a/Documentation/devicetree/bindings/drm/tilcdc/tilcdc.txt
+++ b/Documentation/devicetree/bindings/drm/tilcdc/tilcdc.txt
@@ -18,6 +18,12 @@ Optional properties:
  - max-pixelclock: The maximum pixel clock that can be supported
    by the lcd controller in KHz.
 
+Optional nodes:
+
+ - port: reference of the video sink as described in media/video-interfaces.
+   This reference is required when the video sink is the TDA998x HDMI
+   transmitter.
+
 Example:
 
 	fb: fb at 4830e000 {
-- 
1.9.0
