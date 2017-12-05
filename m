From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  5 Dec 2017 16:10:15 +0100
Subject: [PATCH v3 03/15] dt-bindings: display: sun4i-drm: Add LVDS properties
In-Reply-To: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
Message-ID: <17851ba6277b69aa9cd81de5eead62bfed271661.1512486553.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clocks and resets supposed to drive the LVDS logic in the display
engine have been overlooked when the driver was first introduced.

Add those additional resources to the binding, and we'll deal with the ABI
stability in the code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 8 +++++++-
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 50cc72ee1168..d4259a4f5171 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -121,6 +121,14 @@ Required properties:
 On SoCs other than the A33 and V3s, there is one more clock required:
    - 'tcon-ch1': The clock driving the TCON channel 1
 
+On SoCs that support LVDS (all SoCs but the A13, H3, H5 and V3s), you
+need one more reset line:
+   - 'lvds': The reset line driving the LVDS logic
+
+And on the SoCs newer than the A31 (sun6i and sun8i families), you
+need one more clock line:
+   - 'lvds-pll': The PLL that can be used to drive the LVDS clock
+
 DRC
 ---
 
-- 
git-series 0.9.1
