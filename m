From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun,  4 Nov 2018 19:27:02 +0100
Subject: [PATCH v3 25/28] dt-bindings: display: sun4i-drm: document H6 TCON TOP
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
Message-ID: <20181104182705.18047-26-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.io>

Allwinner H6 SoC has a cut down version of TCON TOP.

Add binding documentation for it.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
[expanded description]
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../bindings/display/sunxi/sun4i-drm.txt           | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 478b288eebd9..f426bdb42f18 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -228,24 +228,26 @@ It allows display pipeline to be configured in very different ways:
                  \ [3] TCON-TV1 [1] - TVE1/RGB
 
 Note that both TCON TOP references same physical unit. Both mixers can be
-connected to any TCON.
+connected to any TCON. Not all TCON TOP variants support all features.
 
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun8i-r40-tcon-top
+    * allwinner,sun50i-h6-tcon-top
   - reg: base address and size of the memory-mapped region.
   - clocks: phandle to the clocks feeding the TCON TOP
     * bus: TCON TOP interface clock
     * tcon-tv0: TCON TV0 clock
-    * tve0: TVE0 clock
-    * tcon-tv1: TCON TV1 clock
-    * tve1: TVE0 clock
-    * dsi: MIPI DSI clock
+    * tve0: TVE0 clock (R40 only)
+    * tcon-tv1: TCON TV1 clock (R40 only)
+    * tve1: TVE0 clock (R40 only)
+    * dsi: MIPI DSI clock (R40 only)
   - clock-names: clock name mentioned above
   - resets: phandle to the reset line driving the TCON TOP
   - #clock-cells : must contain 1
   - clock-output-names: Names of clocks created for TCON TV0 channel clock,
-    TCON TV1 channel clock and DSI channel clock, in that order.
+    TCON TV1 channel clock (R40 only) and DSI channel clock (R40 only), in
+    that order.
 
 - ports: A ports node with endpoint definitions as defined in
     Documentation/devicetree/bindings/media/video-interfaces.txt. 6 ports should
-- 
2.19.1
