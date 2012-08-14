From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 15:49:25 +0200
Subject: [PATCH 11/23] spi-atmel: fix __init/__devinit sections mismatch
In-Reply-To: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1344952177-18385-12-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/spi/spi-atmel.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 48bf3bc..d90e8fb 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -383,7 +383,7 @@ static inline int atmel_spi_xfer_can_be_chained(struct spi_transfer *xfer)
 }
 
 #if defined(CONFIG_SPI_ATMEL_DMA)
-static bool __init filter(struct dma_chan *chan, void *slave)
+static bool filter(struct dma_chan *chan, void *slave)
 {
 	struct	at_dma_slave		*sl = slave;
 
@@ -395,7 +395,7 @@ static bool __init filter(struct dma_chan *chan, void *slave)
 	}
 }
 
-static int __init atmel_spi_configure_dma(struct spi_master *master)
+static int __devinit atmel_spi_configure_dma(struct spi_master *master)
 {
 	struct atmel_spi	*as = spi_master_get_devdata(master);
 	struct device		*controller = master->dev.parent;
@@ -628,7 +628,7 @@ static void atmel_spi_disable_dma_irq(struct atmel_spi *as)
 	spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
 }
 
-static int __init atmel_spi_configure_dma(struct spi_master *master)
+static int __devinit atmel_spi_configure_dma(struct spi_master *master)
 {
 	struct atmel_spi	*as = spi_master_get_devdata(master);
 
-- 
1.7.2.5
