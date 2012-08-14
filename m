From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 15:49:17 +0200
Subject: [PATCH 03/23] spi/atmel_spi: trivial: change some comments
In-Reply-To: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1344952177-18385-4-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

To be accurate with introduction of dmaengine enabled driver.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-atmel.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 16d6a83..7c41b07 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -201,6 +201,7 @@ struct atmel_spi {
 	struct spi_transfer	*next_transfer;
 	unsigned long		next_remaining_bytes;
 
+	/* scratch buffer */
 	void			*buffer;
 	dma_addr_t		buffer_dma;
 };
@@ -364,7 +365,7 @@ static void atmel_spi_next_xfer_data(struct spi_master *master,
 }
 
 /*
- * Submit next transfer for DMA.
+ * Submit next transfer for PDC.
  * lock is held, spi irq is blocked
  */
 static void atmel_spi_next_xfer(struct spi_master *master,
-- 
1.7.2.5
