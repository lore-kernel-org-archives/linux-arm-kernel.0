From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:17 +0200
Subject: [PATCH 12/25] mmc/omap_hsmmc: add a const qualifier
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-13-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_probe':
	drivers/mmc/host/omap_hsmmc.c:1808: warning: initialization discards qualifiers from pointer target type

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 389a3ee..5bcd043 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1805,7 +1805,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	if (match) {
 		pdata = of_get_hsmmc_pdata(&pdev->dev);
 		if (match->data) {
-			u16 *offsetp = match->data;
+			const u16 *offsetp = match->data;
 			pdata->reg_offset = *offsetp;
 		}
 	}
-- 
1.7.10.4
