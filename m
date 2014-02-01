From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 1 Feb 2014 17:48:49 +0100
Subject: [PATCH v3 3/5] ASoC: tda998x: add DT documentation of the tda998x
 CODEC
In-Reply-To: <cover.1391274627.git.moinejf@free.fr>
References: <cover.1391274627.git.moinejf@free.fr>
Message-ID: <8e4231b7a55802f58a14dd07ac5cd8b0babb1dce.1391274628.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the DT documentation of the NXP TDA998x CODEC.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 Documentation/devicetree/bindings/drm/i2c/tda998x.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
index d7df01c..aa0d81b 100644
--- a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
+++ b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
@@ -15,6 +15,17 @@ Optional properties:
   - video-ports: 24 bits value which defines how the video controller
 	output is wired to the TDA998x input - default: <0x230145>
 
+Optional subnodes:
+
+	- codec: audio CODEC
+
+Required codec subnode properties:
+	- compatible: must be "nxp,tda998x-codec".
+	- audio-ports: one or two values corresponding to entries in
+		the audio-port-names property.
+	- audio-port-names: must contain "i2s", "spdif" entries
+		matching entries in the audio-ports property.
+
 Example:
 
 	tda998x: hdmi-encoder {
@@ -24,4 +35,10 @@ Example:
 		interrupts = <27 2>;		/* falling edge */
 		pinctrl-0 = <&pmx_camera>;
 		pinctrl-names = "default";
+			hdmi_codec: codec {
+			compatible = "nxp,tda998x-codec";
+			audio-ports = <0x03>, <0x04>;
+			audio-port-names = "i2s", "spdif";
+			#sound-dai-cells = <1>;
+		};
 	};
-- 
1.9.rc1
