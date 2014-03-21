From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 21 Mar 2014 10:31:45 +0100
Subject: [PATCH RFC v2 5/6] drm/tilcd: dts: Remove unused slave description
In-Reply-To: <cover.1395397665.git.moinejf@free.fr>
References: <cover.1395397665.git.moinejf@free.fr>
Message-ID: <4bde6edb48bad767730b7f909cd61c1ec5bd5ff0.1395397665.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tda998x being converted to a normal DRM encoder/connector,
there is no slave notion anymore.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 Documentation/devicetree/bindings/drm/tilcdc/slave.txt | 18 ------------------
 1 file changed, 18 deletions(-)
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
-- 
1.9.1
