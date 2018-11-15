From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 15 Nov 2018 15:50:03 +0100
Subject: [PATCH 05/15] dt-bindings: sram: sunxi: Add bindings for the H5 with
 SRAM C1
In-Reply-To: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181115145013.3378-6-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces new bindings for the H5 SoC in the SRAM controller.
Because the SRAM layout is different from other SoCs, no backward
compatibility is assumed with any of them.

However, the C1 SRAM section alone looks similar to previous SoCs,
so it is compatible with the initial A10 binding.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 Documentation/devicetree/bindings/sram/sunxi-sram.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
index 62dd0748f0ef..c043a6a4011e 100644
--- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
+++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
@@ -18,6 +18,7 @@ Required properties:
     - "allwinner,sun8i-h3-system-control"
     - "allwinner,sun50i-a64-sram-controller" (deprecated)
     - "allwinner,sun50i-a64-system-control"
+    - "allwinner,sun50i-h5-system-control"
     - "allwinner,sun50i-h6-system-control", "allwinner,sun50i-a64-system-control"
 - reg : sram controller register offset + length
 
@@ -55,6 +56,9 @@ The valid sections compatible for H3 are:
 The valid sections compatible for A64 are:
     - allwinner,sun50i-a64-sram-c
 
+The valid sections compatible for H5 are:
+    - allwinner,sun50i-h5-sram-c1, allwinner,sun4i-a10-sram-c1
+
 The valid sections compatible for H6 are:
     - allwinner,sun50i-h6-sram-c, allwinner,sun50i-a64-sram-c
 
-- 
2.19.1
