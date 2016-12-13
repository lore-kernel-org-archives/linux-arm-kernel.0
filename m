From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 13 Dec 2016 11:09:17 +0100
Subject: [PATCH v7 3/5] drm: bridge: add support for TI ths8135
In-Reply-To: <1481623759-12786-1-git-send-email-bgolaszewski@baylibre.com>
References: <1481623759-12786-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1481623759-12786-4-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

THS8135 is a configurable video DAC, but no configuration is actually
necessary to make it work.

For now use the dumb-vga-dac driver to support it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/gpu/drm/bridge/dumb-vga-dac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index e570698..86e9f9c 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -237,6 +237,7 @@ static int dumb_vga_remove(struct platform_device *pdev)
 
 static const struct of_device_id dumb_vga_match[] = {
 	{ .compatible = "dumb-vga-dac" },
+	{ .compatible = "ti,ths8135" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dumb_vga_match);
-- 
2.9.3
