From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 27 Mar 2017 22:38:46 +0800
Subject: [PATCH 1/2] drm/sun4i: Add display backend interrupt to device tree
 binding
In-Reply-To: <20170327143847.16259-1-wens@csie.org>
References: <20170327143847.16259-1-wens@csie.org>
Message-ID: <20170327143847.16259-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The display backend has an interrupt line. Add it to the device tree
binding.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index b82c00449468..57a8d0610062 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -94,6 +94,7 @@ Required properties:
     * allwinner,sun6i-a31-display-backend
     * allwinner,sun8i-a33-display-backend
   - reg: base address and size of the memory-mapped region.
+  - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the frontend and backend
     * ahb: the backend interface clock
     * mod: the backend module clock
@@ -265,6 +266,7 @@ fe0: display-frontend at 1e00000 {
 be0: display-backend at 1e60000 {
 	compatible = "allwinner,sun5i-a13-display-backend";
 	reg = <0x01e60000 0x10000>;
+	interrupts = <47>;
 	clocks = <&ahb_gates 44>, <&de_be_clk>,
 		 <&dram_gates 26>;
 	clock-names = "ahb", "mod",
-- 
2.11.0
