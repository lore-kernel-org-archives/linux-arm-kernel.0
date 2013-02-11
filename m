From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Tue, 12 Feb 2013 01:22:17 +0530
Subject: [PATCH 0/3] Dual EMAC mode implementation of CPSW
Message-ID: <1360612340-9266-1-git-send-email-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series implements Dual EMAC mode implementation of CPSW
which acts as two standalone EMAC by segregating the switch using VIDs
and port VLAN

Mugunthan V N (3):
  driver: net: ethernet: davinci_cpdma: add support for directed packet
    and source port detection
  driver: net: ethernet: cpsw: make cpts as pointer
  driver: net: ethernet: cpsw: dual emac interface implementation

 Documentation/devicetree/bindings/net/cpsw.txt |    2 +
 drivers/net/ethernet/ti/cpsw.c                 |  387 +++++++++++++++++++-----
 drivers/net/ethernet/ti/davinci_cpdma.c        |   17 +-
 drivers/net/ethernet/ti/davinci_cpdma.h        |    4 +-
 drivers/net/ethernet/ti/davinci_emac.c         |    6 +-
 include/linux/platform_data/cpsw.h             |    3 +
 6 files changed, 338 insertions(+), 81 deletions(-)

-- 
1.7.9.5
