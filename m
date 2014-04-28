From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 28 Apr 2014 16:58:44 +0200
Subject: [PATCH 1/7] reset: sunxi: document sunxi's reset controllers bindings
In-Reply-To: <1398697130-8338-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1398697130-8338-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1398697130-8338-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings documentation for sunxi's reset controllers.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 .../bindings/reset/allwinner,sunxi-clock-reset.txt  | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt b/Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
new file mode 100644
index 0000000..a582804
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
@@ -0,0 +1,21 @@
+Allwinner sunxi Peripheral Reset Controller
+===========================================
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required properties:
+- compatible: Should be one of the following depending on your SoC:
+  "allwinner,sun6i-a31-ahb1-reset"
+  "allwinner,sun6i-a31-clock-reset"
+- reg: should be register base and length as documented in the
+  datasheet
+- #reset-cells: 1, see below
+
+example:
+
+ahb1_rst: reset at 01c202c0 {
+	#reset-cells = <1>;
+	compatible = "allwinner,sun6i-a31-ahb1-reset";
+	reg = <0x01c202c0 0xc>;
+};
-- 
1.8.3.2
