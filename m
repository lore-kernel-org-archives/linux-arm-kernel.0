From: y@pengutronix.de (y at pengutronix.de)
Date: Fri, 13 Jul 2012 14:32:10 +0200
Subject: [PATCH 07/11] dmaengine: at_hdmac: add a few const qualifiers
In-Reply-To: <1342182734-321-1-git-send-email-y>
References: <1342182734-321-1-git-send-email-y>
Message-ID: <1342182734-321-9-git-send-email-y>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

This prepares of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/dma/at_hdmac.c: In function 'at_dma_get_driver_data':
	drivers/dma/at_hdmac.c:1228: warning: return discards qualifiers from pointer target type

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
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
