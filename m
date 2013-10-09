From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 9 Oct 2013 19:20:14 +0800
Subject: [PATCH 08/10] mmc: sdhci-esdhc-imx: enable SDR50 tuning for imx6q/dl
In-Reply-To: <1381317616-1229-1-git-send-email-b29396@freescale.com>
References: <1381317616-1229-1-git-send-email-b29396@freescale.com>
Message-ID: <1381317616-1229-9-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx6q/dl supports SDR50 tunning, enable it for a better timing
on SDR50 mode.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 91b2d85..8879974 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -244,7 +244,7 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 		if (is_imx6q_usdhc(imx_data))
 			/* imx6q/dl does not have cap_1 register, fake one */
 			val = SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_SDR104
-					| SDHCI_SUPPORT_SDR50;
+				| SDHCI_SUPPORT_SDR50 | SDHCI_USE_SDR50_TUNING;
 		else if (is_imx6sl_usdhc(imx_data))
 			val = readl(host->ioaddr + SDHCI_CAPABILITIES) & 0xFFFF;
 	}
-- 
1.7.2.rc3
