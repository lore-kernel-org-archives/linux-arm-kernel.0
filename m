From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 7 Mar 2018 18:50:13 +0530
Subject: [PATCH v3 04/11] mmc: sdhci-omap: Invoke sdhci_get_of_property to
 read sdhci dt properties
In-Reply-To: <20180307132020.30951-1-kishon@ti.com>
References: <20180307132020.30951-1-kishon@ti.com>
Message-ID: <20180307132020.30951-5-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Invoke sdhci_get_of_property defined in sdhci-pltfm.c to read
sdhci specific properties from dt node.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index fbc20a4fbb23..314dbe4d7412 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -893,6 +893,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	host->ioaddr += offset;
 
 	mmc = host->mmc;
+	sdhci_get_of_property(pdev);
 	ret = mmc_of_parse(mmc);
 	if (ret)
 		goto err_pltfm_free;
-- 
2.11.0
