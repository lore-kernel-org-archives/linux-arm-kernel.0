From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 16 Sep 2014 14:14:23 +0300
Subject: [PATCH] spi: davinci: remove empty function davinci_spi_cleanup
In-Reply-To: <20140915163841.GU7960@sirena.org.uk>
References: <20140915163841.GU7960@sirena.org.uk>
Message-ID: <1410866063-13393-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove empty function davinci_spi_cleanup().

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/spi/spi-davinci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index d493507..134fb6e 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -436,10 +436,6 @@ static int davinci_spi_setup(struct spi_device *spi)
 	return retval;
 }
 
-static void davinci_spi_cleanup(struct spi_device *spi)
-{
-}
-
 static int davinci_spi_check_error(struct davinci_spi *dspi, int int_status)
 {
 	struct device *sdev = dspi->bitbang.master->dev.parent;
@@ -951,7 +947,6 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	master->num_chipselect = pdata->num_chipselect;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 16);
 	master->setup = davinci_spi_setup;
-	master->cleanup = davinci_spi_cleanup;
 
 	dspi->bitbang.chipselect = davinci_spi_chipselect;
 	dspi->bitbang.setup_transfer = davinci_spi_setup_transfer;
-- 
1.9.1
