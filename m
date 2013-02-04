From: tony@atomide.com (Tony Lindgren)
Date: Mon, 4 Feb 2013 11:55:46 -0800
Subject: [GIT PULL 2/4] omap gpmc changes for v3.9 merge window
In-Reply-To: <pull-1360007747-30585>
Message-ID: <mailman.30.1360007757.1035.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9/gpmc-signed

for you to fetch changes up to 97c794a1e37b1ca128ef38f17c069186bfa5fb1b:

  ARM: OMAP2+: gpmc: Add device tree documentation for elm handle (2013-02-01 14:32:03 -0800)

----------------------------------------------------------------
OMAP GPMC (General Purpose Memory Controller) changes to add
device tree bindings.

----------------------------------------------------------------
Daniel Mack (5):
      ARM: OMAP: gpmc: don't create devices from initcall on DT
      mtd: omap-nand: pass device_node in platform data
      ARM: OMAP: gpmc-nand: drop __init annotation
      ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
      ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND

Ezequiel Garcia (4):
      ARM: OMAP2+: gpmc: Remove unneeded of_node_put()
      mtd: omap-onenand: pass device_node in platform data
      ARM: OMAP2+: gpmc-onenand: drop __init annotation
      ARM: OMAP2+: gpmc: add DT bindings for OneNAND

Jon Hunter (1):
      ARM: OMAP2+: Prevent potential crash if GPMC probe fails

Philip Avinash (1):
      ARM: OMAP2+: gpmc: Add device tree documentation for elm handle

 Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  84 ++++++++
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  80 +++++++
 .../devicetree/bindings/mtd/gpmc-onenand.txt       |  43 ++++
 arch/arm/mach-omap2/gpmc-nand.c                    |  15 +-
 arch/arm/mach-omap2/gpmc-onenand.c                 |   2 +-
 arch/arm/mach-omap2/gpmc.c                         | 232 ++++++++++++++++++++-
 drivers/mtd/nand/omap2.c                           |   4 +-
 drivers/mtd/onenand/omap2.c                        |   4 +-
 include/linux/platform_data/mtd-nand-omap2.h       |   4 +-
 include/linux/platform_data/mtd-onenand-omap2.h    |   3 +
 10 files changed, 459 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
