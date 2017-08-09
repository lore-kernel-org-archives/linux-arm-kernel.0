From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  9 Aug 2017 16:56:24 +0800
Subject: [PATCH 1/4] dt-bindings: add binding for Allwinner A64 SRAM
 controller and SRAM C
In-Reply-To: <20170809085627.32687-1-icenowy@aosc.io>
References: <20170809085627.32687-1-icenowy@aosc.io>
Message-ID: <20170809085627.32687-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The display engine on Allwinner A64 wants to claim the SRAM C section.

Add a SRAM controller compatible for A64, and a SRAM section compatible
for its SRAM C.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/sram/sunxi-sram.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
index 8d5665468fe7..f34b3a553d7c 100644
--- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
+++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
@@ -9,7 +9,9 @@ Controller Node
 ---------------
 
 Required properties:
-- compatible : "allwinner,sun4i-a10-sram-controller"
+- compatible : should be:
+    - "allwinner,sun4i-a10-sram-controller"
+    - "allwinner,sun50i-a64-sram-controller"
 - reg : sram controller register offset + length
 
 SRAM nodes
@@ -22,10 +24,13 @@ Each SRAM will have SRAM sections that are going to be handled by the
 SRAM controller as subnodes. These sections are represented following
 once again the representation described in the mmio-sram binding.
 
-The valid sections compatible are:
+The valid sections compatible for A10 are:
     - allwinner,sun4i-a10-sram-a3-a4
     - allwinner,sun4i-a10-sram-d
 
+The valid sections compatible for A64 are:
+    - allwinner,sun50i-a64-sram-c
+
 Devices using SRAM sections
 ---------------------------
 
-- 
2.13.0
