From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 18 Oct 2013 18:54:19 +0800
Subject: [PATCH v2 6/8] mmc: sdhci-esdhc-imx: enable SDR50 tuning for imx6q/dl
In-Reply-To: <1382093661-4074-1-git-send-email-b29396@freescale.com>
References: <1382093661-4074-1-git-send-email-b29396@freescale.com>
Message-ID: <1382093661-4074-7-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx6q/dl supports SDR50 tunning, enable it for a better timing
on SDR50 mode.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 87d202b..bdbca0e 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -257,7 +257,8 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 			else
 				/* imx6q/dl does not have cap_1 register, fake one */
 				val = SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_SDR104
-					| SDHCI_SUPPORT_SDR50;
+					| SDHCI_SUPPORT_SDR50
+					| SDHCI_USE_SDR50_TUNING;
 		}
 	}
 
-- 
1.7.2.rc3
