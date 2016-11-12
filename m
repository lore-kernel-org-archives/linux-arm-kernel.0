From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 12 Nov 2016 14:46:39 +0800
Subject: [PATCH 01/10] ASoC: sunxi: Add bindings for A23/A33/H3 codec's analog
 path controls
In-Reply-To: <20161112064648.26779-1-wens@csie.org>
References: <20161112064648.26779-1-wens@csie.org>
Message-ID: <20161112064648.26779-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The internal codec on A23/A33/H3 is split into 2 parts. The
analog path controls are routed through an embedded custom register
bus accessed through the PRCM block.

The SoCs share a common set of inputs, outputs, and audio paths.
The following table lists the differences.

    ----------------------------------------
    | Feature \ SoC |  A23  |  A33  |  H3  |
    ----------------------------------------
    | Headphone     |   v   |   v   |      |
    ----------------------------------------
    | Line Out      |       |       |  v   |
    ----------------------------------------
    | Phone In/Out  |   v   |   v   |      |
    ----------------------------------------

Add a binding for this hardware.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/sound/sun8i-codec-analog.txt     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt

diff --git a/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
new file mode 100644
index 000000000000..779b735781ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
@@ -0,0 +1,16 @@
+* Allwinner Codec Analog Controls
+
+Required properties:
+- compatible: must be one of the following compatibles:
+		- "allwinner,sun8i-a23-codec-analog"
+		- "allwinner,sun8i-h3-codec-analog"
+
+Required properties if not a sub-node of the PRCM node:
+- reg: must contain the registers location and length
+
+Example:
+prcm: prcm at 01f01400 {
+	codec_analog: codec-analog {
+		compatible = "allwinner,sun8i-a23-codec-analog";
+	};
+};
-- 
2.10.2
