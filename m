From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon,  3 Sep 2018 21:34:32 +0800
Subject: [PATCH 1/3] dt-bindings: change the A64 HDMI PHY binding to R40
In-Reply-To: <20180903133434.58188-1-icenowy@aosc.io>
References: <20180903133434.58188-1-icenowy@aosc.io>
Message-ID: <20180903133434.58188-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By experiment, the A64 HDMi PHY doesn't support the PLL-VIDEO mux
introduced in R40, although it has two PLL-VIDEOs.

Change the A64 HDMI PHY binding to R40 one.

This binding is introduced in v4.19, which is still in RC stage, so we
have change to fix it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../devicetree/bindings/display/sunxi/sun4i-drm.txt         | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index f8773ecb7525..de6814a5aba3 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -103,7 +103,7 @@ Required properties:
   - compatible: value must be one of:
     * allwinner,sun8i-a83t-hdmi-phy
     * allwinner,sun8i-h3-hdmi-phy
-    * allwinner,sun50i-a64-hdmi-phy
+    * allwinner,sun8i-r40-hdmi-phy
   - reg: base address and size of memory-mapped region
   - clocks: phandles to the clocks feeding the HDMI PHY
     * bus: the HDMI PHY interface clock
@@ -112,9 +112,9 @@ Required properties:
   - resets: phandle to the reset controller driving the PHY
   - reset-names: must be "phy"
 
-H3 and A64 HDMI PHY require additional clocks:
+H3 and R40 HDMI PHY require additional clocks:
   - pll-0: parent of phy clock
-  - pll-1: second possible phy clock parent (A64 only)
+  - pll-1: second possible phy clock parent (R40 only)
 
 TV Encoder
 ----------
-- 
2.18.0
