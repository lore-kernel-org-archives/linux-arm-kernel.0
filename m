From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 23 Feb 2012 16:56:46 +0530
Subject: [PATCH v2 3/6] mmc: omap_hsmmc: Use OMAP_HSMMC_SUPPORTS_DUAL_VOLT
 flag to remove host->id based hardcoding
In-Reply-To: <1329996409-26861-1-git-send-email-rnayak@ti.com>
References: <1329996409-26861-1-git-send-email-rnayak@ti.com>
Message-ID: <1329996409-26861-4-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Balaji T K <balajitk@ti.com>

Use OMAP_HSMMC_SUPPORTS_DUAL_VOLT flag instead of host->id
for identifying SD bus voltage capabilities.

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Tested-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9955aee..91faf42 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -650,7 +650,7 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
 			OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE);
 
-	if (host->id == OMAP_MMC1_DEVID) {
+	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
 		if (host->power_mode != MMC_POWER_OFF &&
 		    (1 << ios->vdd) <= MMC_VDD_23_24)
 			hctl = SDVS18;
-- 
1.7.1
