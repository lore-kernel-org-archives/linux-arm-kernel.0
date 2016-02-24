From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Feb 2016 16:14:20 +0100
Subject: [PATCH v2 0/6] clk: mvebu: initial support for AP806 clocks
Message-ID: <1456326866-30854-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The following set of patches add initial support for the main clocks
found in the AP806 hardware block, which is the central block used in
the newest Marvell 7K and 8K 64-bits processors.

Two new drivers are added, one for the so-called "core" clocks and one
for the "ring" clocks. The latter are child clocks from one of the
core clocks. The "core" clocks are fixed rate clocks, but their rate
is calculated from values in the Sample At Reset register.

Changes since v1:
 - Introduce a minimal DT binding for the AP806 DFX Server register
   area, and make the clock DT nodes child nodes of the DFX server
   node. Implementation-wise, we use the simple-mfd/syscon mechanism.
 - Separate the DT binding documentation into its own patches.

Thanks!

Thomas

Thomas Petazzoni (6):
  dt-bindings: arm/marvell: add DT bindings for AP806 DFX Server
  dt-bindings: clock: add DT bindings for AP806 core clocks
  dt-bindings: clock: add DT bindings for AP806 ring clocks
  clk: unconditionally recurse into clk/mvebu/
  clk: mvebu: add AP806 core clock driver
  clk: mvebu: add AP806 ring clock driver

 .../arm/marvell/marvell,ap806-dfx-server.txt       |  19 ++++
 .../clock/mvebu-armada-ap806-core-clock.txt        |  35 ++++++
 .../clock/mvebu-armada-ap806-ring-clock.txt        |  36 ++++++
 drivers/clk/Makefile                               |   2 +-
 drivers/clk/mvebu/Kconfig                          |   6 +
 drivers/clk/mvebu/Makefile                         |   3 +-
 drivers/clk/mvebu/ap806-core.c                     | 121 +++++++++++++++++++++
 drivers/clk/mvebu/ap806-ring.c                     |  74 +++++++++++++
 8 files changed, 294 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,ap806-dfx-server.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mvebu-armada-ap806-core-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mvebu-armada-ap806-ring-clock.txt
 create mode 100644 drivers/clk/mvebu/ap806-core.c
 create mode 100644 drivers/clk/mvebu/ap806-ring.c

-- 
2.6.4
