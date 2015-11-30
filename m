From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 30 Nov 2015 13:27:42 +0100
Subject: [PATCH v4 net 2/6] net: mvneta: fix bit assignment in
 MVNETA_RXQ_CONFIG_REG
In-Reply-To: <1448886466-31538-1-git-send-email-mw@semihalf.com>
References: <1448886466-31538-1-git-send-email-mw@semihalf.com>
Message-ID: <1448886466-31538-3-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MVNETA_RXQ_HW_BUF_ALLOC bit which controls enabling hardware buffer
allocation was mistakenly set as BIT(1). This commit fixes the assignment.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Fixes: c5aff18204da ("net: mvneta: driver for Marvell Armada 370/XP network
unit")
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 2d80256..64c46f0 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -36,7 +36,7 @@
 
 /* Registers */
 #define MVNETA_RXQ_CONFIG_REG(q)                (0x1400 + ((q) << 2))
-#define      MVNETA_RXQ_HW_BUF_ALLOC            BIT(1)
+#define      MVNETA_RXQ_HW_BUF_ALLOC            BIT(0)
 #define      MVNETA_RXQ_PKT_OFFSET_ALL_MASK     (0xf    << 8)
 #define      MVNETA_RXQ_PKT_OFFSET_MASK(offs)   ((offs) << 8)
 #define MVNETA_RXQ_THRESHOLD_REG(q)             (0x14c0 + ((q) << 2))
-- 
1.8.3.1
