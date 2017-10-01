From: jonas.gorski@gmail.com (Jonas Gorski)
Date: Sun,  1 Oct 2017 13:02:14 +0200
Subject: [PATCH 0/6] bcm63xx_enet: small fixes and cleanups
Message-ID: <20171001110220.27668-1-jonas.gorski@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set fixes a few theoretical issues and cleans up the code a
bit. It also adds a bit more managed function usage to simplify clock
and iomem usage.

Based on net-next.

Jonas Gorski (6):
  bcm63xx_enet: correct clock usage
  bcm63xx_enet: do not write to random DMA channel on BCM6345
  bcm63xx_enet: do not rely on probe order
  bcm63xx_enet: use managed functions for clock/ioremap
  bcm63xx_enet: drop unneeded NULL phy_clk check
  bcm63xx_enet: remove unneeded include

 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 78 ++++++++++------------------
 drivers/net/ethernet/broadcom/bcm63xx_enet.h |  1 -
 2 files changed, 28 insertions(+), 51 deletions(-)

-- 
2.13.2
