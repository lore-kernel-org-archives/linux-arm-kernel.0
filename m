From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 14 Apr 2016 17:33:28 +0200
Subject: [PATCH v5 0/5] clk: mvebu: clock drivers for Marvell Armada 7K/8K
Message-ID: <1460648013-31320-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is the fifth version of the clock drivers for Armada 7K/8K. The
first two patches have already been applied by Stephen Boyd, but I'm
still including them for completeness.

Changes since v4:

 - Remove the gatable-clock-indices from the CP110 driver, use "none"
   when a given bit does not provide a clock. Suggested by Rob
   Herring.

 - Update the gatable clock tree with the latest technical information
   received.

 - Turn the clock drivers into proper platform drivers. Suggested by
   Stephen Boyd.

 - Remove useless headers include from the clock drivers. Suggested by
   Stephen Boyd.

 - Add proper handling in the clock driver ->probe() function.

Thanks!

Thomas

Thomas Petazzoni (5):
  clk: unconditionally recurse into clk/mvebu/
  dt-bindings: arm: add DT binding for Marvell AP806 system controller
  clk: mvebu: new driver for Armada AP806 system controller
  dt-bindings: arm: add DT binding for Marvell CP110 system controller
  clk: mvebu: new driver for Armada CP110 system controller

 .../arm/marvell/ap806-system-controller.txt        |  35 ++
 .../arm/marvell/cp110-system-controller0.txt       |  83 +++++
 drivers/clk/Makefile                               |   2 +-
 drivers/clk/mvebu/Kconfig                          |   6 +
 drivers/clk/mvebu/Makefile                         |   2 +
 drivers/clk/mvebu/ap806-system-controller.c        | 168 +++++++++
 drivers/clk/mvebu/cp110-system-controller.c        | 399 +++++++++++++++++++++
 7 files changed, 694 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
 create mode 100644 drivers/clk/mvebu/ap806-system-controller.c
 create mode 100644 drivers/clk/mvebu/cp110-system-controller.c

-- 
2.6.4
