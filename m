From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Feb 2010 16:51:25 -0800
Subject: [PATCH 07/19] omap_hsmmc: Fix disable timeouts
In-Reply-To: <20100212004844.24958.29506.stgit@baageli.muru.com>
References: <20100212004844.24958.29506.stgit@baageli.muru.com>
Message-ID: <20100212005124.24958.22653.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Adrian Hunter <adrian.hunter@nokia.com>

Disable timeouts are in msecs not jiffies.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e15d0f4..cb94044 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1620,7 +1620,7 @@ static int omap_hsmmc_enabled_to_disabled(struct omap_hsmmc_host *host)
 	if (host->power_mode == MMC_POWER_OFF)
 		return 0;
 
-	return msecs_to_jiffies(OMAP_MMC_SLEEP_TIMEOUT);
+	return OMAP_MMC_SLEEP_TIMEOUT;
 }
 
 /* Handler for [DISABLED -> REGSLEEP / CARDSLEEP] transition */
@@ -1663,7 +1663,7 @@ static int omap_hsmmc_disabled_to_sleep(struct omap_hsmmc_host *host)
 	    mmc_slot(host).card_detect ||
 	    (mmc_slot(host).get_cover_state &&
 	     mmc_slot(host).get_cover_state(host->dev, host->slot_id)))
-		return msecs_to_jiffies(OMAP_MMC_OFF_TIMEOUT);
+		return OMAP_MMC_OFF_TIMEOUT;
 
 	return 0;
 }
