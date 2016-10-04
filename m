From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Tue,  4 Oct 2016 11:46:23 +0200
Subject: [PATCH 10/14] dt-bindings: sound: Add sun8i audio card documentation
In-Reply-To: <cover.1475569400.git.mylene.josserand@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
Message-ID: <c317ce9f180a24611e79086944feca00d416b7b4.1475571575.git.mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the documentation for dt-binding of the audio card driver
for sun8i SoC.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 Documentation/devicetree/bindings/sound/sun8i-audio.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun8i-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/sun8i-audio.txt b/Documentation/devicetree/bindings/sound/sun8i-audio.txt
new file mode 100644
index 0000000..2403983
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sun8i-audio.txt
@@ -0,0 +1,17 @@
+* Allwinner A23/A33 audio card
+
+This binding implements the A33 audio card.
+
+Required properties:
+- compatible: must be "allwinner,sun8i-audio"
+- allwinner,audio-codec: must have the phandle of the audio codec
+  ("sun8i-a33-codec", for example).
+- allwinner,i2s-controller: must have the phandle of the DAI
+  ("allwinner,sun4i-a10-i2s", for example)
+
+Example:
+sound {
+	compatible = "allwinner,sun8i-audio";
+	allwinner,audio-codec = <&codec>;
+	allwinner,i2s-controller = <&dai>;
+};
-- 
2.9.3
