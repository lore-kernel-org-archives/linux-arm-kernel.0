From: mjourdan@baylibre.com (Maxime Jourdan)
Date: Thu, 23 Aug 2018 13:49:52 +0200
Subject: [PATCH v3 1/3] dt-bindings: soc: amlogic: add meson-canvas
 documentation
In-Reply-To: <20180823114954.30704-1-mjourdan@baylibre.com>
References: <20180823114954.30704-1-mjourdan@baylibre.com>
Message-ID: <20180823114954.30704-2-mjourdan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT bindings doc for amlogic,meson-canvas

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 .../bindings/soc/amlogic/amlogic,canvas.txt   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt b/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt
new file mode 100644
index 000000000000..436d2106e80d
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt
@@ -0,0 +1,29 @@
+Amlogic Canvas
+================================
+
+A canvas is a collection of metadata that describes a pixel buffer.
+Those metadata include: width, height, phyaddr, wrapping, block mode
+and endianness.
+
+Many IPs within Amlogic SoCs rely on canvas indexes to read/write pixel data
+rather than use the phy addresses directly. For instance, this is the case for
+the video decoders and the display.
+
+Amlogic SoCs have 256 canvas.
+
+Device Tree Bindings:
+---------------------
+
+Video Lookup Table
+--------------------------
+
+Required properties:
+- compatible: "amlogic,canvas"
+- reg: Base physical address and size of the canvas registers.
+
+Example:
+
+canvas: video-lut at 48 {
+	compatible = "amlogic,canvas";
+	reg = <0x0 0x48 0x0 0x14>;
+};
-- 
2.18.0
