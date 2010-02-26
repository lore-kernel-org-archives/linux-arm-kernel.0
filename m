From: lethal@linux-sh.org (Paul Mundt)
Date: Fri, 26 Feb 2010 16:18:05 +0900
Subject: [GIT PULL] genesis updates for 2.6.34-rc1
Message-ID: <20100226071805.GA4435@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the initial batch of updates adding SH-Mobile G series support
for the merge window.

This has no particular merge order dependencies, but the usual
arch/arm/{Kconfig,Makefile} clashes were observed in -next (primarily
with the samsung tree). I'm also content to wait for the ARM tree to
merge, resolve the conflicts manually, and send them to Linus directly if
that makes things easier.

There are a few more patches that will come nearer the end of the window
once some of the other trees have merged and the outstanding dependencies
for the remaining patches have been dealt with, but that's just platform
data and driver updates, so nothing particularly noteworthy. I'll send
those to Linus directly unless there's a strong preference to funnel
everything through the ARM tree.

In any event, please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/genesis-2.6.git

Which contains:

Kuninori Morimoto (9):
      ARM: mach-shmobile: intc-sh7372 tidyup
      ARM: mach-shmobile: Add sh7372 pinmux support
      ARM: mach-shmobile: SMSC 9220 support for AP4EVB.
      ARM: mach-shmobile: ap4evb: Add SCIFA0 support
      ARM: mach-shmobile: ap4evb: Add tiny document
      ARM: mach-shmobile: ap4evb: Add LED support
      ARM: mach-shmobile: ap4evb: Add S6 debug switch support
      ARM: mach-shmobile: pfc-sh7377: modify KEYIN settings
      ARM: mach-shmobile: ap4evb: Add KEYSC support

Magnus Damm (14):
      ARM: mach-shmobile: SH-Mobile G3 support.
      ARM: mach-shmobile: SH-Mobile G4 support.
      ARM: mach-shmobile: SH-Mobile AP4 support.
      sh: Build drivers/sh for ARM-based SH-Mobile CPUs.
      sh: Let INTC set IRQF_VALID on ARM platforms.
      serial: sh-sci: Support ARM-based SH-Mobile CPUs.
      ARM: mach-shmobile: G3EVM, G4EVM and AP4EVB defconfigs
      ARM: mach-shmobile: optimize get_irqnr_preamble/and_base macros
      ARM: mach-shmobile: early console support using earlyprintk
      ARM: mach-shmobile: sh7367 INTCA support
      ARM: mach-shmobile: sh7377 INTCA support
      ARM: mach-shmobile: sh7372 INTCA support
      ARM: mach-shmobile: sh7367 and G3EVM pinmux support
      ARM: mach-shmobile: G3EVM USBHS support

NISHIMOTO Hiroki (2):
      ARM: mach-shmobile: sh7377 and G4EVM pinmux support
      ARM: mach-shmobile: G4EVM USBHS support

