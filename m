From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 15 Feb 2016 08:34:55 +0100
Subject: [PATCH 0/3] clk: mvebu: initial support for AP806 clocks
Message-ID: <1455521698-7905-1-git-send-email-thomas.petazzoni@free-electrons.com>
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

The support for the Marvell 7K/8K platform (Device Tree, etc.) will be
submitted as a separate patch series.

Thanks!

Thomas

Thomas Petazzoni (3):
  clk: unconditionally recurse into clk/mvebu/
  clk: mvebu: add AP806 core clock driver
  clk: mvebu: add AP806 ring clock driver

 .../clock/mvebu-armada-ap806-core-clock.txt        |  33 ++++++
 .../clock/mvebu-armada-ap806-ring-clock.txt        |  32 ++++++
 drivers/clk/Makefile                               |   2 +-
 drivers/clk/mvebu/Kconfig                          |   6 ++
 drivers/clk/mvebu/Makefile                         |   3 +-
 drivers/clk/mvebu/ap806-core.c                     | 112 +++++++++++++++++++++
 drivers/clk/mvebu/ap806-ring.c                     |  65 ++++++++++++
 7 files changed, 251 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mvebu-armada-ap806-core-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mvebu-armada-ap806-ring-clock.txt
 create mode 100644 drivers/clk/mvebu/ap806-core.c
 create mode 100644 drivers/clk/mvebu/ap806-ring.c

-- 
2.6.4
