From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 16 Apr 2018 17:40:18 +0200
Subject: [PATCH 3/6] spi: spi-s3c64xx: Drop unused enable_datapath()
 function argument
In-Reply-To: <20180416154021.25626-1-s.nawrocki@samsung.com>
References: <20180416154021.25626-1-s.nawrocki@samsung.com>
 <CGME20180416154122epcas1p1ae714af12f8da08783c47fcd820c40e7@epcas1p1.samsung.com>
Message-ID: <20180416154021.25626-3-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spi pointer argument is not used now so remove it. While at it
s3c64xx_ prefix is added to the function name.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b7333a883442..e90e60bc1ecc 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -348,9 +348,8 @@ static bool s3c64xx_spi_can_dma(struct spi_master *master,
 	return xfer->len > (FIFO_LVL_MASK(sdd) >> 1) + 1;
 }

-static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
-				struct spi_device *spi,
-				struct spi_transfer *xfer, int dma_mode)
+static void s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
+				    struct spi_transfer *xfer, int dma_mode)
 {
 	void __iomem *regs = sdd->regs;
 	u32 modecfg, chcfg;
@@ -665,7 +664,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	sdd->state &= ~RXBUSY;
 	sdd->state &= ~TXBUSY;

-	enable_datapath(sdd, spi, xfer, use_dma);
+	s3c64xx_enable_datapath(sdd, xfer, use_dma);

 	/* Start the signals */
 	s3c64xx_spi_set_cs(spi, true);
--
2.14.2
