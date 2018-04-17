From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 17 Apr 2018 16:29:48 +0200
Subject: [PATCH v2 2/8] spi: spi-s3c64xx: Remove unused driver data
 structure tgl_spi field
In-Reply-To: <20180417142954.5507-1-s.nawrocki@samsung.com>
References: <20180417142954.5507-1-s.nawrocki@samsung.com>
 <CGME20180417143028epcas1p459b6358287256a1c060ea95847ce9fbd@epcas1p4.samsung.com>
Message-ID: <20180417142954.5507-2-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tgl_spi pointer is now unused so remove it.

Reviewed-by: Andi Shyti <andi@etezian.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 9a990bc3138a..f0e28adbbc32 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -156,7 +156,6 @@ struct s3c64xx_spi_port_config {
  * @ioclk: Pointer to the i/o clock between master and slave
  * @master: Pointer to the SPI Protocol master.
  * @cntrlr_info: Platform specific data for the controller this driver manages.
- * @tgl_spi: Pointer to the last CS left untoggled by the cs_change hint.
  * @lock: Controller specific lock.
  * @state: Set of FLAGS to indicate status.
  * @rx_dmach: Controller's DMA channel for Rx.
@@ -177,7 +176,6 @@ struct s3c64xx_spi_driver_data {
 	struct platform_device          *pdev;
 	struct spi_master               *master;
 	struct s3c64xx_spi_info  *cntrlr_info;
-	struct spi_device               *tgl_spi;
 	spinlock_t                      lock;
 	unsigned long                   sfr_start;
 	struct completion               xfer_completion;
-- 
2.14.2
