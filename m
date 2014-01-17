From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 17 Jan 2014 21:24:44 +0800
Subject: [PATCH net-next v3 5/8] net: stmmac: Honor DT parameter to force DMA
 store and forward mode
In-Reply-To: <1389965087-21971-1-git-send-email-wens@csie.org>
References: <1389965087-21971-1-git-send-email-wens@csie.org>
Message-ID: <1389965087-21971-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"snps,force_sf_dma_mode" is documented in stmmac device tree bindings,
but is never handled by the driver.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 704a5e0..634260e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -56,6 +56,8 @@ static int stmmac_probe_config_dt(struct platform_device *pdev,
 					   sizeof(struct stmmac_mdio_bus_data),
 					   GFP_KERNEL);
 
+	plat->force_sf_dma_mode = of_property_read_bool(np, "snps,force_sf_dma_mode");
+
 	/*
 	 * Currently only the properties needed on SPEAr600
 	 * are provided. All other properties should be added
-- 
1.8.5.2
