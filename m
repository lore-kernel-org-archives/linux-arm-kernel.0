From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 26 Mar 2013 10:27:35 +0100
Subject: [PATCH] spi: spi-s3c64xx.c Remove unused argument.
Message-ID: <1364290055-2970-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pointer to the driver data is never used to get the slave
controller data. We can delete the unused argument from the function.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/spi/spi-s3c64xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index e862ab8..7f5f8ee 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -817,7 +817,6 @@ static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
 }
 
 static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
-				struct s3c64xx_spi_driver_data *sdd,
 				struct spi_device *spi)
 {
 	struct s3c64xx_spi_csinfo *cs;
@@ -874,7 +873,7 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 
 	sdd = spi_master_get_devdata(spi->master);
 	if (!cs && spi->dev.of_node) {
-		cs = s3c64xx_get_slave_ctrldata(sdd, spi);
+		cs = s3c64xx_get_slave_ctrldata(spi);
 		spi->controller_data = cs;
 	}
 
-- 
1.7.11.7
