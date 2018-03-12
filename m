From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Mon, 12 Mar 2018 13:25:38 +0800
Subject: [PATCH v2 1/3] phy: phy-mtk-tphy: keep default value of
 mcu_bus_ck_gate_en
Message-ID: <c9679bc6e969ebf0f97a01c6d1aff3bbc0e8e4f7.1520832210.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default value of mcu_bus_ck_gate_en is 1, if clear it, will
prevent system to enter deep idle mode, so keep its default value
and without affecting PCIe function.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 1e96d07..6073c25 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -688,8 +688,7 @@ static void pcie_phy_instance_power_on(struct mtk_tphy *tphy,
 	u32 tmp;
 
 	tmp = readl(bank->chip + U3P_U3_CHIP_GPIO_CTLD);
-	tmp &= ~(P3C_FORCE_IP_SW_RST | P3C_MCU_BUS_CK_GATE_EN |
-		P3C_REG_IP_SW_RST);
+	tmp &= ~(P3C_FORCE_IP_SW_RST | P3C_REG_IP_SW_RST);
 	writel(tmp, bank->chip + U3P_U3_CHIP_GPIO_CTLD);
 
 	tmp = readl(bank->chip + U3P_U3_CHIP_GPIO_CTLE);
-- 
1.9.1
