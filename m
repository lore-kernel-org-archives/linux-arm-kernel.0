From: y@pengutronix.de (y at pengutronix.de)
Date: Fri, 13 Jul 2012 14:32:04 +0200
Subject: [PATCH 01/11] spi/imx: make spi_imx_data.devtype_data member point to
 const data
In-Reply-To: <1342182734-321-1-git-send-email-y>
References: <1342182734-321-1-git-send-email-y>
Message-ID: <1342182734-321-3-git-send-email-y>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

This prepares of_device_id.data becoming const. Without this change the
following warning would occur:

	drivers/spi/spi-imx.c: In function spi_imx_probe:
	drivers/spi/spi-imx.c:814:24: warning: assignment discards const qualifier from pointer target type [enabled by default]

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: spi-devel-general at lists.sourceforge.net
---
 drivers/spi/spi-imx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 47877d6..b09fc77 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -97,7 +97,7 @@ struct spi_imx_data {
 	const void *tx_buf;
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
 
-	struct spi_imx_devtype_data *devtype_data;
+	const struct spi_imx_devtype_data *devtype_data;
 	int chipselect[0];
 };
 
-- 
1.7.10.4
