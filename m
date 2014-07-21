From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 21 Jul 2014 13:48:11 -0300
Subject: [PATCH 1/6] net: mvpp2: Fix the periodic XON enable bit
In-Reply-To: <1405961296-5846-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1405961296-5846-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1405961296-5846-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcin Wojtas <mw@semihalf.com>

This bit was originally wrong, the correct value is BIT(1), so fix it.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index f4de2a9..8eac438 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -262,7 +262,7 @@
 #define      MVPP2_GMAC_MAX_RX_SIZE_MASK	0x7ffc
 #define      MVPP2_GMAC_MIB_CNTR_EN_MASK	BIT(15)
 #define MVPP2_GMAC_CTRL_1_REG			0x4
-#define      MVPP2_GMAC_PERIODIC_XON_EN_MASK	BIT(0)
+#define      MVPP2_GMAC_PERIODIC_XON_EN_MASK	BIT(1)
 #define      MVPP2_GMAC_GMII_LB_EN_MASK		BIT(5)
 #define      MVPP2_GMAC_PCS_LB_EN_BIT		6
 #define      MVPP2_GMAC_PCS_LB_EN_MASK		BIT(6)
-- 
2.0.1
