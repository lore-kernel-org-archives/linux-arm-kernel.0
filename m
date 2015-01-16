From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 16 Jan 2015 12:00:08 +0100
Subject: [PATCH v3 1/3] dt-bindings: mfd: add lubbock-io binding
Message-ID: <1421406010-14851-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a binding for lubbock motherboard IO board.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 .../devicetree/bindings/mfd/lubbock-io.txt         | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/lubbock-io.txt

diff --git a/Documentation/devicetree/bindings/mfd/lubbock-io.txt b/Documentation/devicetree/bindings/mfd/lubbock-io.txt
new file mode 100644
index 0000000..33c9e21
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/lubbock-io.txt
@@ -0,0 +1,26 @@
+Intel's pxa255 system development platform motherboard.
+
+This is the motherboard, or IO board, of the pxa25x development system,
+supporting a lubbock pxa25x SoC board.
+
+Required properties:
+  - compatible : One of the following chip-specific strings:
+        "intel,lubbock-io"
+  - interrupts : The first interrupt is the line the /IRQ signal the IO board
+                 multiplex is connected to. The only known case is GPIO0 on the
+                 pxa25x SoC.
+
+Optional properties:
+  - interrupts : The second optional interrupt is the base of the interrupts
+                 multiplexed by the lubbock motherboard. If unspecified, the
+                 range is fully dynamic, and the irqdomain will generate its
+                 interrupt base on the fly.
+
+Example:
+
+mb: lubbock-mb at 0 {
+	compatible = "intel,lubbock-io";
+	interrupts = <0 IRQ_TYPE_EDGE_FALLING 400 IRQ_TYPE_NONE>;
+	#interrupt-cells = <2>;
+        interrupt-parent = <&pxairq>;
+};
-- 
2.1.0
