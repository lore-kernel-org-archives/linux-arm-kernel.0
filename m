From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed, 23 Sep 2015 20:04:53 +0200
Subject: [linux-sunxi][alsa-devel][PATCH 2/3] dt-binding: Add sunxi SPDIF
 machine driver
In-Reply-To: <1443031494-32469-1-git-send-email-codekipper@gmail.com>
References: <1443031494-32469-1-git-send-email-codekipper@gmail.com>
Message-ID: <1443031494-32469-3-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add device tree bindings for the SPDIF machine driver for Allwinner SoC
devices.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 .../bindings/sound/sunxi-audio-spdif.txt           | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt b/Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt
new file mode 100644
index 0000000..b9e8152
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt
@@ -0,0 +1,36 @@
+Allwinner audio complex with S/PDIF transceiver
+
+Required properties:
+
+  - compatible		: "Allwinner,sunxi-audio-spdif"
+
+  - model		: The user-visible name of this sound complex
+
+  - spdif-controller	: The phandle of the Allwinner S/PDIF controller
+
+
+Optional properties:
+
+  - spdif-out		: This is a boolean property. If present, the
+			  transmitting function of S/PDIF will be enabled,
+			  indicating there's a physical S/PDIF out connector
+			  or jack on the board or it's connecting to some
+			  other IP block, such as an HDMI encoder or
+			  display-controller.
+
+  - spdif-in		: This is a boolean property. If present, the receiving
+			  function of S/PDIF will be enabled, indicating there
+			  is a physical S/PDIF in connector/jack on the board.
+
+* Note: At least one of these two properties should be set in the DT binding.
+
+
+Example:
+
+sound-spdif {
+	compatible = "allwinner,sunxi-audio-spdif";
+	model = "sunxi-spdif";
+	spdif-controller = <&spdif>;
+	spdif-out;
+	spdif-in;
+};
-- 
2.5.3
