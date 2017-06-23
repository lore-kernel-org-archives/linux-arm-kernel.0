From: david.wu@rock-chips.com (David Wu)
Date: Fri, 23 Jun 2017 12:42:02 +0800
Subject: [PATCH 04/11] net: stmmac: dwmac-rk: Remove unwanted code for
 rk3328_set_to_rmii()
In-Reply-To: <1498192929-7519-1-git-send-email-david.wu@rock-chips.com>
References: <1498192929-7519-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1498192929-7519-5-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is wrong setting for rk3328_set_to_rmii(), so remove it.

Change-Id: I9953784ea44335d90710e5473960c95b3d68a5fd
Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index f0df519..a8e8fd5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -365,9 +365,6 @@ static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
 	regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON1,
 		     RK3328_GMAC_PHY_INTF_SEL_RMII |
 		     RK3328_GMAC_RMII_MODE);
-
-	/* set MAC to RMII mode */
-	regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON1, GRF_BIT(11));
 }
 
 static void rk3328_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
-- 
1.9.1
