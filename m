From: matthias.bgg@kernel.org (matthias.bgg at kernel.org)
Date: Fri, 16 Nov 2018 13:54:43 +0100
Subject: [PATCH v5 06/12] drm/mediatek: update dt-bindings
In-Reply-To: <20181116125449.23581-1-matthias.bgg@kernel.org>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
Message-ID: <20181116125449.23581-7-matthias.bgg@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <mbrugger@suse.com>

Add mmsys bindings description.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 .../display/mediatek/mediatek,disp.txt        | 30 +++++++++++--------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
index 8469de510001..4b008d992398 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
@@ -27,20 +27,24 @@ Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt.
 
 Required properties (all function blocks):
 - compatible: "mediatek,<chip>-disp-<function>", one of
-	"mediatek,<chip>-disp-ovl"   - overlay (4 layers, blending, csc)
-	"mediatek,<chip>-disp-rdma"  - read DMA / line buffer
-	"mediatek,<chip>-disp-wdma"  - write DMA
-	"mediatek,<chip>-disp-color" - color processor
-	"mediatek,<chip>-disp-aal"   - adaptive ambient light controller
-	"mediatek,<chip>-disp-gamma" - gamma correction
-	"mediatek,<chip>-disp-merge" - merge streams from two RDMA sources
-	"mediatek,<chip>-disp-split" - split stream to two encoders
-	"mediatek,<chip>-disp-ufoe"  - data compression engine
-	"mediatek,<chip>-dsi"        - DSI controller, see mediatek,dsi.txt
-	"mediatek,<chip>-dpi"        - DPI controller, see mediatek,dpi.txt
-	"mediatek,<chip>-disp-mutex" - display mutex
-	"mediatek,<chip>-disp-od"    - overdrive
+	"mediatek,<chip>-disp-ovl"		- overlay (4 layers, blending, csc)
+	"mediatek,<chip>-disp-rdma"		- read DMA / line buffer
+	"mediatek,<chip>-disp-wdma"		- write DMA
+	"mediatek,<chip>-disp-color"		- color processor
+	"mediatek,<chip>-disp-aal"		- adaptive ambient light controller
+	"mediatek,<chip>-disp-gamma"		- gamma correction
+	"mediatek,<chip>-disp-merge"		- merge streams from two RDMA sources
+	"mediatek,<chip>-disp-split"		- split stream to two encoders
+	"mediatek,<chip>-disp-ufoe"		- data compression engine
+	"mediatek,<chip>-dsi"			- DSI controller, see mediatek,dsi.txt
+	"mediatek,<chip>-dpi"			- DPI controller, see mediatek,dpi.txt
+	"mediatek,<chip>-disp-mutex"		- display mutex
+	"mediatek,<chip>-disp-od"		- overdrive
+	"mediatek,<chip>-mmsys", "syscon"	- provide clocks and components management
   the supported chips are mt2701, mt2712 and mt8173.
+  For mt7623, compatible must be:
+	"mediatek,mt7623-<component>" , "mediatek,mt2701-<component>"
+
 - reg: Physical base address and length of the function block register space
 - interrupts: The interrupt signal from the function block (required, except for
   merge and split function blocks).
-- 
2.19.1
