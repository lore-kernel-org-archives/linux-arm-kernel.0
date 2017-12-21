From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Dec 2017 12:02:29 +0100
Subject: [PATCH v5 03/12] dt-bindings: display: sun4i-drm: Add LVDS properties
In-Reply-To: <cover.e5a47cc96ec5274dd932daa2bde47df073087da9.1513854122.git-series.maxime.ripard@free-electrons.com>
References: <cover.e5a47cc96ec5274dd932daa2bde47df073087da9.1513854122.git-series.maxime.ripard@free-electrons.com>
Message-ID: <ddbde28fe2e4f21412974e4c69fbfe1c5ff9383f.1513854122.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clocks and resets supposed to drive the LVDS logic in the display
engine have been overlooked when the driver was first introduced.

Add those additional resources to the binding, and we'll deal with the ABI
stability in the code.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt |  9 +++++++-
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 50cc72ee1168..1e21cfaac9e2 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -121,6 +121,15 @@ Required properties:
 On SoCs other than the A33 and V3s, there is one more clock required:
    - 'tcon-ch1': The clock driving the TCON channel 1
 
+On SoCs that support LVDS (all SoCs but the A13, H3, H5 and V3s), you
+need one more reset line:
+   - 'lvds': The reset line driving the LVDS logic
+
+And on the SoCs newer than the A31 (sun6i and sun8i families), you
+need one more clock line:
+   - 'lvds-alt': An alternative clock source, separate from the TCON channel 0
+                 clock, that can be used to drive the LVDS clock
+
 DRC
 ---
 
-- 
git-series 0.9.1
