From: robherring2@gmail.com (Rob Herring)
Date: Fri, 27 Jul 2012 16:59:18 -0500
Subject: [GIT PULL] io.h clean-up for PCI
In-Reply-To: <50049285.1060100@gmail.com>
References: <50049285.1060100@gmail.com>
Message-ID: <50130F36.4090902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2012 05:15 PM, Rob Herring wrote:
> Arnd,
> 
> Please pull io.h PCI clean-up series. As you suggested, lets get it in
> next for test and decide later if to apply it for 3.6 or wait.
> 
> BTW, I'll have sporadic email access over the next 2 weeks.
> 
> Rob
> 

Arnd,

Please pull updated io.h cleanup for PCI branch. I rebased this as the
changes shifted things around a bit. This has the following changes:

- Incorporated fixes from you and Stephen
- Add early i/o mapping pci_map_io_early and enable on footbridge and
integrator for VGA console
- Avoid including map.h in asm/mach/pci.h which collided with EDAC.

Rob

The following changes since commit 84a1caf1453c3d44050bd22db958af4a7f99315c:

  Linux 3.5-rc7 (2012-07-14 15:40:28 -0700)

are available in the git repository at:

  git://sources.calxeda.com/kernel/linux.git io-cleanup-pci-v2

for you to fetch changes up to dd9bf78040fa0da4cecc228e1682b9682b8cb180:

  ARM: iop3xx: use fixed PCI i/o mapping (2012-07-26 09:10:04 -0500)

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
 arch/arm/include/asm/mach/pci.h                    |   13 +++
 arch/arm/kernel/bios32.c                           |   54 ++++++++-
 arch/arm/mach-dove/common.c                        |   10 --
 arch/arm/mach-dove/include/mach/dove.h             |    8 +-
 arch/arm/mach-dove/include/mach/io.h               |   19 ---
 arch/arm/mach-dove/pcie.c                          |   43 +++----
 arch/arm/mach-footbridge/common.c                  |   12 +-
 arch/arm/mach-footbridge/dc21285.c                 |   16 +--
 .../arm/mach-footbridge/include/mach/debug-macro.S |    3 +-
 arch/arm/mach-footbridge/include/mach/io.h         |   12 +-
 arch/arm/mach-integrator/include/mach/io.h         |   33 ------
 arch/arm/mach-integrator/include/mach/platform.h   |    4 +
 arch/arm/mach-integrator/integrator_ap.c           |    9 +-
 arch/arm/mach-integrator/pci_v3.c                  |   50 ++++----
 arch/arm/mach-iop13xx/include/mach/io.h            |   28 -----
 arch/arm/mach-iop13xx/include/mach/iop13xx.h       |   28 +----
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
 arch/arm/mm/mmu.c                                  |   54 +++++++--
 arch/arm/plat-iop/pci.c                            |   25 ++--
 arch/arm/plat-iop/setup.c                          |    5 -
 drivers/i2c/busses/i2c-iop3xx.c                    |  121
++++++++++----------
 56 files changed, 414 insertions(+), 910 deletions(-)
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
