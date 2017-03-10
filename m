From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 10 Mar 2017 11:17:32 +0800
Subject: [PATCH 2/3] mmc: sdhci-pxav2: remove unnecessary
 platform_set_drvdata() call
In-Reply-To: <20170310031733.812-1-jszhang@marvell.com>
References: <20170310031733.812-1-jszhang@marvell.com>
Message-ID: <20170310031733.812-3-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdhci_pltfm_init() has already set the platform drvdata for us, remove
the unnecessary platform_set_drvdata() call.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 347eae2d7b6a..74e21ad699e0 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -222,8 +222,6 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 		goto err_add_host;
 	}
 
-	platform_set_drvdata(pdev, host);
-
 	return 0;
 
 err_add_host:
-- 
2.11.0
