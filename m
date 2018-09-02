From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun,  2 Sep 2018 09:26:19 +0200
Subject: [PATCH 03/27] dt-bindings: bus: add H6 DE3 bus binding
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
Message-ID: <20180902072643.4917-4-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.io>

The Allwinner H6 DE3 bus is similar to the A64 DE2 one.

Add its compatible string with the A64 string as fallback to the
binding.

Some description of the binding is modified to make it more generic.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt b/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
index 87dfb33fb3be..ac1445b95f41 100644
--- a/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
+++ b/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
@@ -1,11 +1,14 @@
-Device tree bindings for Allwinner A64 DE2 bus
+Device tree bindings for Allwinner DE2/3 bus
 
 The Allwinner A64 DE2 is on a special bus, which needs a SRAM region (SRAM C)
-to be claimed for enabling the access.
+to be claimed for enabling the access. The DE3 on Allwinner H6 is at the same
+situation, and the binding also applies.
 
 Required properties:
 
- - compatible:		Should contain "allwinner,sun50i-a64-de2"
+ - compatible:		Should be one of:
+				- "allwinner,sun50i-a64-de2"
+				- "allwinner,sun50i-a6-de3", "allwinner,sun50i-a64-de2"
  - reg:			A resource specifier for the register space
  - #address-cells:	Must be set to 1
  - #size-cells:		Must be set to 1
-- 
2.18.0
