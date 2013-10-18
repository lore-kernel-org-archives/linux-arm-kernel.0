From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 18 Oct 2013 18:54:21 +0800
Subject: [PATCH v2 8/8] mmc: sdhci: remove unneeded call when have preset
 value quirk
In-Reply-To: <1382093661-4074-1-git-send-email-b29396@freescale.com>
References: <1382093661-4074-1-git-send-email-b29396@freescale.com>
Message-ID: <1382093661-4074-9-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unneeded call of call sdhci_enable_preset_value when having
SDHCI_QUIRK2_PRESET_VALUE_BROKEN.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cbde17d..a21a710 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1435,7 +1435,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 	}
 
 	if (host->version >= SDHCI_SPEC_300 &&
-		(ios->power_mode == MMC_POWER_UP))
+		(ios->power_mode == MMC_POWER_UP) &&
+		!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
 		sdhci_enable_preset_value(host, false);
 
 	sdhci_set_clock(host, ios->clock);
-- 
1.7.2.rc3
