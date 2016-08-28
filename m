From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 28 Aug 2016 18:16:35 +0200
Subject: [PATCH v3 3/5] stmmac: introduce get_stmmac_bsp_priv() helper
In-Reply-To: <20160828161637.9941-1-martin.blumenstingl@googlemail.com>
References: <20160820093538.9707-1-martin.blumenstingl@googlemail.com>
 <20160828161637.9941-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160828161637.9941-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joachim Eastwood <manabian@gmail.com>

Create a helper to retrive dwmac private data from a dev
pointer. This is useful in PM callbacks and driver remove.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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
