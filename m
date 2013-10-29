From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 29 Oct 2013 17:50:01 +0530
Subject: [PATCH 0/4] clk/power: add clock and power off driver for AS3722
Message-ID: <1383049205-29620-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power off and clock driver for the ams AS3722.

The mfd patches are depends on mfd subtree which can be applied independtly.
The pacthes are created such that clock driver can go in clock tree and power
off driver in power sub tree.

Laxman Dewangan (4):
  mfd: as3722: add clock driver as mfd-sub device for the ams AS3722
  clk: as3722: add clock driver for ams AS3722
  mfd: AS3722: add dt node properties for system power controller
  power: reset: as3722: add power-off driver

 Documentation/devicetree/bindings/mfd/as3722.txt |   18 +++
 drivers/clk/Kconfig                              |    8 +
 drivers/clk/Makefile                             |    1 +
 drivers/clk/clk-as3722.c                         |  166 ++++++++++++++++++++++
 drivers/mfd/as3722.c                             |    3 +
 drivers/power/reset/Kconfig                      |    6 +
 drivers/power/reset/Makefile                     |    1 +
 drivers/power/reset/as3722-poweroff.c            |  101 +++++++++++++
 8 files changed, 304 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clk/clk-as3722.c
 create mode 100644 drivers/power/reset/as3722-poweroff.c
