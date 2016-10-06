From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  7 Oct 2016 00:06:21 +0800
Subject: [PATCH 1/9] drm/sun4i: sun6i-drc: Support DRC on A31 and A31s
In-Reply-To: <20161006160629.11198-1-wens@csie.org>
References: <20161006160629.11198-1-wens@csie.org>
Message-ID: <20161006160629.11198-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 and A31s also have the DRC as part of the display pipeline.
As we know virtually nothing about them, just add compatible strings
for both SoCs to the stub driver.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 2 ++
 drivers/gpu/drm/sun4i/sun6i_drc.c                             | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index b95696d748c7..5368961cd727 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -64,6 +64,8 @@ adaptive backlight control.
 
 Required properties:
   - compatible: value must be one of:
+    * allwinner,sun6i-a31-drc
+    * allwinner,sun6i-a31s-drc
     * allwinner,sun8i-a33-drc
   - reg: base address and size of the memory-mapped region.
   - interrupts: interrupt associated to this IP
diff --git a/drivers/gpu/drm/sun4i/sun6i_drc.c b/drivers/gpu/drm/sun4i/sun6i_drc.c
index bf6d846d8132..6ef707c5a719 100644
--- a/drivers/gpu/drm/sun4i/sun6i_drc.c
+++ b/drivers/gpu/drm/sun4i/sun6i_drc.c
@@ -98,6 +98,8 @@ static int sun6i_drc_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sun6i_drc_of_table[] = {
+	{ .compatible = "allwinner,sun6i-a31-drc" },
+	{ .compatible = "allwinner,sun6i-a31s-drc" },
 	{ .compatible = "allwinner,sun8i-a33-drc" },
 	{ }
 };
-- 
2.9.3
