From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 5 Jan 2016 18:51:39 +0800
Subject: [PATCH 11/11] mmc: sdhci-pltfm: remove priv variable from
 sdhci_pltfm_host
In-Reply-To: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
References: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
Message-ID: <1451991099-4946-12-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now all clients migration to use sdhci_pltfm_init for private
allocation is done and there's no users of the priv variable, so we can
remove it from the sdhci_pltfm_host structure.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-pltfm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 04bc248..d38053b 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -23,7 +23,6 @@ struct sdhci_pltfm_data {
 
 struct sdhci_pltfm_host {
 	struct clk *clk;
-	void *priv; /* to handle quirks across io-accessor calls */
 
 	/* migrate from sdhci_of_host */
 	unsigned int clock;
-- 
2.6.4
