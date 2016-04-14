From: joel@jms.id.au (Joel Stanley)
Date: Thu, 14 Apr 2016 19:17:42 +0930
Subject: [PATCH 2/9] doc/devicetree: Add Aspeed VIC bindings
In-Reply-To: <1460627269-21721-1-git-send-email-joel@jms.id.au>
References: <1460627269-21721-1-git-send-email-joel@jms.id.au>
Message-ID: <1460627269-21721-3-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../interrupt-controller/aspeed,ast2400-vic.txt    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt
new file mode 100644
index 000000000000..10ed0c20ee6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt
@@ -0,0 +1,24 @@
+Aspeed Vectored Interrupt Controller
+
+These bindings are for the Aspeed AST2400 interrupt controller register layout.
+The SoC has an legacy register layout, but this driver does not support that
+mode of operation.
+
+Required properties:
+
+- compatible : should be "aspeed,ast2400-vic".
+
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 1.
+- valid-sources : bitmask of valid irq sources
+
+Example:
+
+ vic: interrupt-controller {
+      compatible = "aspeed,ast2400-new-vic";
+      interrupt-controller;
+      #interrupt-cells = <1>;
+      valid-sources = < 0xffffffff 0x0007ffff>;
+      reg = <0x1e6c0080 0x80>;
+ };
-- 
2.7.4
