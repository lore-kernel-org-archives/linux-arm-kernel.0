From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 30 Jan 2014 11:32:48 +0100
Subject: [PATCH v2 3/5] ASoC: tda998x: add DT documentation
In-Reply-To: <cover.1391081933.git.moinejf@free.fr>
References: <cover.1391081933.git.moinejf@free.fr>
Message-ID: <5c20133f084ba9e41c00120b8a7c8d5ed8a23ffa.1391081934.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the DT documentation of the NXP TDA998x CODEC.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 Documentation/devicetree/bindings/sound/tda998x.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tda998x.txt

diff --git a/Documentation/devicetree/bindings/sound/tda998x.txt b/Documentation/devicetree/bindings/sound/tda998x.txt
new file mode 100644
index 0000000..13b73ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tda998x.txt
@@ -0,0 +1,16 @@
+Device-Tree bindings for the NXP TDA998x HDMI transmitter
+
+Required properties:
+	- compatible: must be "nxp,tda998x-codec".
+	- audio-ports: one or two values corresponding to entries in
+		the audio-port-names property.
+	- audio-port-names: must contain "i2s", "spdif" entries
+		matching entries in the audio-ports property.
+
+Example node:
+
+	hdmi_codec: hdmi-codec {
+		compatible = "nxp,tda998x-codec";
+		audio-ports = <0x03>, <0x04>;
+		audio-port-names = "i2s", "spdif";
+	};
-- 
1.9.rc1
