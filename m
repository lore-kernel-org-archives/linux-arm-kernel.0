From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Thu, 26 Apr 2018 23:13:35 +0200
Subject: [PATCH 0/3] can: fix ndo_start_xmit()'s return type
Message-ID: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ndo_start_xmit() is defined as returing an 'netdev_tx_t'.
However, several can drivers use 'int' as the return type
of their start_xmit() method.
This series contains the fix for all three of them.

Luc Van Oostenryck (3):
  can: janz-ican3: fix ican3_xmit()'s return type
  can: sun4i: fix sun4ican_start_xmit()'s return type
  can: xilinx: fix xcan_start_xmit()'s return type

 drivers/net/can/janz-ican3.c | 2 +-
 drivers/net/can/sun4i_can.c  | 2 +-
 drivers/net/can/xilinx_can.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.17.0
