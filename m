From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 17 Sep 2010 18:45:00 +0900
Subject: [PATCH v2 1/2] sdhci-s3c: Add support additional host capabilities
In-Reply-To: <1284716701-5140-1-git-send-email-kgene.kim@samsung.com>
References: <1284716701-5140-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1284716701-5140-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeongbae Seo <jeongbae.seo@samsung.com>

This patch adds to support additional host capabilities
like SD/MMC high speed, SDHCI bus width and etc.

Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 71ad416..e6e0438 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -425,6 +425,10 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	/* HSMMC on Samsung SoCs uses SDCLK as timeout clock */
 	host->quirks |= SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK;
 
+	/* It supports additional host capabilities if needed */
+	if (pdata->host_caps)
+		host->mmc->caps |= pdata->host_caps;
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(dev, "sdhci_add_host() failed\n");
-- 
1.6.2.5
