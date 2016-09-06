From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Tue,  6 Sep 2016 23:38:45 +0200
Subject: [PATCH v5 3/6] stmmac: introduce get_stmmac_bsp_priv() helper
In-Reply-To: <20160906213848.17785-1-martin.blumenstingl@googlemail.com>
References: <20160904182320.671-1-martin.blumenstingl@googlemail.com>
 <20160906213848.17785-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160906213848.17785-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joachim Eastwood <manabian@gmail.com>

Create a helper to retrieve dwmac private data from a dev
pointer. This is useful in PM callbacks and driver remove.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index ffeb8d9..64e147f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -30,4 +30,12 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 int stmmac_pltfr_remove(struct platform_device *pdev);
 extern const struct dev_pm_ops stmmac_pltfr_pm_ops;
 
+static inline void *get_stmmac_bsp_priv(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct stmmac_priv *priv = netdev_priv(ndev);
+
+	return priv->plat->bsp_priv;
+}
+
 #endif /* __STMMAC_PLATFORM_H__ */
-- 
2.9.3
