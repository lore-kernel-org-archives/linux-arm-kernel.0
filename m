From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 13 Nov 2014 11:52:40 +0100
Subject: [PATCH 2/7] dmaengine: at_xdmac: remove chancnt affectation
In-Reply-To: <1415875965-6905-1-git-send-email-ludovic.desroches@atmel.com>
References: <1415875965-6905-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1415875965-6905-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove chancnt affectation since it is done in dma_async_device_regiser.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/dma/at_xdmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 1f53d92..fcecbad 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1393,7 +1393,6 @@ static int at_xdmac_probe(struct platform_device *pdev)
 	atxdmac->dma.device_prep_dma_memcpy		= at_xdmac_prep_dma_memcpy;
 	atxdmac->dma.device_prep_slave_sg		= at_xdmac_prep_slave_sg;
 	atxdmac->dma.device_control			= at_xdmac_control;
-	atxdmac->dma.chancnt				= nr_channels;
 	atxdmac->dma.device_slave_caps			= at_xdmac_device_slave_caps;
 
 	/* Disable all chans and interrupts. */
-- 
2.0.3
