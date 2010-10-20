From: shawn.gsc@gmail.com (Shawn Guo)
Date: Wed, 20 Oct 2010 17:22:56 +0800
Subject: [PATCH 1/2] mmc: quirk fix for timeout problem
In-Reply-To: <1287564807-1645-1-git-send-email-shawn.gsc@gmail.com>
References: <1287564807-1645-1-git-send-email-shawn.gsc@gmail.com>
Message-ID: <1287566576-1224-1-git-send-email-shawn.gsc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to fix timeout problem which was seen on babbage.
Thanks Richard Zhu <r65037@freescale.com> for catching this.

Signed-off-by: Shawn Guo <shawn.gsc@gmail.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 2e9cca1..e8f7048 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -134,7 +134,8 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 
 struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
 	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_MULTIBLOCK
-			| SDHCI_QUIRK_BROKEN_ADMA,
+			| SDHCI_QUIRK_BROKEN_ADMA
+			| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
 	/* ADMA has issues. Might be fixable */
 	/* NO_MULTIBLOCK might be MX35 only (Errata: ENGcm07207) */
 	.ops = &sdhci_esdhc_ops,
-- 
1.7.1
