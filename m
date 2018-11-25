From: otavio@ossystems.com.br (Otavio Salvador)
Date: Sun, 25 Nov 2018 19:18:57 -0200
Subject: [PATCH 03/13] net: stmmac: dwmac-rk: Allow the driver to probe when
 phy-supply is not present
In-Reply-To: <20181125211907.9895-1-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
Message-ID: <20181125211907.9895-3-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phy-supply is an optional regulator, so we should not treat
as an error when phy-supply is not passed in the device tree.

This allows the dwmac-rk driver to probe when phy-supply is not
present in the dts.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 7b923362ee55..73855622445b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1205,7 +1205,7 @@ static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
 
 	if (!ldo) {
 		dev_err(dev, "no regulator found\n");
-		return -1;
+		return 0;
 	}
 
 	if (enable) {
-- 
2.19.1
