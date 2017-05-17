From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 17 May 2017 09:40:48 +0200
Subject: [PATCH v3 19/21] drm/sun4i: Add compatible for the A10s pipeline
In-Reply-To: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
References: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
Message-ID: <d1bc2420845061a9c057d47a5556c621f8bcd025.1495006350.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10s has a slightly different display pipeline than the A13, with an
HDMI controller.

Add a compatible for it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
 drivers/gpu/drm/sun4i/sun4i_drv.c                             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 0832c8491895..1b74a412aec2 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -189,6 +189,7 @@ extra node.
 
 Required properties:
   - compatible: value must be one of:
+    * allwinner,sun5i-a10s-display-engine
     * allwinner,sun5i-a13-display-engine
     * allwinner,sun6i-a31-display-engine
     * allwinner,sun6i-a31s-display-engine
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 9b3e8c8d7c75..4e0e7bd542ee 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -304,6 +304,7 @@ static int sun4i_drv_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sun4i_drv_of_table[] = {
+	{ .compatible = "allwinner,sun5i-a10s-display-engine" },
 	{ .compatible = "allwinner,sun5i-a13-display-engine" },
 	{ .compatible = "allwinner,sun6i-a31-display-engine" },
 	{ .compatible = "allwinner,sun6i-a31s-display-engine" },
-- 
git-series 0.9.1
