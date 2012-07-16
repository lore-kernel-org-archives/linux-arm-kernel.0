From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 Jul 2012 17:15:33 -0500
Subject: [GIT PULL] io.h clean-up for PCI
Message-ID: <50049285.1060100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Please pull io.h PCI clean-up series. As you suggested, lets get it in
next for test and decide later if to apply it for 3.6 or wait.

BTW, I'll have sporadic email access over the next 2 weeks.

Rob

The following changes since commit bd0a521e88aa7a06ae7aabaed7ae196ed4ad867a:

  Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)

are available in the git repository at:

  git://sources.calxeda.com/kernel/linux.git io-cleanup-pci

for you to fetch changes up to 52f1412fb6415b7608745972bbcba56739d0d11e:

  ARM: iop3xx: use fixed PCI i/o mapping (2012-07-16 16:56:41 -0500)

----------------------------------------------------------------
Arnd Bergmann (1):
      iop13xx: use more regular PCI I/O space handling

Rob Herring (16):
      i2c: iop3xx: clean-up trailing whitespace
      i2c: iop3xx: use standard gpiolib functions
      ARM: Add fixed PCI i/o mapping
      ARM: move PCI i/o resource setup into common code
      ARM: versatile: use fixed PCI i/o mapping
      ARM: tegra: use fixed PCI i/o mapping
      ARM: integrator: use fixed PCI i/o mapping
      ARM: integrator: remove trailing whitespace on pci_v3.c
      ARM: shark: use fixed PCI i/o mapping
      ARM: footbridge: use fixed PCI i/o mapping
      ARM: dove: use fixed PCI i/o mapping
      ARM: kirkwood: use fixed PCI i/o mapping
      ARM: orion5x: use fixed PCI i/o mapping
      ARM: iop13xx: use fixed PCI i/o mapping
      ARM: mv78xx0: use fixed pci i/o mapping
      ARM: iop3xx: use fixed PCI i/o mapping

 Documentation/arm/memory.txt                       |    3 +
 arch/arm/Kconfig                                   |   13 +--
 arch/arm/include/asm/hardware/iop3xx.h             |   12 +-
 arch/arm/include/asm/io.h                          |    8 ++
 arch/arm/include/asm/mach/map.h                    |    8 ++
 arch/arm/include/asm/mach/pci.h                    |   18 +++
 arch/arm/kernel/bios32.c                           |   42 ++++++-
 arch/arm/mach-dove/common.c                        |   10 --
 arch/arm/mach-dove/include/mach/dove.h             |    8 +-
 arch/arm/mach-dove/include/mach/io.h               |   19 ---
 arch/arm/mach-dove/pcie.c                          |   43 +++----
 arch/arm/mach-footbridge/common.c                  |    8 +-
 arch/arm/mach-footbridge/dc21285.c                 |   16 +--
 .../arm/mach-footbridge/include/mach/debug-macro.S |    3 +-
 arch/arm/mach-footbridge/include/mach/io.h         |   12 +-
 arch/arm/mach-integrator/include/mach/io.h         |   33 ------
 arch/arm/mach-integrator/include/mach/platform.h   |    4 +
 arch/arm/mach-integrator/integrator_ap.c           |    7 +-
 arch/arm/mach-integrator/pci_v3.c                  |   50 ++++----
 arch/arm/mach-iop13xx/include/mach/io.h            |   28 -----
 arch/arm/mach-iop13xx/include/mach/iop13xx.h       |   27 +----
 arch/arm/mach-iop13xx/io.c                         |   27 -----
 arch/arm/mach-iop13xx/pci.c                        |   37 +++---
 arch/arm/mach-iop13xx/setup.c                      |   10 --
 arch/arm/mach-iop32x/include/mach/io.h             |   19 ---
 arch/arm/mach-iop33x/include/mach/io.h             |   19 ---
 arch/arm/mach-kirkwood/common.c                    |   10 --
 arch/arm/mach-kirkwood/include/mach/io.h           |   24 ----
 arch/arm/mach-kirkwood/include/mach/kirkwood.h     |    8 +-
 arch/arm/mach-kirkwood/pcie.c                      |   44 +++----
 arch/arm/mach-mv78xx0/addr-map.c                   |    3 +-
 arch/arm/mach-mv78xx0/common.c                     |    5 -
 arch/arm/mach-mv78xx0/include/mach/io.h            |   24 ----
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h       |   21 ++--
 arch/arm/mach-mv78xx0/pcie.c                       |  110
++++++------------
 arch/arm/mach-orion5x/common.c                     |   10 --
 arch/arm/mach-orion5x/include/mach/io.h            |   22 ----
 arch/arm/mach-orion5x/include/mach/orion5x.h       |   20 ++--
 arch/arm/mach-orion5x/pci.c                        |   56 +++------
 arch/arm/mach-shark/core.c                         |   18 ---
 arch/arm/mach-shark/include/mach/debug-macro.S     |    7 +-
 arch/arm/mach-shark/include/mach/entry-macro.S     |    3 +-
 arch/arm/mach-shark/include/mach/io.h              |   18 ---
 arch/arm/mach-shark/pci.c                          |    5 +
 arch/arm/mach-tegra/include/mach/io.h              |   46 --------
 arch/arm/mach-tegra/include/mach/iomap.h           |    3 +
 arch/arm/mach-tegra/pcie.c                         |   95 ++++-----------
 arch/arm/mach-versatile/core.c                     |    5 -
 arch/arm/mach-versatile/include/mach/hardware.h    |    1 -
 arch/arm/mach-versatile/include/mach/io.h          |   27 -----
 arch/arm/mach-versatile/pci.c                      |   22 +---
 arch/arm/mm/ioremap.c                              |   14 +++
 arch/arm/mm/mmu.c                                  |   26 +++--
 arch/arm/plat-iop/pci.c                            |   25 ++--
 arch/arm/plat-iop/setup.c                          |    5 -
 drivers/i2c/busses/i2c-iop3xx.c                    |  121
++++++++++----------
 56 files changed, 377 insertions(+), 905 deletions(-)
 delete mode 100644 arch/arm/mach-dove/include/mach/io.h
 delete mode 100644 arch/arm/mach-integrator/include/mach/io.h
 delete mode 100644 arch/arm/mach-iop13xx/include/mach/io.h
 delete mode 100644 arch/arm/mach-iop32x/include/mach/io.h
 delete mode 100644 arch/arm/mach-iop33x/include/mach/io.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/io.h
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/io.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/io.h
 delete mode 100644 arch/arm/mach-shark/include/mach/io.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/io.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/io.h
