From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 05 Feb 2010 20:14:40 +0900
Subject: [PATCH 00/06] ARM: Initial SuperH Mobile ARM support V2
Message-ID: <20100205111440.17065.33296.sendpatchset@rxone.opensource.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: Initial SuperH Mobile ARM support V2

[PATCH 01/06] ARM: SuperH Mobile ARM, sh7367 and G3EVM support V2
[PATCH 02/06] ARM: Add sh7377 and G4EVM support V2
[PATCH 03/06] ARM: Add sh7372 and AP4EVB support V2
[PATCH 04/06] sh: Build drivers/sh for SuperH Mobile ARM
[PATCH 05/06] sh: Let INTC set IRQF_VALID on ARM platforms V2
[PATCH 06/06] sh-sci: SuperH Mobile ARM support V2

Here comes V2 of the initial SuperH Mobile ARM patch set.

Features:
 - Console: Serial console using drivers/serial/sh-sci.c
 - Timer: Early platform driver using drivers/clocksource/sh_cmt.c
 - Interrupts: Minimal INTC support using drivers/sh/intc.c
 - Clocks: Dummy static implementation to enable above drivers
 - Defconfigs: Omitted

On top of this there will be a bunch of feature patches for
the interrupt controller, gpio, clock framework, runtime pm
and of course driver support.

Since there are some dependencies on SuperH code I'd prefer
to handle the merge through the sh-2.6 tree. Hope that is ok,
please let me know if you have some other preference.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/Kconfig                                  |    7 
 arch/arm/Makefile                                 |    1 
 arch/arm/mach-shmobile/Kconfig                    |   81 ++++++
 arch/arm/mach-shmobile/Makefile                   |   16 +
 arch/arm/mach-shmobile/Makefile.boot              |    9 
 arch/arm/mach-shmobile/board-ap4evb.c             |  127 ++++++++++
 arch/arm/mach-shmobile/board-g3evm.c              |  127 ++++++++++
 arch/arm/mach-shmobile/board-g4evm.c              |  127 ++++++++++
 arch/arm/mach-shmobile/clock-sh7367.c             |   89 +++++++
 arch/arm/mach-shmobile/include/mach/clkdev.h      |    7 
 arch/arm/mach-shmobile/include/mach/common.h      |   19 +
 arch/arm/mach-shmobile/include/mach/dma.h         |    1 
 arch/arm/mach-shmobile/include/mach/entry-macro.S |   39 +++
 arch/arm/mach-shmobile/include/mach/gpio.h        |    1 
 arch/arm/mach-shmobile/include/mach/hardware.h    |    7 
 arch/arm/mach-shmobile/include/mach/io.h          |    9 
 arch/arm/mach-shmobile/include/mach/irqs.h        |   10 
 arch/arm/mach-shmobile/include/mach/memory.h      |    7 
 arch/arm/mach-shmobile/include/mach/system.h      |   14 +
 arch/arm/mach-shmobile/include/mach/timex.h       |    6 
 arch/arm/mach-shmobile/include/mach/uncompress.h  |   21 +
 arch/arm/mach-shmobile/include/mach/vmalloc.h     |    6 
 arch/arm/mach-shmobile/setup-sh7367.c             |  241 +++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh7372.c             |  241 +++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh7377.c             |  260 +++++++++++++++++++++
 arch/arm/mach-shmobile/timer.c                    |   46 +++
 drivers/Makefile                                  |    1 
 drivers/serial/Kconfig                            |    2 
 drivers/serial/sh-sci.h                           |   23 +
 drivers/sh/intc.c                                 |   10 
 30 files changed, 1544 insertions(+), 11 deletions(-)
