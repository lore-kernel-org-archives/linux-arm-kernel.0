From: otavio@ossystems.com.br (Otavio Salvador)
Date: Sun, 25 Nov 2018 19:18:59 -0200
Subject: [PATCH 05/13] net: stmmac: dwmac-rk: Do not print error when PHY
 regulator is not found
In-Reply-To: <20181125211907.9895-1-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
Message-ID: <20181125211907.9895-5-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PHY regulator is optional, so when it is not present move the message
level from error to debug, which is more appropriate.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
---

 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index c895a9a6939a..6b4ea95a30e0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1242,7 +1242,7 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 			dev_err(dev, "phy regulator is not available yet, deferred probing\n");
 			return ERR_PTR(-EPROBE_DEFER);
 		}
-		dev_err(dev, "no regulator found\n");
+		dev_dbg(dev, "no regulator found\n");
 		bsp_priv->regulator = NULL;
 	}
 
-- 
2.19.1
