From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon,  4 Dec 2017 23:18:16 +0530
Subject: [PATCH 0/7 v2] net: Fix platform_get_irq's error checking
Message-ID: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative number if an error
occurs, Zero if No irq is found and positive number if irq gets successful.
platform_get_irq() error checking for only zero is not correct.

Removed Other 3 patch which is not related to this series.

Arvind Yadav (7):
  [PATCH 1/7 v2] net: bcmgenet: Fix platform_get_irq's error checking
  [PATCH 2/7 v2] net: ezchip: nps_enet: Fix platform_get_irq's error checking
  [PATCH 3/7 v2] can: xilinx: Fix platform_get_irq's error checking
  [PATCH 4/7 v2] net: ethernet: i825xx: Fix platform_get_irq's error checking
  [PATCH 5/7 v2] net: ethernet: natsemi: Fix platform_get_irq's error checking
  [PATCH 6/7 v2] net: ethernet: smsc: Fix platform_get_irq's error checking
  [PATCH 7/7 v2] net: fjes: Fix platform_get_irq's error checking

 drivers/net/can/xilinx_can.c                   | 4 ++++
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 2 +-
 drivers/net/ethernet/ezchip/nps_enet.c         | 4 ++--
 drivers/net/ethernet/i825xx/sni_82596.c        | 3 ++-
 drivers/net/ethernet/natsemi/jazzsonic.c       | 5 +++++
 drivers/net/ethernet/smsc/smc911x.c            | 5 +++++
 drivers/net/fjes/fjes_main.c                   | 5 +++++
 7 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.7.4
