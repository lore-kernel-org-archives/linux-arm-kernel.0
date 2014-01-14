From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 14 Jan 2014 15:50:08 +0200
Subject: [PATCH] spi: davinci: fix build warning when printing resource_size_t
 vars
In-Reply-To: <20140112110916.GR15937@n2100.arm.linux.org.uk>
References: <20140112110916.GR15937@n2100.arm.linux.org.uk>
Message-ID: <1389707408-24785-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use %pa format specifier when printing variables of resource_size_t type
to fix build warnings:
drivers/spi/spi-davinci.c:966:3: warning: format '%d' expects argument of type 'int', but argument 3 has type 'resource_size_t'
drivers/spi/spi-davinci.c:966:3: warning: format '%d' expects argument of type 'int', but argument 4 has type 'resource_size_t'

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/spi/spi-davinci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 50b2d88..d3f6386 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -963,8 +963,8 @@ static int davinci_spi_probe(struct platform_device *pdev)
 			goto free_clk;
 
 		dev_info(&pdev->dev, "DMA: supported\n");
-		dev_info(&pdev->dev, "DMA: RX channel: %d, TX channel: %d, "
-				"event queue: %d\n", dma_rx_chan, dma_tx_chan,
+		dev_info(&pdev->dev, "DMA: RX channel: %pa, TX channel: %pa, "
+				"event queue: %d\n", &dma_rx_chan, &dma_tx_chan,
 				pdata->dma_event_q);
 	}
 
-- 
1.7.9.5
