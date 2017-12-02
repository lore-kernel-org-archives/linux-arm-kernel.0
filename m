From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sun,  3 Dec 2017 00:56:12 +0530
Subject: [PATCH 00/10] Handle return value of platform_get_*
Message-ID: <1512242782-7134-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 - The platform_get_*_*() function returns negative if an error occurs.
   zero or positive number on success. platform_get_irq_byname() error
   checking for zero is not correct.
 - The change is to call free_netdev(), If of_match_node() will fail.
 - Handle return value of platform_get_resource()

Arvind Yadav (10):
  [PATCH 01/10] net: bcmgenet: Fix platform_get_irq's error checking
  [PATCH 02/10] net: bcmgenet: free netdev on of_match_node() error
  [PATCH 03/10] net: ezchip: nps_enet: Fix platform_get_irq's error checking
  [PATCH 04/10] can: xilinx: Handle return value of platform_get_irq
  [PATCH 05/10] net: ethernet: i825xx: Fix platform_get_irq's error checking
  [PATCH 06/10] net: ethernet: natsemi: Handle return value of platform_get_irq
  [PATCH 07/10] net: ethernet: smsc: Handle return value of platform_get_irq
  [PATCH 08/10] net: fjes: Handle return value of platform_get_irq and platform_get_resource
  [PATCH 09/10] net: ethernet: korina: Handle return value of platform_get_irq_byname
  [PATCH 10/10] net: ethernet: cpmac: Handle return value of platform_get_irq_byname

 drivers/net/can/xilinx_can.c                   |  4 ++++
 drivers/net/ethernet/broadcom/genet/bcmgenet.c |  8 +++++---
 drivers/net/ethernet/ezchip/nps_enet.c         |  7 +++----
 drivers/net/ethernet/i825xx/sni_82596.c        |  3 ++-
 drivers/net/ethernet/korina.c                  |  9 +++++++++
 drivers/net/ethernet/natsemi/jazzsonic.c       |  5 +++++
 drivers/net/ethernet/smsc/smc911x.c            |  5 +++++
 drivers/net/ethernet/ti/cpmac.c                |  4 ++++
 drivers/net/fjes/fjes_main.c                   | 10 ++++++++++
 9 files changed, 47 insertions(+), 8 deletions(-)

-- 
2.7.4
