From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue, 19 Oct 2010 14:49:01 +0200
Subject: [PATCH] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
Message-ID: <1287492541-3060-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch fix timeout problems on i.MX51 as suggested by
Richard Zhu.
more tests are needed to check if this quirk can be removed
for i.MX25 and 35.

Signed-off-by: Eric B?nard <eric@eukrea.com>
Tested-by: Shawn Guo <shawn.gsc@gmail.com>
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
1.7.0.4
