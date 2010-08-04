From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Aug 2010 19:24:47 +0200
Subject: [PATCH 0/5] arm/versatile: generalize PCI code
Message-ID: <1280942692-32079-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In oder to make the PCI code in the versatile platform more
useful, I'm proposing this set of patches, which enables
using Virtio and other PCI devices including those that
require I/O space mappings to work on the versatile-pb,
realview-eb and realview-pb1176 boards.

Because of lack of actual hardware, I have only tested
this in qemu, so I would appreciate someone trying the
patches on actual hardware.

Arnd Bergmann (5):
  arm/versatile: move pci code to plat-versatile
  arm/versatile: boot-time configure xilinx-pci
  arm/versatile: enable PCI I/O space
  arm/realview: enable PCI for realview-eb and realview-pb1176
  arm: Enable support for virtio

 arch/arm/Kconfig                                  |    9 +-
 arch/arm/mach-realview/Kconfig                    |    2 +
 arch/arm/mach-realview/include/mach/hardware.h    |   14 +-
 arch/arm/mach-realview/include/mach/io.h          |    6 +-
 arch/arm/mach-realview/include/mach/platform.h    |   23 +-
 arch/arm/mach-realview/realview_eb.c              |   70 ++++-
 arch/arm/mach-realview/realview_pb1176.c          |   68 ++++
 arch/arm/mach-versatile/Kconfig                   |    1 +
 arch/arm/mach-versatile/Makefile                  |    1 -
 arch/arm/mach-versatile/core.c                    |   19 +-
 arch/arm/mach-versatile/include/mach/hardware.h   |   24 +-
 arch/arm/mach-versatile/include/mach/io.h         |    6 +-
 arch/arm/mach-versatile/include/mach/platform.h   |    4 +-
 arch/arm/mach-versatile/pci.c                     |  361 ---------------------
 arch/arm/mach-versatile/versatile_pb.c            |   47 +++
 arch/arm/plat-versatile/Makefile                  |    1 +
 arch/arm/plat-versatile/include/plat/xilinx-pci.h |   24 ++
 arch/arm/plat-versatile/xilinx-pci.c              |  344 ++++++++++++++++++++
 18 files changed, 611 insertions(+), 413 deletions(-)
 delete mode 100644 arch/arm/mach-versatile/pci.c
 create mode 100644 arch/arm/plat-versatile/include/plat/xilinx-pci.h
 create mode 100644 arch/arm/plat-versatile/xilinx-pci.c
