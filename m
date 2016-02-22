From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sun, 21 Feb 2016 22:26:35 -0300
Subject: [PATCH 2/3] dmaengine: sun4i: support module autoloading
In-Reply-To: <1456104396-13282-1-git-send-email-emilio@elopez.com.ar>
References: <1456104396-13282-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1456104396-13282-2-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emilio L?pez <emilio.lopez@collabora.co.uk>

MODULE_DEVICE_TABLE() is missing, so the module isn't auto-loading on
supported systems. This commit adds the missing line so it loads
automatically when building it as a module and running on a system
with the early sunxi DMA engine.

Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>
---
 drivers/dma/sun4i-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index 1661d518..e0df233 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -1271,6 +1271,7 @@ static const struct of_device_id sun4i_dma_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-dma" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, sun4i_dma_match);
 
 static struct platform_driver sun4i_dma_driver = {
 	.probe	= sun4i_dma_probe,
-- 
2.7.1
