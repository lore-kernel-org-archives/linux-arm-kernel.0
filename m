From: marex@denx.de (Marek Vasut)
Date: Sun, 14 Oct 2012 04:32:55 +0200
Subject: [PATCH 1/2] spi: mxs: Assign message status after transfer finished
Message-ID: <1350181976-18233-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the current code implementing the MXS SPI driver, every transferred
message had assigned status = 0, which is not correct. Properly assign
status returned from the I/O functions.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/spi/spi-mxs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index edf1360..5a63bcd 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -480,7 +480,7 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 		first = last = 0;
 	}
 
-	m->status = 0;
+	m->status = status;
 	spi_finalize_current_message(master);
 
 	return status;
-- 
1.7.10.4
