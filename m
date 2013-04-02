From: tpiepho@gmail.com (Trent Piepho)
Date: Tue,  2 Apr 2013 05:19:52 -0700
Subject: [PATCH V2 09/12] spi/mxs: Remove check of spi mode bits
In-Reply-To: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
Message-ID: <1364905195-24286-9-git-send-email-tpiepho@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spi core already checks for a slave setting mode bits that we
didn't list as supported when the master was registered.  There is no
need to do it again in the master driver.

Signed-off-by: Trent Piepho <tpiepho@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/spi/spi-mxs.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 2a2147a..d71029e 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -118,9 +118,6 @@ static int mxs_spi_setup(struct spi_device *dev)
 	if (!dev->bits_per_word)
 		dev->bits_per_word = 8;
 
-	if (dev->mode & ~(SPI_CPOL | SPI_CPHA))
-		return -EINVAL;
-
 	if (dev->bits_per_word != 8)
 		return -EINVAL;
 
-- 
1.7.10.4
