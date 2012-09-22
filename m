From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Sep 2012 13:33:49 -0400
Subject: [GIT PULL V5 6/7] ARM: kirkwood addr_decode changes for v3.7
In-Reply-To: <20120922171554.GE5469@titan.lakedaemon.net>
References: <20120922171554.GE5469@titan.lakedaemon.net>
Message-ID: <20120922173349.GK5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depends:
 - based on v3.6-rc5

touches all plat-orion/ and mach-mvebu/ for consistent address decoding
support

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git kirkwood/addr_decode

Thomas Petazzoni (17):
      arm: mach-dove: use plus instead of or for address definitions
      arm: mach-kirkwood: use plus instead of or for address definitions
      arm: mach-mv78xx0: use plus instead of or for address definitions
      arm: mach-orion5x: use plus instead of or for address definitions
      arm: mach-dove: use IOMEM() for base address definitions
      arm: mach-kirkwood: use IOMEM() for base address definitions
      arm: mach-mv78xx0: use IOMEM() for base address definitions
      arm: mach-orion5x: use IOMEM() for base address definitions
      arm: mach-mvebu: use IOMEM() for base address definitions
      arm: plat-orion: use void __iomem pointers for UART registration functions
      arm: plat-orion: use void __iomem pointers for MPP functions
      arm: plat-orion: use void __iomem pointers for time functions
      arm: plat-orion: use void __iomem pointers for addr-map functions
      arm: plat-orion: introduce PLAT_ORION_LEGACY hidden config option
      arm: plat-orion: make bridge_virt_base non-const to support DT use case
      arm: mvebu: add basic address decoding support to Armada 370/XP
      arm: mvebu: add address decoding controller to the DT

 arch/arm/Kconfig                                  |   13 ++-
 arch/arm/boot/dts/armada-370-xp.dtsi              |    5 +
 arch/arm/mach-dove/common.c                       |    8 +-
 arch/arm/mach-dove/include/mach/bridge-regs.h     |   16 ++--
 arch/arm/mach-dove/include/mach/dove.h            |  130 ++++++++++----------
 arch/arm/mach-dove/irq.c                          |   10 +-
 arch/arm/mach-dove/pcie.c                         |    6 +-
 arch/arm/mach-kirkwood/addr-map.c                 |    3 +-
 arch/arm/mach-kirkwood/common.c                   |   12 +-
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |   20 ++--
 arch/arm/mach-kirkwood/include/mach/kirkwood.h    |  116 +++++++++---------
 arch/arm/mach-kirkwood/irq.c                      |    9 +-
 arch/arm/mach-kirkwood/pcie.c                     |   12 +-
 arch/arm/mach-kirkwood/ts41x-setup.c              |    3 +-
 arch/arm/mach-mv78xx0/addr-map.c                  |    6 +-
 arch/arm/mach-mv78xx0/common.c                    |    6 +-
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h  |   12 +-
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h      |   88 +++++++-------
 arch/arm/mach-mv78xx0/irq.c                       |    9 +-
 arch/arm/mach-mv78xx0/pcie.c                      |   12 +-
 arch/arm/mach-mvebu/Makefile                      |    2 +-
 arch/arm/mach-mvebu/addr-map.c                    |  134 +++++++++++++++++++++
 arch/arm/mach-mvebu/armada-370-xp.c               |    2 +-
 arch/arm/mach-mvebu/include/mach/armada-370-xp.h  |    2 +-
 arch/arm/mach-orion5x/addr-map.c                  |    3 +-
 arch/arm/mach-orion5x/common.c                    |    8 +-
 arch/arm/mach-orion5x/dns323-setup.c              |    2 +-
 arch/arm/mach-orion5x/include/mach/bridge-regs.h  |   20 ++--
 arch/arm/mach-orion5x/include/mach/orion5x.h      |   60 +++++-----
 arch/arm/mach-orion5x/irq.c                       |    5 +-
 arch/arm/mach-orion5x/pci.c                       |    6 +-
 arch/arm/plat-orion/Makefile                      |    9 +-
 arch/arm/plat-orion/addr-map.c                    |   11 +-
 arch/arm/plat-orion/common.c                      |   12 +-
 arch/arm/plat-orion/include/plat/addr-map.h       |    4 +-
 arch/arm/plat-orion/include/plat/common.h         |    8 +-
 arch/arm/plat-orion/include/plat/mpp.h            |    2 +-
 arch/arm/plat-orion/include/plat/time.h           |    4 +-
 arch/arm/plat-orion/mpp.c                         |    6 +-
 arch/arm/plat-orion/time.c                        |    8 +-
 40 files changed, 474 insertions(+), 330 deletions(-)
 create mode 100644 arch/arm/mach-mvebu/addr-map.c
