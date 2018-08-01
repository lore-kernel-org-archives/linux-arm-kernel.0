From: maxi.jourdan@wanadoo.fr (Maxime Jourdan)
Date: Wed,  1 Aug 2018 20:51:26 +0200
Subject: [PATCH 2/4] dt-bindings: soc: amlogic: add meson-canvas documentation
In-Reply-To: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
Message-ID: <20180801185128.23440-3-maxi.jourdan@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT bindings doc for amlogic,meson-canvas

Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
---
 .../soc/amlogic/amlogic,meson-canvas.txt      | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
new file mode 100644
index 000000000000..96e14374b9dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
@@ -0,0 +1,36 @@
+Amlogic Meson Canvas
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
+Canvas Provider
+--------------------------
+
+Required properties:
+- compatible: "amlogic,meson-canvas"
+
+Parent node should have the following properties :
+- compatible: "amlogic,meson-gx-dmc-sysctrl", "syscon", "simple-mfd"
+- reg: base address and size of the DMC system control register space.
+
+Example:
+
+sysctrl_DMC: system-controller at 0 {
+	compatible = "amlogic,meson-gx-dmc-sysctrl", "syscon", "simple-mfd";
+	reg = <0x0 0x0 0x0 0x1000>;
+
+	canvas: canvas-provider at 0 {
+		compatible = "amlogic,meson-canvas";
+	};
+};
-- 
2.17.1
