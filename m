From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Sat, 22 Sep 2018 20:17:03 +0200
Subject: [PATCH 0/6] Add CPU clock support for Armada 7K/8K
Message-ID: <20180922181709.13007-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series allows to mange the cpu clock for Armada 7K/8K. For these
SoCs, the CPUs share the same clock by cluster, so actually the clock
management is done at cluster level.

As for the other Armada 7K/8K clocks it is possible to have multiple
AP so here again we need to have unique name: the purpose of the second
patch is to share a common code which will be used in 3 drivers.

The last 2 patch enable the driver at dt and platform level and will
be applied through the mvebu subsystem.

Gregory

Gregory CLEMENT (6): dt-bindings: ap806: add the cluster clock node in
  the syscon file clk: mvebu: add helper file for Armada AP and CP
  clocks clk: mvebu: add CPU clock driver for Armada 7K/8K clk: mvebu:
  ap806: Fix clock name for the cluster arm64: marvell: enable the
  Armada 7K/8K CPU clk driver arm64: dts: marvell: Add cpu clock node
  on Armada 7K/8K

 .../arm/marvell/ap806-system-controller.txt   |  22 ++
 arch/arm64/Kconfig.platforms                  |   1 +
 .../boot/dts/marvell/armada-ap806-quad.dtsi   |   4 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi |   6 +
 drivers/clk/mvebu/Kconfig                     |   8 +
 drivers/clk/mvebu/Makefile                    |   2 +
 drivers/clk/mvebu/ap-cpu-clk.c                | 265 ++++++++++++++++++
 drivers/clk/mvebu/ap806-system-controller.c   |  24 +-
 drivers/clk/mvebu/armada_ap_cp_helper.c       |  28 ++
 drivers/clk/mvebu/armada_ap_cp_helper.h       |  11 +
 drivers/clk/mvebu/cp110-system-controller.c   |  32 +--
 11 files changed, 361 insertions(+), 42 deletions(-)
 create mode 100644 drivers/clk/mvebu/ap-cpu-clk.c
 create mode 100644 drivers/clk/mvebu/armada_ap_cp_helper.c
 create mode 100644 drivers/clk/mvebu/armada_ap_cp_helper.h

-- 
2.19.0
