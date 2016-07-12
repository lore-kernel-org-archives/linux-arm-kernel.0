From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Tue, 12 Jul 2016 11:36:44 +0000
Subject: [PATCH -next] net: mediatek: fix non static symbol warnings
Message-ID: <1468323404-2193-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fixes the following sparse warnings:

drivers/net/ethernet/mediatek/mtk_eth_soc.c:79:5: warning:
 symbol '_mtk_mdio_write' was not declared. Should it be static?
drivers/net/ethernet/mediatek/mtk_eth_soc.c:98:5: warning:
 symbol '_mtk_mdio_read' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 682797e..6f597eb 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -76,8 +76,8 @@ static int mtk_mdio_busy_wait(struct mtk_eth *eth)
 	return -1;
 }
 
-u32 _mtk_mdio_write(struct mtk_eth *eth, u32 phy_addr,
-		    u32 phy_register, u32 write_data)
+static u32 _mtk_mdio_write(struct mtk_eth *eth, u32 phy_addr,
+			   u32 phy_register, u32 write_data)
 {
 	if (mtk_mdio_busy_wait(eth))
 		return -1;
@@ -95,7 +95,7 @@ u32 _mtk_mdio_write(struct mtk_eth *eth, u32 phy_addr,
 	return 0;
 }
 
-u32 _mtk_mdio_read(struct mtk_eth *eth, int phy_addr, int phy_reg)
+static u32 _mtk_mdio_read(struct mtk_eth *eth, int phy_addr, int phy_reg)
 {
 	u32 d;
