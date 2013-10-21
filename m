From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 21 Oct 2013 22:27:05 +0800
Subject: [PATCH 5/7] mmc: sdhci-esdhc-imx: fix cpas over write issue
In-Reply-To: <1382365627-26816-1-git-send-email-b29396@freescale.com>
References: <1382365627-26816-1-git-send-email-b29396@freescale.com>
Message-ID: <1382365627-26816-6-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should use '|=' instead '=', or it may over write
the original caps assigned before this line.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 5fe484f..baa27c7 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1070,7 +1070,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		break;
 
 	case ESDHC_CD_PERMANENT:
-		host->mmc->caps = MMC_CAP_NONREMOVABLE;
+		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
 		break;
 
 	case ESDHC_CD_NONE:
-- 
1.7.2.rc3
