From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 14 Aug 2013 15:10:11 -0400
Subject: [GIT PULL 1/2] ARM: mvebu: MSI/PCI changes for v3.12
Message-ID: <20130814191011.GD13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This branch is a dependency for both the mvebu MSI series (2/2 in this
thread), and Thierry Reding's patch series coming to you from Stephen
Warren.

thx,

Jason.


The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/msi-3.12

for you to fetch changes up to 6a4324ebf5cf412d55fd1ea259d4dd29fb8f90e8:

  PCI: msi: add default MSI operations for !HAVE_GENERIC_HARDIRQS platforms (2013-08-13 15:16:30 +0000)

----------------------------------------------------------------
mvebu msi pci changes for v3.12

 - introduce support for MSI on PCI
 - fix s390 build breakage when !HAVE_GENERIC_HARDIRQS

NOTE: This branch is a dependency for changes going though arm-soc from both
Thomas Petazzoni and Thierry Reding.

----------------------------------------------------------------
Thierry Reding (1):
      PCI: Introduce new MSI chip infrastructure

Thomas Petazzoni (5):
      PCI: use weak functions for MSI arch-specific functions
      PCI: remove ARCH_SUPPORTS_MSI kconfig option
      of: pci: add registry of MSI chips
      ARM: pci: add ->add_bus() and ->remove_bus() hooks to hw_pci
      PCI: msi: add default MSI operations for !HAVE_GENERIC_HARDIRQS platforms

 arch/arm/Kconfig                |  1 -
 arch/arm/include/asm/mach/pci.h |  4 ++
 arch/arm/kernel/bios32.c        | 16 ++++++++
 arch/ia64/Kconfig               |  1 -
 arch/mips/Kconfig               |  2 -
 arch/mips/include/asm/pci.h     |  5 ---
 arch/powerpc/Kconfig            |  1 -
 arch/powerpc/include/asm/pci.h  |  5 ---
 arch/s390/Kconfig               |  1 -
 arch/s390/include/asm/pci.h     |  4 --
 arch/sparc/Kconfig              |  1 -
 arch/tile/Kconfig               |  1 -
 arch/x86/Kconfig                |  1 -
 arch/x86/include/asm/pci.h      | 30 ---------------
 arch/x86/kernel/x86_init.c      | 24 ++++++++++++
 drivers/of/of_pci.c             | 45 ++++++++++++++++++++++
 drivers/pci/Kconfig             |  4 --
 drivers/pci/msi.c               | 85 ++++++++++++++++++++++++++++++-----------
 drivers/pci/probe.c             |  1 +
 include/linux/msi.h             | 21 +++++++++-
 include/linux/of_pci.h          | 12 ++++++
 include/linux/pci.h             |  1 +
 22 files changed, 185 insertions(+), 81 deletions(-)
