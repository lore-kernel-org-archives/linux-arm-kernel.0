From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 10 Jul 2018 10:00:55 +0200
Subject: [PATCH v5 03/22] dt-bindings: sram: sunxi: Introduce new A10 binding
 for system-control
In-Reply-To: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180710080114.31469-4-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following-up on the introduction of a new binding for the A64, this
introduces a system-control binding for the A10 as a replacement of
the sram-controller binding.

This change is motivated by consistency with the Allwinner literature,
that mentions system control over SRAM controller. Moreover, the system
control block is sometimes used for more than SRAM (e.g. for muxing
related to the ethernet PHY).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 Documentation/devicetree/bindings/sram/sunxi-sram.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
index 9ef40e2e0a48..d7dd1a393011 100644
--- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
+++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
@@ -10,7 +10,8 @@ Controller Node
 
 Required properties:
 - compatible : should be:
-    - "allwinner,sun4i-a10-sram-controller"
+    - "allwinner,sun4i-a10-sram-controller" (deprecated)
+    - "allwinner,sun4i-a10-system-control"
     - "allwinner,sun50i-a64-sram-controller" (deprecated)
     - "allwinner,sun50i-a64-system-control"
 - reg : sram controller register offset + length
@@ -48,8 +49,8 @@ This valid values for this argument are:
 
 Example
 -------
-sram-controller at 1c00000 {
-	compatible = "allwinner,sun4i-a10-sram-controller";
+system-control at 1c00000 {
+	compatible = "allwinner,sun4i-a10-system-control";
 	reg = <0x01c00000 0x30>;
 	#address-cells = <1>;
 	#size-cells = <1>;
-- 
2.17.1
