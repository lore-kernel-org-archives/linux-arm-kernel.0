From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:16 +0200
Subject: [PATCH 11/25] dmaengine: at_hdmac: add a few const qualifiers
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-12-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/dma/at_hdmac.c: In function 'at_dma_get_driver_data':
	drivers/dma/at_hdmac.c:1228: warning: return discards qualifiers from pointer target type

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/dma/at_hdmac.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 7292aa8..7e9d265 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1217,7 +1217,7 @@ static const struct platform_device_id atdma_devtypes[] = {
 	}
 };
 
-static inline struct at_dma_platform_data * __init at_dma_get_driver_data(
+static inline const struct at_dma_platform_data * __init at_dma_get_driver_data(
 						struct platform_device *pdev)
 {
 	if (pdev->dev.of_node) {
@@ -1255,7 +1255,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	int			irq;
 	int			err;
 	int			i;
-	struct at_dma_platform_data *plat_dat;
+	const struct at_dma_platform_data *plat_dat;
 
 	/* setup platform data for each SoC */
 	dma_cap_set(DMA_MEMCPY, at91sam9rl_config.cap_mask);
-- 
1.7.10.4
