From: sangwook.lee@linaro.org (Sangwook Lee)
Date: Mon,  7 Nov 2011 17:05:22 +0000
Subject: [PATCH 2/2] mmc: sdhci-s3c: Add pm_caps into SD/MMC host
In-Reply-To: <1320685522-17481-1-git-send-email-sangwook.lee@linaro.org>
References: <1320685522-17481-1-git-send-email-sangwook.lee@linaro.org>
Message-ID: <1320685522-17481-3-git-send-email-sangwook.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdhci-s3c updates pm_caps from platform data for SDIO PM.

Signed-off-by: Sangwook Lee <sangwook.lee@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index fe886d6..f10dd52 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -518,6 +518,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	if (pdata->host_caps)
 		host->mmc->caps |= pdata->host_caps;
 
+	if (pdata->pm_caps)
+		host->mmc->pm_caps |= pdata->pm_caps;
+
 	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
 			 SDHCI_QUIRK_32BIT_DMA_SIZE);
 
-- 
1.7.4.1
