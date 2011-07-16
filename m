From: robherring2@gmail.com (Rob Herring)
Date: Fri, 15 Jul 2011 20:51:18 -0500
Subject: [GIT PULL] ARM: make mach/hardware.h optional
Message-ID: <4E20EE96.6020500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Here's the hardware.h clean-up in a git tree if you prefer to pull it.

git://git.jdl.com/software/linux-3.0.git for-arm-soc

Rob

The following changes since commit fe0d42203cb5616eeff68b14576a0f7e2dd56625:

  Linux 3.0-rc6 (2011-07-04 15:56:24 -0700)

are available in the git repository at:
  git://git.jdl.com/software/linux-3.0.git for-arm-soc

Rob Herring (6):
      powerpc: rename ppc_pci_*_flags to pci_*_flags
      pci: move microblaze and powerpc pci flag functions into asm-generic
      ARM: remove unnecessary mach/hardware.h includes
      ARM: pci: make pcibios_assign_all_busses use pci_has_flag
      ARM: convert PCI defines to variables
      ARM: set vga memory base at run-time

 arch/arm/include/asm/pci.h                       |   12 ++++-
 arch/arm/include/asm/vga.h                       |    5 +-
 arch/arm/lib/ecard.S                             |    1 -
 arch/arm/lib/io-readsw-armv3.S                   |    1 -
 arch/arm/lib/io-writesw-armv3.S                  |    1 -
 arch/arm/mach-bcmring/include/mach/hardware.h    |    2 -
 arch/arm/mach-cns3xxx/cns3420vb.c                |    1 -
 arch/arm/mach-cns3xxx/include/mach/hardware.h    |   22 -------
 arch/arm/mach-cns3xxx/pcie.c                     |    3 +
 arch/arm/mach-dove/include/mach/hardware.h       |    7 --
 arch/arm/mach-dove/pcie.c                        |    3 +
 arch/arm/mach-ep93xx/include/mach/hardware.h     |    2 -
 arch/arm/mach-footbridge/dc21285.c               |    3 +
 arch/arm/mach-footbridge/include/mach/hardware.h |    5 --
 arch/arm/mach-integrator/include/mach/hardware.h |    7 --
 arch/arm/mach-integrator/pci_v3.c                |    5 ++
 arch/arm/mach-iop13xx/include/mach/hardware.h    |    7 --
 arch/arm/mach-iop13xx/pci.c                      |    5 +-
 arch/arm/mach-iop32x/include/mach/hardware.h     |    3 -
 arch/arm/mach-iop33x/include/mach/hardware.h     |    3 -
 arch/arm/mach-ixp2000/include/mach/hardware.h    |    8 ---
 arch/arm/mach-ixp2000/pci.c                      |    5 ++
 arch/arm/mach-ixp23xx/include/mach/hardware.h    |    4 -
 arch/arm/mach-ixp23xx/pci.c                      |    5 ++
 arch/arm/mach-ixp4xx/common-pci.c                |    5 ++
 arch/arm/mach-ixp4xx/include/mach/hardware.h     |    5 --
 arch/arm/mach-kirkwood/include/mach/hardware.h   |    7 --
 arch/arm/mach-kirkwood/pcie.c                    |    3 +
 arch/arm/mach-ks8695/include/mach/hardware.h     |    9 ---
 arch/arm/mach-ks8695/pci.c                       |    3 +
 arch/arm/mach-mv78xx0/include/mach/hardware.h    |    7 --
 arch/arm/mach-mv78xx0/pcie.c                     |    3 +
 arch/arm/mach-orion5x/include/mach/hardware.h    |    7 --
 arch/arm/mach-orion5x/pci.c                      |    2 +
 arch/arm/mach-pxa/cm-x2xx-pci.c                  |    3 +
 arch/arm/mach-pxa/include/mach/hardware.h        |    3 -
 arch/arm/mach-sa1100/include/mach/hardware.h     |    8 ---
 arch/arm/mach-sa1100/pci-nanoengine.c            |    3 +
 arch/arm/mach-shark/include/mach/hardware.h      |    6 --
 arch/arm/mach-shark/pci.c                        |   12 +++-
 arch/arm/mach-tegra/include/mach/hardware.h      |   28 ---------
 arch/arm/mach-tegra/include/mach/system.h        |    1 -
 arch/arm/mach-tegra/io.c                         |    1 -
 arch/arm/mach-tegra/pcie.c                       |    2 +
 arch/arm/mach-tegra/platsmp.c                    |    1 -
 arch/arm/mach-versatile/include/mach/hardware.h  |    6 --
 arch/arm/mach-versatile/pci.c                    |    3 +
 arch/arm/mm/iomap.c                              |   12 ++++
 arch/arm/mm/proc-xsc3.S                          |    1 -
 arch/arm/plat-iop/pci.c                          |    3 +
 arch/microblaze/include/asm/pci-bridge.h         |   67
+++------------------
 arch/powerpc/include/asm/pci-bridge.h            |   50 +----------------
 arch/powerpc/include/asm/pci.h                   |    2 +-
 arch/powerpc/kernel/pci-common.c                 |   22 ++++----
 arch/powerpc/kernel/pci_32.c                     |    2 +-
 arch/powerpc/kernel/pci_64.c                     |    4 +-
 arch/powerpc/kernel/rtas_pci.c                   |    2 +-
 arch/powerpc/platforms/40x/ep405.c               |    2 +-
 arch/powerpc/platforms/40x/ppc40x_simple.c       |    2 +-
 arch/powerpc/platforms/40x/walnut.c              |    2 +-
 arch/powerpc/platforms/44x/canyonlands.c         |    2 +-
 arch/powerpc/platforms/44x/ebony.c               |    2 +-
 arch/powerpc/platforms/44x/ppc44x_simple.c       |    2 +-
 arch/powerpc/platforms/44x/sam440ep.c            |    2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pci.c        |    2 +-
 arch/powerpc/platforms/82xx/pq2.c                |    2 +-
 arch/powerpc/platforms/chrp/pci.c                |    2 +-
 arch/powerpc/platforms/powermac/pci.c            |    6 +-
 arch/powerpc/sysdev/fsl_pci.c                    |    4 +-
 arch/powerpc/sysdev/grackle.c                    |    2 +-
 arch/powerpc/sysdev/ppc4xx_pci.c                 |    2 +-
 include/asm-generic/pci-bridge.h                 |   62
++++++++++++++++++++
 72 files changed, 198 insertions(+), 311 deletions(-)
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/hardware.h
 create mode 100644 include/asm-generic/pci-bridge.h
