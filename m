From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon,  5 Mar 2018 11:04:29 +0100
Subject: [PATCH 1/4] dt-bindings: media: sun6i: Add A31 and H3 compatibles
In-Reply-To: <20180305100432.15009-1-maxime.ripard@bootlin.com>
References: <20180305100432.15009-1-maxime.ripard@bootlin.com>
Message-ID: <20180305100432.15009-2-maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The H3 has a slightly different CSI controller (no BT656, no CCI) which
looks a lot like the original A31 controller. Add a compatible for the A31,
and more specific compatible the for the H3 to be used in combination for
the A31.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 Documentation/devicetree/bindings/media/sun6i-csi.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
index 2ff47a9507a6..18a5b3068b25 100644
--- a/Documentation/devicetree/bindings/media/sun6i-csi.txt
+++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
@@ -5,7 +5,10 @@ Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
 interface and CSI1 is used for parallel interface.
 
 Required properties:
-  - compatible: value must be "allwinner,sun8i-v3s-csi"
+  - compatible: value must be one of:
+    * "allwinner,sun6i-a31-csi", along with, optionally:
+      + "allwinner,sun8i-h3-csi"
+    * "allwinner,sun8i-v3s-csi"
   - reg: base address and size of the memory-mapped region.
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the CSI
-- 
2.14.3
