From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 27 Apr 2018 16:14:42 +0800
Subject: [PATCH v2 1/6] dt-bindings: gpu: mali-utgard: add mediatek,
 mt7623-mali compatible
In-Reply-To: <cover.1524816502.git.sean.wang@mediatek.com>
References: <cover.1524816502.git.sean.wang@mediatek.com>
Message-ID: <7ab060c2e9ef2b220fc62913b8936b706dfaf202.1524816502.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

The MediaTek MT7623 SoC contains a Mali-450, so add a compatible for it
and define its own vendor-specific properties.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index 99d1c0a..656068f 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -19,6 +19,7 @@ Required properties:
       + rockchip,rk3228-mali
       + rockchip,rk3328-mali
       + stericsson,db8500-mali
+      + mediatek,mt7623-mali
 
   - reg: Physical base address and length of the GPU registers
 
@@ -89,6 +90,14 @@ to specify one more vendor-specific compatible, among:
       * interrupt-names and interrupts:
         + combined: combined interrupt of all of the above lines
 
+  - mediatek,mt7623-mali
+     Required properties:
+      * resets: phandle to the reset line for the GPU
+      * mediatek,larb: phandle pointed to the local arbiter used to control the
+	access to external memory on the SoC.
+	see Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
+	for details
+
 Example:
 
 mali: gpu at 1c40000 {
-- 
2.7.4
