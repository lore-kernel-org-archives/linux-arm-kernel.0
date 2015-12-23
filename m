From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 23 Dec 2015 19:05:39 +0800
Subject: [PATCH] spi: dw: Use SPI_TMOD_TR rather than magic const 0 to set
 tmode
Message-ID: <1450868739-1093-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TMODE available value is well defined and documented in the header
file. Use it and remove the comment.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/spi/spi-dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 882cd66..c09bb74 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -425,7 +425,7 @@ static int dw_spi_setup(struct spi_device *spi)
 		chip->type = chip_info->type;
 	}
 
-	chip->tmode = 0; /* Tx & Rx */
+	chip->tmode = SPI_TMOD_TR;
 
 	if (gpio_is_valid(spi->cs_gpio)) {
 		ret = gpio_direction_output(spi->cs_gpio,
-- 
2.6.4
