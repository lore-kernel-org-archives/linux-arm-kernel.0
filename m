From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Sat, 13 Sep 2014 05:00:45 +0800
Subject: [Patch v4 net-next 00/12] net: fec: imx6sx multiqueue support
Message-ID: <1410555657-10744-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

These patches enable i.MX6SX multi queue support.
i.MX6SX support 3 queue and AVB feature.

Change from v3 to v4
 - use "unsigned int" instead of "unsigned"

Change from v2 to v3
 - fixed alignment requirement for ARM and NO-ARM platform

Change from v1 to v2.
 - Change num_tx_queue to unsigned int
 - Avoid block non-dt platform
 - remove call netif_set_real_num_rx_queues
 - seperate multi queue patch two part, one is tx and rx handle, with fixed queue 0
   then other one is initilized multiqueue
 - use two difference alignment for tx and rx path

Frank Li (4):
  net: fec: init multi queue date structure
  net: fec: add enet-avb IP support
  ARM: Documentation: Update fec dts binding doc
  ARM: dts: imx6sx: add multi-queue support enet

Fugang Duan (8):
  net:fec: add enet refrence clock for i.MX 6SX chip
  net:fec: add enet AVB feature macro define for imx6sx
  net: fec: change data structure to support multiqueue
  net: fec: parser max queue number from dt file
  net:fec: Disable enet-avb MAC instead of reset MAC
  net:fec: Add fsl,imx6sx-fec  compatible strings
  net: fec: change FEC alignment according to i.mx6 sx requirement
  net: fec: init complete variable in early to avoid kernel dump

 Documentation/devicetree/bindings/net/fsl-fec.txt |   6 +
 arch/arm/boot/dts/imx6sx.dtsi                     |   2 +
 drivers/net/ethernet/freescale/fec.h              | 154 +++-
 drivers/net/ethernet/freescale/fec_main.c         | 853 ++++++++++++++++------
 4 files changed, 756 insertions(+), 259 deletions(-)

-- 
1.9.1
