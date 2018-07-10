From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 10 Jul 2018 10:00:56 +0200
Subject: [PATCH v5 04/22] dt-bindings: sram: sunxi: Add A13, A20,
 A23 and H3 dedicated bindings
In-Reply-To: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180710080114.31469-5-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces dedicated bindings for the system control blocks found
on the A13, A20, A23 and H3 sunxi platforms.

Since the controllers on the A33 are the very same as those on the A23,
no specific compatible is introduced for it.

These bindings are introduced to allow reflecting the differences that
exist between these controllers, that may become significant to driver
implementations.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 Documentation/devicetree/bindings/sram/sunxi-sram.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
index d7dd1a393011..156a02ab6b54 100644
--- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
+++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
@@ -12,6 +12,10 @@ Required properties:
 - compatible : should be:
     - "allwinner,sun4i-a10-sram-controller" (deprecated)
     - "allwinner,sun4i-a10-system-control"
+    - "allwinner,sun5i-a13-system-control"
+    - "allwinner,sun7i-a20-system-control"
+    - "allwinner,sun8i-a23-system-control"
+    - "allwinner,sun8i-h3-system-control"
     - "allwinner,sun50i-a64-sram-controller" (deprecated)
     - "allwinner,sun50i-a64-system-control"
 - reg : sram controller register offset + length
-- 
2.17.1
