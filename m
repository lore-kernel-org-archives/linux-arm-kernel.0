From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 30 Oct 2013 22:09:51 +0800
Subject: [PATCH v2 4/6] mmc: sdhci-esdhc-imx: fix cpas over write issue
In-Reply-To: <1383142193-24950-1-git-send-email-b29396@freescale.com>
References: <1383142193-24950-1-git-send-email-b29396@freescale.com>
Message-ID: <1383142193-24950-5-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should use '|=' instead '=', or it may over write
the original caps assigned before this line.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 92d5782..b2acb75 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1069,7 +1069,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		break;
 
 	case ESDHC_CD_PERMANENT:
-		host->mmc->caps = MMC_CAP_NONREMOVABLE;
+		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
 		break;
 
 	case ESDHC_CD_NONE:
-- 
1.7.2.rc3
