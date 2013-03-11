From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 11 Mar 2013 22:36:09 +0800
Subject: [PATCH -next] mmc: wmt-sdmmc: remove unused variable in
 wmt_complete_data_request()
Message-ID: <CAPgLHd-7nVD3=83wpNtw1cBmkr+xs5iD7tuxZM+PdxWPLtwZsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The variable 'mmc' is initialized but never used
otherwise, so remove the unused variable.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mmc/host/wmt-sdmmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 154f0e8..41d5802 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -348,13 +348,11 @@ static void wmt_complete_data_request(struct wmt_mci_priv *priv)
 
 static irqreturn_t wmt_mci_dma_isr(int irq_num, void *data)
 {
-	struct mmc_host *mmc;
 	struct wmt_mci_priv *priv;
 
 	int status;
 
 	priv = (struct wmt_mci_priv *)data;
-	mmc = priv->mmc;
 
 	status = readl(priv->sdmmc_base + SDDMA_CCR) & 0x0F;
 
