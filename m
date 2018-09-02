From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun,  2 Sep 2018 09:26:17 +0200
Subject: [PATCH 01/27] dt-bindings: sunxi-sram: add binding for Allwinner H6
 SRAM C
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
Message-ID: <20180902072643.4917-2-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.io>

The Allwinner H6 SoC's DE3 needs the SRAM C section being claimed in the
system controller to work, like A64 DE2.

As H6 and A64 system controller are quite similar, code is reused now,
and the A64 fallback compatible string is added after the H6 compatible
string.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
[fixed typo in compatible string]
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 Documentation/devicetree/bindings/sram/sunxi-sram.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
index c51ade86578c..62dd0748f0ef 100644
--- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
+++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
@@ -18,6 +18,7 @@ Required properties:
     - "allwinner,sun8i-h3-system-control"
     - "allwinner,sun50i-a64-sram-controller" (deprecated)
     - "allwinner,sun50i-a64-system-control"
+    - "allwinner,sun50i-h6-system-control", "allwinner,sun50i-a64-system-control"
 - reg : sram controller register offset + length
 
 SRAM nodes
@@ -54,6 +55,9 @@ The valid sections compatible for H3 are:
 The valid sections compatible for A64 are:
     - allwinner,sun50i-a64-sram-c
 
+The valid sections compatible for H6 are:
+    - allwinner,sun50i-h6-sram-c, allwinner,sun50i-a64-sram-c
+
 Devices using SRAM sections
 ---------------------------
 
-- 
2.18.0
