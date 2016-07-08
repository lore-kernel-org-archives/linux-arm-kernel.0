From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 08 Jul 2016 21:18:24 +0900
Subject: [PATCH 4/4] spi: s3c64xx: restore removed comments
In-Reply-To: <1467980304-14093-1-git-send-email-andi.shyti@samsung.com>
References: <1467980304-14093-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <1467980304-14093-5-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch a9e93e8 has erroneously removed some comments which are
important to understand why the bus frequency is multiplied by
two during the spi transfer.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 1874bc5..d1fe100 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -639,6 +639,8 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
 	if (sdd->port_conf->clk_from_cmu) {
+		/* Configure Clock */
+		/* There is half-multiplier before the SPI */
 		clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
 	} else {
 		/* Configure Clock */
-- 
2.8.1
