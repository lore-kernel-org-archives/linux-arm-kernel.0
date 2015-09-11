From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 11 Sep 2015 11:01:14 +0900
Subject: [PATCH/RFC v2 net-next 0/4] ravb: Add support for r8a7795 SoC
Message-ID: <1441936878-18290-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enhances the ravb driver to support the r8a7795 SoC.

Changes:

v1 -> v2
* Address extensive review from Sergei Shtylyov and  Geert Uytterhoeven
  - In particular mandate all 25 interrupts in binding
* Broke brinding change into a separate patch
* New 100Mbit/s limit implementation in ravb driver using
  proposed update to phylib
* Split integration and driver changes into separate patch-sets

Base:

This is based on net-next/master

Availability:

* I will separately post a series,
  "[PATCH/RFC v2 0/5] arm64: dts: r8a7795: enable EthernetAVB on Salvator-X",
  to the linux-sh list to integrate the ravb on the r8a7795/salvatore-x board
* To aid review I will push the following to the renesas tree:
  - driver (this series): (me/r8a7795-ravb-driver-v2)
  - integration: me/r8a7795-ravb-integration-v2
  - both with runtime dependencies: me/r8a7795-ravb-driver-and-integration-v2.runtime
  
Kazuya Mizuguchi (3):
  ravb: Provide dev parameter to DMA API
  ravb: Document binding for r8a7795 SoC
  ravb: Add support for r8a7795 SoC

Simon Horman (1):
  phylib: Add phy_set_max_speed helper

 .../devicetree/bindings/net/renesas,ravb.txt       | 65 +++++++++++++--
 drivers/net/ethernet/renesas/ravb.h                |  7 ++
 drivers/net/ethernet/renesas/ravb_main.c           | 95 +++++++++++++++-------
 drivers/net/phy/phy_device.c                       | 52 +++++++-----
 include/linux/phy.h                                |  1 +
 5 files changed, 166 insertions(+), 54 deletions(-)

-- 
2.1.4
