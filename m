From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 08 Jul 2016 23:46:40 +0900
Subject: [PATCH v2 6/7] spi: s3c64xx: restore removed comments
In-Reply-To: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <1467989201-14661-7-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch a9e93e8 has erroneously removed some comments which are
important to understand why the bus frequency is multiplied by
two during the spi transfer.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 6da663f..32b66f0 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -639,6 +639,7 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
 	if (sdd->port_conf->clk_from_cmu) {
+		/* There is half-multiplier before the SPI */
 		clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
 	} else {
 		/* Configure Clock */
-- 
2.8.1
