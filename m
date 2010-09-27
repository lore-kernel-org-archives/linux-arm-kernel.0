From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:54 +0200
Subject: [PATCH 18/40] spi/imx: default to m on platforms that have such
	devices
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-18-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Jason Wang <jason77.wang@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 91c2f4f..30aea6d 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -147,6 +147,7 @@ config SPI_IMX
 	tristate "Freescale i.MX SPI controllers"
 	depends on ARCH_MXC
 	select SPI_BITBANG
+	default m if IMX_HAVE_PLATFORM_SPI_IMX
 	help
 	  This enables using the Freescale i.MX SPI controllers in master
 	  mode.
-- 
1.7.2.3
