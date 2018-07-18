From: jagan@amarulasolutions.com (Jagan Teki)
Date: Wed, 18 Jul 2018 16:24:43 +0530
Subject: [PATCH v3 03/18] dt-bindings: display: Add compatible for A64 DE2
 tcon1 blocks
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Message-ID: <20180718105458.22304-4-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 has DE2 pipeline with tcon0 and tcon1 block
which is similar Allwinner A83T.

This patch adds dt-binding documentation for A64 DE2 tcon1 blocks.

Mixer1 has different configuration for A64 so use separate compatible
but tcon1 has similar behaviour with A83T so add fallback compatible.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v3:
- collect Rob r-w-b tag
Changes for v2:
- Add fallback compatible for tcon1
- Add separate compatible for mixer1 

 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index f8773ecb7525..3594378fbe72 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -151,6 +151,7 @@ Required properties:
    * allwinner,sun8i-v3s-tcon
    * allwinner,sun9i-a80-tcon-lcd
    * allwinner,sun9i-a80-tcon-tv
+   * "allwinner,sun50i-a64-tcon-tv", "allwinner,sun8i-a83t-tcon-tv"
  - reg: base address and size of memory-mapped region
  - interrupts: interrupt associated to this IP
  - clocks: phandles to the clocks feeding the TCON.
@@ -370,6 +371,7 @@ Required properties:
     * allwinner,sun8i-a83t-de2-mixer-1
     * allwinner,sun8i-h3-de2-mixer-0
     * allwinner,sun8i-v3s-de2-mixer
+    * allwinner,sun50i-a64-de2-mixer-1"
   - reg: base address and size of the memory-mapped region.
   - clocks: phandles to the clocks feeding the mixer
     * bus: the mixer interface clock
@@ -403,6 +405,7 @@ Required properties:
     * allwinner,sun8i-r40-display-engine
     * allwinner,sun8i-v3s-display-engine
     * allwinner,sun9i-a80-display-engine
+    * allwinner,sun50i-a64-display-engine
 
   - allwinner,pipelines: list of phandle to the display engine
     frontends (DE 1.0) or mixers (DE 2.0) available.
-- 
2.17.1
