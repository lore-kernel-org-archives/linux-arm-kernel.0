From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 13 May 2016 19:57:29 +0800
Subject: [PATCH 1/2] net: pxa168_eth: use {readl|writel}_relaxed instead of
 readl/writel
In-Reply-To: <1463140650-7038-1-git-send-email-jszhang@marvell.com>
References: <1463140650-7038-1-git-send-email-jszhang@marvell.com>
Message-ID: <1463140650-7038-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since appropriate memory barriers are already there, use the relaxed
version to improve performance a bit.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/net/ethernet/marvell/pxa168_eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index c442f6a..db774e3 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -286,12 +286,12 @@ static int pxa168_eth_stop(struct net_device *dev);
 
 static inline u32 rdl(struct pxa168_eth_private *pep, int offset)
 {
-	return readl(pep->base + offset);
+	return readl_relaxed(pep->base + offset);
 }
 
 static inline void wrl(struct pxa168_eth_private *pep, int offset, u32 data)
 {
-	writel(data, pep->base + offset);
+	writel_relaxed(data, pep->base + offset);
 }
 
 static void abort_dma(struct pxa168_eth_private *pep)
-- 
2.8.1
