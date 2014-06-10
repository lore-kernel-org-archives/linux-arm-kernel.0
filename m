From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 10 Jun 2014 14:30:58 +0530
Subject: [PATCH 2/3] spi: s3c64xx: remove a compilation warning with an
 assignment
In-Reply-To: <1402390859-28287-1-git-send-email-ch.naveen@samsung.com>
References: <1402390859-28287-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1402390859-28287-3-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch returns an integer error value instead of the
pointer.

"warning: return makes integer from pointer without a cast"

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Doug Anderson <dianders@chromium.org>
---
 drivers/spi/spi-s3c64xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 0c6013f..4594dde 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -817,7 +817,7 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 
 	if (!spi->dev.of_node) {
 		dev_err(&spi->dev, "device node not found\n");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	sdd = spi_master_get_devdata(spi->master);
-- 
1.7.9.5
