From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sun, 25 Sep 2016 15:44:03 +0000
Subject: [PATCH -next] mmc: sdhci-of-arasan: Fix non static symbol warning
Message-ID: <1474818243-19207-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warning:

drivers/mmc/host/sdhci-of-arasan.c:253:6: warning:
 symbol 'sdhci_arasan_reset' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
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
