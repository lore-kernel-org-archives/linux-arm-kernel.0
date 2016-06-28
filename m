From: andi.shyti@samsung.com (Andi Shyti)
Date: Tue, 28 Jun 2016 11:41:15 +0900
Subject: [PATCH v2 5/5] spi: s3c64xx: use unsigned type for fifo handling
 variables
In-Reply-To: <1467081676-8442-1-git-send-email-andi.shyti@samsung.com>
References: <1467081676-8442-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <1467081676-8442-6-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'quirks' variable cannot ever be negative, therefore use u8
instead of int. The 8 bit size is given from the fact that
currently the quirks variable has very few statuses.

The rx_lvl_offset and tx_st_done store shift values, so that u8
is a proper size.

fifo_lvl_mask stores a series of masks, to be in we will keep the
32 bit size.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 6d8486f..6c9503a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -150,10 +150,10 @@ struct s3c64xx_spi_dma_data {
  * which is provided as driver data to the driver.
  */
 struct s3c64xx_spi_port_config {
-	int	fifo_lvl_mask[MAX_SPI_PORTS];
-	int	rx_lvl_offset;
-	int	tx_st_done;
-	int	quirks;
+	u32	fifo_lvl_mask[MAX_SPI_PORTS];
+	u8	rx_lvl_offset;
+	u8	tx_st_done;
+	u8	quirks;
 	bool	high_speed;
 	bool	clk_from_cmu;
 };
-- 
2.8.1
