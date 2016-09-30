From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Fri, 30 Sep 2016 09:37:39 +0800
Subject: [PATCH 2/2] mmc: sdhci-of-arasan: mark sdhci_arasan_reset() static
In-Reply-To: <1475199459-4775-1-git-send-email-baoyou.xie@linaro.org>
References: <1475199459-4775-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1475199459-4775-2-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get 1 warning when building kernel with W=1:
drivers/mmc/host/sdhci-of-arasan.c:253:6: warning: no previous prototype for 'sdhci_arasan_reset' [-Wmissing-prototypes]

In fact, this function is only used in the file in which it is
declared and don't need a declaration, but can be made static.
So this patch marks it 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/mmc/host/sdhci-of-arasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index da8e40a..e263671 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -250,7 +250,7 @@ static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
 	writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
 }
 
-void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
+static void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
 {
 	u8 ctrl;
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-- 
2.7.4
