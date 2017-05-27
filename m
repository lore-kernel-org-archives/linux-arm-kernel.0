From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 May 2017 18:09:36 +0200
Subject: [PATCH v4 11/11] drm/sun4i: Add compatible for the A10s pipeline
In-Reply-To: <cover.c61cbe60123a4aeb24f255bca7927218dda6283e.1495900658.git-series.maxime.ripard@free-electrons.com>
References: <cover.c61cbe60123a4aeb24f255bca7927218dda6283e.1495900658.git-series.maxime.ripard@free-electrons.com>
Message-ID: <796b6579ca9b30820ab6e2be6e2eb52d60421ea7.1495900658.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10s has a slightly different display pipeline than the A13, with an
HDMI controller.

Add a compatible for it.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
 drivers/gpu/drm/sun4i/sun4i_drv.c                             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 58fa32900184..b83e6018041d 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -210,6 +210,7 @@ extra node.
 
 Required properties:
   - compatible: value must be one of:
+    * allwinner,sun5i-a10s-display-engine
     * allwinner,sun5i-a13-display-engine
     * allwinner,sun6i-a31-display-engine
     * allwinner,sun6i-a31s-display-engine
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index cfc0b2fcb0a6..f19100c91c2b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -305,6 +305,7 @@ static int sun4i_drv_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sun4i_drv_of_table[] = {
+	{ .compatible = "allwinner,sun5i-a10s-display-engine" },
 	{ .compatible = "allwinner,sun5i-a13-display-engine" },
 	{ .compatible = "allwinner,sun6i-a31-display-engine" },
 	{ .compatible = "allwinner,sun6i-a31s-display-engine" },
-- 
git-series 0.9.1
