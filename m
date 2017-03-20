From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon, 20 Mar 2017 22:38:49 +0800
Subject: [PATCH] spi: sun6i: update max transfer size reported
Message-ID: <20170320143849.13213-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spi-sun6i driver have already got the ability to do large transfers.
However, the max transfer size reported is still fifo depth - 1.

Update the max transfer size reported to the max value possible.

Reported-by: Martin Ayotte <martinayotte@gmail.com>
Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/spi/spi-sun6i.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 6e9ca93db9bf..03a773a9531a 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -194,9 +194,7 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 
 static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
 {
-	struct sun6i_spi *sspi = spi_master_get_devdata(spi->master);
-
-	return sspi->fifo_depth - 1;
+	return SUN6I_MAX_XFER_SIZE - 1;
 }
 
 static int sun6i_spi_transfer_one(struct spi_master *master,
-- 
2.12.0
