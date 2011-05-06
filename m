From: adrian.hunter@nokia.com (Adrian Hunter)
Date: Fri,  6 May 2011 12:14:02 +0300
Subject: [PATCH V2 03/16] mmc: omap_hsmmc: move hardcoded frequency constants
	to definition block
In-Reply-To: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
Message-ID: <1304673255-31634-4-git-send-email-adrian.hunter@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Move the min and max frequency constants to the definition block in the source
file.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 0fed8eb..c8aab47 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -118,6 +118,8 @@
 
 #define MMC_TIMEOUT_MS		20
 #define OMAP_MMC_MASTER_CLOCK	96000000
+#define OMAP_MMC_MIN_CLOCK	400000
+#define OMAP_MMC_MAX_CLOCK	52000000
 #define DRIVER_NAME		"omap_hsmmc"
 
 /* Timeouts for entering power saving states on inactivity, msec */
@@ -2091,8 +2093,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	if (mmc_slot(host).vcc_aux_disable_is_sleep)
 		mmc_slot(host).no_off = 1;
 
-	mmc->f_min	= 400000;
-	mmc->f_max	= 52000000;
+	mmc->f_min	= OMAP_MMC_MIN_CLOCK;
+	mmc->f_max	= OMAP_MMC_MAX_CLOCK;
 
 	spin_lock_init(&host->irq_lock);
 
-- 
1.7.0.4
