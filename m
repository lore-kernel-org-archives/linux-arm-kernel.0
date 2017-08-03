From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  3 Aug 2017 10:41:55 +0200
Subject: [PATCH net-next v2 1/7] net: mvpp2: fix MVPP21_ISR_RXQ_GROUP_REG
 definition
In-Reply-To: <20170803084201.30305-1-thomas.petazzoni@free-electrons.com>
References: <20170803084201.30305-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20170803084201.30305-2-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MVPP21_ISR_RXQ_GROUP_REG register is not indexed by rxq, but by
port, so we fix the parameter name accordingly. There are no
functional changes.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 48d21c1..4b36a15 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -185,7 +185,7 @@
 /* Interrupt Cause and Mask registers */
 #define MVPP2_ISR_RX_THRESHOLD_REG(rxq)		(0x5200 + 4 * (rxq))
 #define     MVPP2_MAX_ISR_RX_THRESHOLD		0xfffff0
-#define MVPP21_ISR_RXQ_GROUP_REG(rxq)		(0x5400 + 4 * (rxq))
+#define MVPP21_ISR_RXQ_GROUP_REG(port)		(0x5400 + 4 * (port))
 
 #define MVPP22_ISR_RXQ_GROUP_INDEX_REG          0x5400
 #define MVPP22_ISR_RXQ_GROUP_INDEX_SUBGROUP_MASK 0xf
-- 
2.9.4
