From: y@pengutronix.de (y at pengutronix.de)
Date: Fri, 13 Jul 2012 14:32:12 +0200
Subject: [PATCH 09/11] mmc/omap_hsmmc: add a const qualifier
In-Reply-To: <1342182734-321-1-git-send-email-y>
References: <1342182734-321-1-git-send-email-y>
Message-ID: <1342182734-321-11-git-send-email-y>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

This prepares of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_probe':
	drivers/mmc/host/omap_hsmmc.c:1808: warning: initialization discards qualifiers from pointer target type

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Venkatraman S <svenkatr@ti.com>
Cc: Balaji T K <balajitk@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-omap at vger.kernel.org
Cc: linux-mmc at vger.kernel.org
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
