From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  8 Dec 2009 22:14:10 +0100
Subject: [PATCH 5/5] spi-imx: don't access struct device directly but use
	dev_get_platdata
In-Reply-To: <1260306850-14945-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091208211258.GA13706@pengutronix.de>
	<1260306850-14945-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260306850-14945-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260306850-14945-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260306850-14945-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1260306850-14945-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also there is no casting needed to assign a void pointer.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi_imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 59b3a30..ea6d701 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -492,7 +492,7 @@ static int __init spi_imx_probe(struct platform_device *pdev)
 	struct resource *res;
 	int i, ret;
 
-	mxc_platform_info = (struct spi_imx_master *)pdev->dev.platform_data;
+	mxc_platform_info = dev_get_platdata(&pdev->dev);
 	if (!mxc_platform_info) {
 		dev_err(&pdev->dev, "can't get the platform data\n");
 		return -EINVAL;
-- 
1.6.5.2
