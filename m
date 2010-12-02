From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu,  2 Dec 2010 18:47:37 +0100
Subject: [PATCH 9/9] spi/pxa2xx: pass of_node to spi device and set a parent
	device
In-Reply-To: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
References: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1291312057-7933-10-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the of_node will auto-publish devices which are added to the device
tree.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/spi/pxa2xx_spi.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 9ca6454..9592883 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1556,6 +1556,10 @@ static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
 	drv_data->pdev = pdev;
 	drv_data->ssp = ssp;
 
+	master->dev.parent = &pdev->dev;
+#ifdef CONFIG_OF
+	master->dev.of_node = pdev->dev.of_node;
+#endif
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
-- 
1.7.3.2
