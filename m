From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 09 Jun 2010 11:39:41 +0200
Subject: [PATCH 3/5] sdhci-s3c: increase the timeout value
In-Reply-To: <1276076383-24825-1-git-send-email-m.szyprowski@samsung.com>
References: <1276076383-24825-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1276076383-24825-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch increases the timeout value on sdhci-s3c controller by using
SDHCI_QUIRK_BROKEN_TIMEOUT_VAL quirk. Without it most transfers from
external mmc cards fails on Samsung s5pv210 SoCs based systems. Tested
on Samsung Aquila board.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index ad30f07..2b6cb44 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -331,6 +331,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	 * transfers, not sure if this is a problem with this specific
 	 * SDHCI block, or a missing configuration that needs to be set. */
 	host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ;
+	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
 	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
 			 SDHCI_QUIRK_32BIT_DMA_SIZE);
-- 
1.7.1.240.g225c