Paul Mundt (1):
      MAINTAINERS: Add entry for ARM-based SH-Mobile architecture.

 MAINTAINERS                                       |   10 +
 arch/arm/Kconfig                                  |    7 +
 arch/arm/Makefile                                 |    1 +
 arch/arm/configs/ap4evb_defconfig                 |  779 +++++++++
 arch/arm/configs/g3evm_defconfig                  |  774 +++++++++
 arch/arm/configs/g4evm_defconfig                  |  779 +++++++++
 arch/arm/mach-shmobile/Kconfig                    |   84 +
 arch/arm/mach-shmobile/Makefile                   |   22 +
 arch/arm/mach-shmobile/Makefile.boot              |    9 +
 arch/arm/mach-shmobile/board-ap4evb.c             |  301 ++++
 arch/arm/mach-shmobile/board-g3evm.c              |  211 +++
 arch/arm/mach-shmobile/board-g4evm.c              |  211 +++
 arch/arm/mach-shmobile/clock-sh7367.c             |   96 ++
 arch/arm/mach-shmobile/console.c                  |   31 +
 arch/arm/mach-shmobile/include/mach/clkdev.h      |    7 +
 arch/arm/mach-shmobile/include/mach/common.h      |   23 +
 arch/arm/mach-shmobile/include/mach/dma.h         |    1 +
 arch/arm/mach-shmobile/include/mach/entry-macro.S |   39 +
 arch/arm/mach-shmobile/include/mach/gpio.h        |   48 +
 arch/arm/mach-shmobile/include/mach/hardware.h    |    7 +
 arch/arm/mach-shmobile/include/mach/io.h          |    9 +
 arch/arm/mach-shmobile/include/mach/irqs.h        |   10 +
 arch/arm/mach-shmobile/include/mach/memory.h      |    7 +
 arch/arm/mach-shmobile/include/mach/sh7367.h      |  332 ++++
 arch/arm/mach-shmobile/include/mach/sh7372.h      |  434 +++++
 arch/arm/mach-shmobile/include/mach/sh7377.h      |  360 ++++
 arch/arm/mach-shmobile/include/mach/system.h      |   14 +
 arch/arm/mach-shmobile/include/mach/timex.h       |    6 +
 arch/arm/mach-shmobile/include/mach/uncompress.h  |   21 +
 arch/arm/mach-shmobile/include/mach/vmalloc.h     |    6 +
 arch/arm/mach-shmobile/intc-sh7367.c              |  270 +++
 arch/arm/mach-shmobile/intc-sh7372.c              |  369 +++++
 arch/arm/mach-shmobile/intc-sh7377.c              |  350 ++++
 arch/arm/mach-shmobile/pfc-sh7367.c               | 1801 +++++++++++++++++++++
 arch/arm/mach-shmobile/pfc-sh7372.c               | 1637 +++++++++++++++++++
 arch/arm/mach-shmobile/pfc-sh7377.c               | 1767 ++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh7367.c             |  198 +++
 arch/arm/mach-shmobile/setup-sh7372.c             |  199 +++
 arch/arm/mach-shmobile/setup-sh7377.c             |  215 +++
 arch/arm/mach-shmobile/timer.c                    |   46 +
 drivers/Makefile                                  |    1 +
 drivers/serial/Kconfig                            |    2 +-
 drivers/serial/sh-sci.h                           |   22 +-
 drivers/sh/intc.c                                 |   10 +-
 44 files changed, 11516 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/configs/ap4evb_defconfig
 create mode 100644 arch/arm/configs/g3evm_defconfig
 create mode 100644 arch/arm/configs/g4evm_defconfig
 create mode 100644 arch/arm/mach-shmobile/Kconfig
 create mode 100644 arch/arm/mach-shmobile/Makefile
 create mode 100644 arch/arm/mach-shmobile/Makefile.boot
 create mode 100644 arch/arm/mach-shmobile/board-ap4evb.c
 create mode 100644 arch/arm/mach-shmobile/board-g3evm.c
 create mode 100644 arch/arm/mach-shmobile/board-g4evm.c
 create mode 100644 arch/arm/mach-shmobile/clock-sh7367.c
 create mode 100644 arch/arm/mach-shmobile/console.c
 create mode 100644 arch/arm/mach-shmobile/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/common.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/dma.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-shmobile/include/mach/gpio.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/hardware.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/io.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/irqs.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/memory.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/sh7367.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/sh7372.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/sh7377.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/system.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/timex.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-shmobile/intc-sh7367.c
 create mode 100644 arch/arm/mach-shmobile/intc-sh7372.c
 create mode 100644 arch/arm/mach-shmobile/intc-sh7377.c
 create mode 100644 arch/arm/mach-shmobile/pfc-sh7367.c
 create mode 100644 arch/arm/mach-shmobile/pfc-sh7372.c
 create mode 100644 arch/arm/mach-shmobile/pfc-sh7377.c
 create mode 100644 arch/arm/mach-shmobile/setup-sh7367.c
 create mode 100644 arch/arm/mach-shmobile/setup-sh7372.c
 create mode 100644 arch/arm/mach-shmobile/setup-sh7377.c
 create mode 100644 arch/arm/mach-shmobile/timer.c
