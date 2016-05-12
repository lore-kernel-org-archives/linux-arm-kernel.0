From: joel@jms.id.au (Joel Stanley)
Date: Fri, 13 May 2016 00:13:12 +0930
Subject: [PATCH v3 1/2] doc/devicetree: Add Aspeed VIC bindings
In-Reply-To: <1463064193-2178-1-git-send-email-joel@jms.id.au>
References: <1462802317-27086-1-git-send-email-joel@jms.id.au>
 <1463064193-2178-1-git-send-email-joel@jms.id.au>
Message-ID: <1463064193-2178-2-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../interrupt-controller/aspeed,ast2400-vic.txt    | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt
new file mode 100644
index 000000000000..6c6e85324b9d
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt
@@ -0,0 +1,22 @@
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
+
+Example:
+
+ vic: interrupt-controller at 1e6c0080 {
+      compatible = "aspeed,ast2400-vic";
+      interrupt-controller;
+      #interrupt-cells = <1>;
+      reg = <0x1e6c0080 0x80>;
+ };
-- 
2.8.1
