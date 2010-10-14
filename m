From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Oct 2010 18:10:50 +0200
Subject: [PATCH 0/7] arm/versatile PCI support, second try
Message-ID: <1287072657-32477-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With lots of help and testing from Peter Maydell, I've completed
a second version of the PCI support for the versatile platform,
which works much better now on real hardware, although it does
not improve existing qemu setups.

Please review and test.

Arnd Bergmann (7):
  arm/versatile: move pci code to plat-versatile
  arm/versatile: boot-time configure xilinx-pci
  arm/versatile: enable PCI I/O space
  arm/versatile: use correct PCI IRQ swizzling
  arm/realview: fix building PB-A8 and PBX with CONFIG_PCI
  arm/realview: enable PCI for realview-eb and realview-pb1176
  arm: Enable support for virtio

 arch/arm/Kconfig                                   |    9 +-
 arch/arm/mach-realview/include/mach/board-eb.h     |   19 +
 arch/arm/mach-realview/include/mach/board-pb1176.h |    1 +
 arch/arm/mach-realview/include/mach/hardware.h     |   14 +-
 arch/arm/mach-realview/include/mach/io.h           |    6 +-
 arch/arm/mach-realview/include/mach/irqs-eb.h      |    5 +
 arch/arm/mach-realview/include/mach/irqs-pb1176.h  |    5 +-
 arch/arm/mach-realview/realview_eb.c               |   84 +++++-
 arch/arm/mach-realview/realview_pb1176.c           |  102 ++++++
 arch/arm/mach-realview/realview_pba8.c             |    2 +-
 arch/arm/mach-realview/realview_pbx.c              |    2 +-
 arch/arm/mach-versatile/Makefile                   |    1 -
 arch/arm/mach-versatile/core.c                     |   19 +-
 arch/arm/mach-versatile/include/mach/hardware.h    |   15 +-
 arch/arm/mach-versatile/include/mach/io.h          |    6 +-
 arch/arm/mach-versatile/include/mach/platform.h    |    4 +-
 arch/arm/mach-versatile/pci.c                      |  361 --------------------
 arch/arm/mach-versatile/versatile_pb.c             |   62 ++++
 arch/arm/plat-versatile/Makefile                   |    1 +
 arch/arm/plat-versatile/include/plat/xilinx-pci.h  |   28 ++
 arch/arm/plat-versatile/xilinx-pci.c               |  356 +++++++++++++++++++
 21 files changed, 705 insertions(+), 397 deletions(-)
 delete mode 100644 arch/arm/mach-versatile/pci.c
 create mode 100644 arch/arm/plat-versatile/include/plat/xilinx-pci.h
 create mode 100644 arch/arm/plat-versatile/xilinx-pci.c
