From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Fri, 3 Mar 2017 16:18:47 +0800
Subject: [v2, 5/7] mmc: sdhci-of-esdhc: add delay between tuning cycles
In-Reply-To: <1488529129-23560-1-git-send-email-yangbo.lu@nxp.com>
References: <1488529129-23560-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1488529129-23560-6-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's observed that eSDHC needed delay between tuning cycles for
HS200 successful tuning. This patch is to add the quirk
SDHCI_QUIRK2_DELAY_BETWEEN_TUNING_CYCLES to fix it.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None
---
 drivers/mmc/host/sdhci-of-esdhc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 8007188..7c4d8e8 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -836,6 +836,8 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 		host->quirks2 |= SDHCI_QUIRK2_BROKEN_HOST_CONTROL;
 	}
 
+	host->quirks2 |= SDHCI_QUIRK2_DELAY_BETWEEN_TUNING_CYCLES;
+
 	/* call to generic mmc_of_parse to support additional capabilities */
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
-- 
2.1.0.27.g96db324
