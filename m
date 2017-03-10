From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 10 Mar 2017 11:17:31 +0800
Subject: [PATCH 1/3] mmc: sdhci-pxav3: remove unnecessary
 platform_set_drvdata() call
In-Reply-To: <20170310031733.812-1-jszhang@marvell.com>
References: <20170310031733.812-1-jszhang@marvell.com>
Message-ID: <20170310031733.812-2-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdhci_pltfm_init() has already set the platform drvdata for us, remove
the unnecessary platform_set_drvdata() call.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index d0f5c05fbc19..132670a612a0 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -480,8 +480,6 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 		goto err_add_host;
 	}
 
-	platform_set_drvdata(pdev, host);
-
 	if (host->mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ)
 		device_init_wakeup(&pdev->dev, 1);
 
-- 
2.11.0
