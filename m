From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Thu, 2 Mar 2017 17:47:28 +0800
Subject: [PATCH 7/9] mmc: sdhci-of-esdhc: add delay between tuning cycles
In-Reply-To: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
References: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1488448050-7574-8-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's observed that eSDHC needed delay between tuning cycles for
HS200 successful tuning. This patch is to add the quirk
SDHCI_QUIRK2_DELAY_BETWEEN_TUNING_CYCLES to fix it.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index b26a780..3672c5a 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -823,6 +823,8 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 		host->quirks2 |= SDHCI_QUIRK2_BROKEN_HOST_CONTROL;
 	}
 
+	host->quirks2 |= SDHCI_QUIRK2_DELAY_BETWEEN_TUNING_CYCLES;
+
 	/* call to generic mmc_of_parse to support additional capabilities */
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
-- 
2.1.0.27.g96db324
