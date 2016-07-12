From: andi.shyti@samsung.com (Andi Shyti)
Date: Tue, 12 Jul 2016 19:02:15 +0900
Subject: [PATCH v3 6/7] spi: s3c64xx: restore removed comments
In-Reply-To: <1468317736-18841-1-git-send-email-andi.shyti@samsung.com>
References: <1468317736-18841-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <1468317736-18841-7-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch a9e93e8 has erroneously removed some comments which are
important to understand why the bus frequency is multiplied by
two during the spi transfer.

Reword the previous comment to a more appropriate message.

Suggested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Reviewed-by: Michael Turquette <mturquette@baylibre.com>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 6da663f..5bedafc 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -639,6 +639,7 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
 	if (sdd->port_conf->clk_from_cmu) {
+		/* The src_clk clock is divided internally by 2 */
 		clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
 	} else {
 		/* Configure Clock */
-- 
2.8.1
