From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun,  4 Nov 2018 19:26:44 +0100
Subject: [PATCH v3 07/28] dt-bindings: display: sun4i-drm: Add H6 display
 engine compatibles
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
Message-ID: <20181104182705.18047-8-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds compatibles used in H6 display pipeline, namely for
display engine, mixer and TV TCON.

H6 display engine is somewhat similar to R40, just less TCONs and
mixer support more features.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 7854fff4fc16..62c83b351344 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -158,6 +158,7 @@ Required properties:
    * allwinner,sun9i-a80-tcon-tv
    * "allwinner,sun50i-a64-tcon-lcd", "allwinner,sun8i-a83t-tcon-lcd"
    * "allwinner,sun50i-a64-tcon-tv", "allwinner,sun8i-a83t-tcon-tv"
+   * allwinner,sun50i-h6-tcon-tv, allwinner,sun8i-r40-tcon-tv
  - reg: base address and size of memory-mapped region
  - interrupts: interrupt associated to this IP
  - clocks: phandles to the clocks feeding the TCON.
@@ -381,6 +382,7 @@ Required properties:
     * allwinner,sun8i-v3s-de2-mixer
     * allwinner,sun50i-a64-de2-mixer-0
     * allwinner,sun50i-a64-de2-mixer-1
+    * allwinner,sun50i-h6-de3-mixer-0
   - reg: base address and size of the memory-mapped region.
   - clocks: phandles to the clocks feeding the mixer
     * bus: the mixer interface clock
@@ -415,9 +417,10 @@ Required properties:
     * allwinner,sun8i-v3s-display-engine
     * allwinner,sun9i-a80-display-engine
     * allwinner,sun50i-a64-display-engine
+    * allwinner,sun50i-h6-display-engine
 
   - allwinner,pipelines: list of phandle to the display engine
-    frontends (DE 1.0) or mixers (DE 2.0) available.
+    frontends (DE 1.0) or mixers (DE 2.0/3.0) available.
 
 Example:
 
-- 
2.19.1
