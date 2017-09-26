From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 26 Sep 2017 14:59:13 +0800
Subject: [PATCH v2 07/13] dt-bindings: display: sun4i: Add binding for A31
 HDMI controller
In-Reply-To: <20170926065919.24446-1-wens@csie.org>
References: <20170926065919.24446-1-wens@csie.org>
Message-ID: <20170926065919.24446-8-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HDMI controller in the A31 SoC is slightly different from the
earlier version. In addition to the TMDS clock and DDC controls,
this version now takes a second DDC clock input.

Add a compatible string for it, and add the DDC clock input to the
list of clocks required.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 92441086caba..46df3b78ae9e 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -41,14 +41,17 @@ CEC. It is one end of the pipeline.
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun5i-a10s-hdmi
+    * allwinner,sun6i-a31-hdmi
   - reg: base address and size of memory-mapped region
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the HDMI encoder
     * ahb: the HDMI interface clock
     * mod: the HDMI module clock
+    * ddc: the HDMI ddc clock (A31 only)
     * pll-0: the first video PLL
     * pll-1: the second video PLL
   - clock-names: the clock names mentioned above
+  - resets: phandle to the reset control for the HDMI encoder (A31 only)
   - dmas: phandles to the DMA channels used by the HDMI encoder
     * ddc-tx: The channel for DDC transmission
     * ddc-rx: The channel for DDC reception
-- 
2.14.1
