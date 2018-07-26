From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 27 Jul 2018 01:12:52 +0800
Subject: [PATCH v3.1 05/10] dt-bindings: display: Add compatible for A64 HDMI
In-Reply-To: <20180726171257.6688-1-icenowy@aosc.io>
References: <20180726171257.6688-1-icenowy@aosc.io>
Message-ID: <20180726171257.6688-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

The HDMI controller on Allwinner A64 is similar on the one on
H3/H5/A83T (although the PHY is different with A83T).

Add A64 compatible and append A83T compatible as fallback.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
[Icenowy: refactor commit log]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes for v3.1:
- Refactor commit log to make it more clear.
Changes for v3:
- collect Rob r-w-b tag
Changes for v2:
- Add fallback compatible

 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 7b79c5e3dffc..fdb8fb29033f 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -78,6 +78,7 @@ Required properties:
 
   - compatible: value must be one of:
     * "allwinner,sun8i-a83t-dw-hdmi"
+    * "allwinner,sun50i-a64-dw-hdmi", "allwinner,sun8i-a83t-dw-hdmi"
   - reg: base address and size of memory-mapped region
   - reg-io-width: See dw_hdmi.txt. Shall be 1.
   - interrupts: HDMI interrupt number
-- 
2.18.0
