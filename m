From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 Jun 2018 23:35:46 +0800
Subject: [PATCH v3 2/4] dt-bindings: sram: Rename A64 SRAM controller
 compatible
In-Reply-To: <20180614153548.9644-1-wens@csie.org>
References: <20180614153548.9644-1-wens@csie.org>
Message-ID: <20180614153548.9644-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SRAM mapping controls on Allwinner SoCs is located in a block called
"System Controls". This block also has registers for identifying the SoC,
reading the state of an external boot-related pin, and on some newer SoCs,
glue layer controls for the EMAC Ethernet controller.

The A64 variant compatible is renamed to "allwinner,a64-system-control"
to reflect this. The old A64 compatible is deprecated. So far we haven't
seen any actual use of it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/sram/sunxi-sram.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
index d087f04a4d7f..9ef40e2e0a48 100644
--- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
+++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
@@ -11,7 +11,8 @@ Controller Node
 Required properties:
 - compatible : should be:
     - "allwinner,sun4i-a10-sram-controller"
-    - "allwinner,sun50i-a64-sram-controller"
+    - "allwinner,sun50i-a64-sram-controller" (deprecated)
+    - "allwinner,sun50i-a64-system-control"
 - reg : sram controller register offset + length
 
 SRAM nodes
-- 
2.17.1
