From: colin.tuckley@arm.com (Colin Tuckley)
Date: Wed, 20 Oct 2010 14:02:48 +0100
Subject: [PATCH 0/6] Add PCI support for ARM RealView boards
Message-ID: <20101020125554.22199.78597.stgit@e102602-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series implements the PCI support for the
ARM RealView NEC custom Northbridge based reference boards
(PBA8, PB11MPCore and PBX).

The boards have a PCIX root complex connected to PCI and
PCIe bridges. Each board has 2 PCI slots and 2 PCIe slots.

---

Colin Tuckley (6):
      ARM Realview PCIX build file changes
      ARM Realview PCIX board file changes
      ARM Realview PCIX IRQ include file changes
      ARM Realview PCIX map include file changes
      ARM: enable bridges in pci_common_init.
      Realview PCIX support - add main support module code


 arch/arm/Kconfig                                   |    6 
 arch/arm/kernel/bios32.c                           |    5 
 arch/arm/mach-realview/Makefile                    |    6 
 arch/arm/mach-realview/include/mach/board-pb11mp.h |   11 
 arch/arm/mach-realview/include/mach/board-pba8.h   |   11 
 arch/arm/mach-realview/include/mach/board-pbx.h    |   11 
 arch/arm/mach-realview/include/mach/hardware.h     |   53 ++
 arch/arm/mach-realview/include/mach/io.h           |   18 +
 arch/arm/mach-realview/include/mach/irqs-pb11mp.h  |   11 
 arch/arm/mach-realview/include/mach/irqs-pba8.h    |    7 
 arch/arm/mach-realview/include/mach/irqs-pbx.h     |    7 
 arch/arm/mach-realview/include/mach/platform.h     |   15 -
 arch/arm/mach-realview/pcix.c                      |  538 ++++++++++++++++++++
 arch/arm/mach-realview/realview_pb11mp.c           |   18 +
 arch/arm/mach-realview/realview_pba8.c             |   16 -
 arch/arm/mach-realview/realview_pbx.c              |   14 -
 16 files changed, 692 insertions(+), 55 deletions(-)
 create mode 100755 arch/arm/mach-realview/pcix.c

-- 
Colin Tuckley
