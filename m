From: y@pengutronix.de (y at pengutronix.de)
Date: Fri, 13 Jul 2012 14:32:11 +0200
Subject: [PATCH 08/11] spi/spi-omap2-mcspi: add a const qualifier
In-Reply-To: <1342182734-321-1-git-send-email-y>
References: <1342182734-321-1-git-send-email-y>
Message-ID: <1342182734-321-10-git-send-email-y>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

This prepares of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/spi/spi-omap2-mcspi.c: In function 'omap2_mcspi_probe':
	drivers/spi/spi-omap2-mcspi.c:1118: warning: assignment discards qualifiers from pointer target type

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: spi-devel-general at lists.sourceforge.net
---
 drivers/spi/spi-omap2-mcspi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 0c73dd4..3455769 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1087,7 +1087,7 @@ MODULE_DEVICE_TABLE(of, omap_mcspi_of_match);
 static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
 {
 	struct spi_master	*master;
-	struct omap2_mcspi_platform_config *pdata;
+	const struct omap2_mcspi_platform_config *pdata;
 	struct omap2_mcspi	*mcspi;
 	struct resource		*r;
 	int			status = 0, i;
-- 
1.7.10.4
