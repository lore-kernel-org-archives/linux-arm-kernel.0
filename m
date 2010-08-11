From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 11 Aug 2010 21:21:51 +0300
Subject: [PATCH v4 6/8] omap: hsmmc: remove unused variable
In-Reply-To: <1281550913-17633-1-git-send-email-ohad@wizery.com>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
Message-ID: <1281550913-17633-7-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this go away:

drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_suspend':
drivers/mmc/host/omap_hsmmc.c:2328: warning: unused variable 'state'

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/host/omap_hsmmc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b032828..d50e917 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2272,7 +2272,6 @@ static int omap_hsmmc_suspend(struct device *dev)
 	int ret = 0;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
-	pm_message_t state = PMSG_SUSPEND; /* unused by MMC core */
 
 	if (host && host->suspended)
 		return 0;
-- 
1.7.0.4
