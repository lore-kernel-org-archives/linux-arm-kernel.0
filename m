From: krishna.md@samsung.com (Krishna Mohan Dani)
Date: Mon, 24 Nov 2014 12:21:51 +0530
Subject: [PATCH] ASoC: Arndale: Add machine device tree binding documentation
 for Arndale board
Message-ID: <1416811911-21026-1-git-send-email-krishna.md@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the device tree binding for the Arndale board based machine driver.

Signed-off-by: Krishna Mohan Dani <krishna.md@samsung.com>
---
 .../devicetree/bindings/sound/arndale.txt          |   24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/arndale.txt

diff --git a/Documentation/devicetree/bindings/sound/arndale.txt b/Documentation/devicetree/bindings/sound/arndale.txt
new file mode 100644
index 0000000..0e76946
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/arndale.txt
@@ -0,0 +1,24 @@
+Audio Binding for Arndale boards
+
+Required properties:
+- compatible : Can be the following,
+			"samsung,arndale-rt5631"
+
+- samsung,audio-cpu: The phandle of the Samsung I2S controller
+- samsung,audio-codec: The phandle of the audio codec
+
+Optional:
+- samsung,model: The name of the sound-card
+
+Arndale Boards has many audio daughter cards, one of them is
+rt5631/alc5631. Below example shows audio bindings for rt5631/
+alc5631 based codec.
+
+Example:
+
+sound {
+		compatible = "samsung,arndale-rt5631";
+
+		samsung,audio-cpu = <&i2s0>
+		samsung,audio-codec = <&rt5631>;
+};
-- 
1.7.9.5
