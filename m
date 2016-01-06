From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 6 Jan 2016 11:56:05 +0800
Subject: [PATCH v2 12/12] mmc: sdhci-pltfm: remove priv variable from
 sdhci_pltfm_host
In-Reply-To: <1452052565-4232-1-git-send-email-jszhang@marvell.com>
References: <1452052565-4232-1-git-send-email-jszhang@marvell.com>
Message-ID: <1452052565-4232-13-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now all clients migration to use sdhci_pltfm_init for private
allocation is done and there's no users of the priv variable, so we can
remove it from the sdhci_pltfm_host structure.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
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
2.7.0.rc3
