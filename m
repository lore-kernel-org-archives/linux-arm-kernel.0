From: rubini@gnudd.com (Alessandro Rubini)
Date: Thu, 1 Mar 2012 14:28:24 +0100
Subject: [PATCH 0/4] Initial steps to compile AMBA for x86
Message-ID: <cover.1330607068.git.rubini@gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm working on the sta2x11 I/O Hub, which is basically a bridge from
PCIe to AMBA.  While current code uses PCI drivers for all the
PrimeCell devices (with a lot of code duplication), I think we should
be able to compile native amba drivers. The chip has uart, spi, mmc, i2c
and dma cells, for which an AMBA driver is already in the kernel.

This patch-set is the first steps needed to build amba drivers for
x86.  I'm currently using the pl011 UART as a testbed, and it's up on
my system (with other not-ready-to-be-published patches).

As for sizes, there are a number of users of <asm/sizes.h>. If these
initial patches are accepted, I'll take care to convert other stuff,
add a #warning to asm/sizes.h and remove it after a pair of releases.

The patches have been build-tested under ARM with versatile_defconfig,
at91sam9263_defconfig, vexpress_defconfig and realview-smp_defconfig
-- as well as sta2x11 on x86.

Alessandro Rubini (4):
  x86: add NO_IRQ macro
  sizes.h: move from asm-generic to <linux/sizes.h>
  amba: use the new linux/sizes.h
  ARM: use the new linux/sizes.h

 arch/arm/include/asm/memory.h |    2 +-
 arch/arm/mm/dma-mapping.c     |    2 +-
 arch/arm/mm/init.c            |    2 +-
 arch/arm/mm/ioremap.c         |    2 +-
 arch/arm/mm/mmu.c             |    2 +-
 arch/x86/include/asm/irq.h    |    2 +
 drivers/amba/bus.c            |    2 +-
 include/asm-generic/sizes.h   |   49 +---------------------------------------
 include/linux/sizes.h         |   47 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 57 insertions(+), 53 deletions(-)
 create mode 100644 include/linux/sizes.h

-- 
1.7.7.2
