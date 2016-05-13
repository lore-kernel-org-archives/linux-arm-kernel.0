From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 13 May 2016 19:59:18 +0800
Subject: [PATCH 0/2] net: mv643xx_eth: improve performance
Message-ID: <1463140760-7128-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is to improve the mv643xx_eth driver performance by using
{readl|writel}_relaxed or appropriate memory barriers.

Since I have no mv643xx_eth platforms, tests are appreciated!

Jisheng Zhang (2):
  net: mv643xx_eth: use {readl|writel}_relaxed instead of readl/writel
  net: mv643xx_eth: use dma_wmb/rmb where appropriate

 drivers/net/ethernet/marvell/mv643xx_eth.c | 43 +++++++++++++++---------------
 1 file changed, 22 insertions(+), 21 deletions(-)

-- 
2.8.1
