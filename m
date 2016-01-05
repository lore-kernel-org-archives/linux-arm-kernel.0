From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 5 Jan 2016 18:51:38 +0800
Subject: [PATCH 10/11] mmc: sdhci-pxav2: remove unnecessary assignment of
 pltfm_host->priv
In-Reply-To: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
References: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
Message-ID: <1451991099-4946-11-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdhci_pltfm_init() function has initialized the priv member as
NULL, so there's no need to do it again.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index beffd86..1d8dd35 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -177,7 +177,6 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 		return PTR_ERR(host);
 
 	pltfm_host = sdhci_priv(host);
-	pltfm_host->priv = NULL;
 
 	clk = clk_get(dev, "PXA-SDHCLK");
 	if (IS_ERR(clk)) {
-- 
2.6.4
