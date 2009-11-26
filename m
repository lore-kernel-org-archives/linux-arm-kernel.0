From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Fri, 27 Nov 2009 05:25:25 +0530
Subject: [PATCH v4 0/6] ARM:  ST-Ericsson's U8500 SMP platform, a new patch set
Message-ID: <1259279725.13327.65.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Date: Fri, 27 Nov 2009 16:24:37 +0530

This is the v4 version of patch set which adds U8500 machine.
v3 patch was posted to this list on 12th October 2009 and I 
have addressed the comments from Jean christophe on this version. 

The patch series has a dependency on the patch 5786/1 available in
Russell's patch tracking system. 5786/1 must be applied first.

---
ChangeLog v3->v4
- identation and better naming convention 
from SPI to SHPI for Shared Peripheral 
Interrupts  (Jean Christophe)
- reuse MTU code from nomadik (Jean Christophe)
--- 

srinidhi kasagar (6):
  ARM: U8500 register definitions
  ARM: U8500 clock framework
  ARM: U8500 core machine support
  ARM: U8500 Makefile.boot
  ARM nomadik: enable U8500 for common platform
  ARM: U8500 integrate to ARM architecture

 arch/arm/Kconfig                                   |   20 ++-
 arch/arm/Makefile                                  |    1 +
 arch/arm/mach-ux500/Kconfig                        |   15 ++
 arch/arm/mach-ux500/Makefile                       |    8 +
 .../{mach-footbridge => mach-ux500}/Makefile.boot  |    0
 arch/arm/mach-ux500/board-mop500.c                 |  158 +++++++++++++++++
 arch/arm/mach-ux500/clock.c                        |   95 +++++++++++
 arch/arm/mach-ux500/cpu-u8500.c                    |   64 +++++++
 arch/arm/mach-ux500/headsmp.S                      |   38 ++++
 .../include/mach/clkdev.h                          |    0
 arch/arm/mach-ux500/include/mach/debug-macro.S     |   19 ++
 arch/arm/mach-ux500/include/mach/entry-macro.S     |   89 ++++++++++
 arch/arm/mach-ux500/include/mach/hardware.h        |  131 +++++++++++++++
 arch/arm/mach-ux500/include/mach/io.h              |   22 +++
 arch/arm/mach-ux500/include/mach/irqs.h            |   71 ++++++++
 arch/arm/mach-ux500/include/mach/memory.h          |   18 ++
 arch/arm/mach-ux500/include/mach/setup.h           |   23 +++
 arch/arm/mach-ux500/include/mach/smp.h             |   32 ++++
 arch/arm/mach-ux500/include/mach/system.h          |   25 +++
 arch/arm/mach-ux500/include/mach/timex.h           |    6 +
 arch/arm/mach-ux500/include/mach/uncompress.h      |   58 +++++++
 arch/arm/mach-ux500/include/mach/vmalloc.h         |   18 ++
 arch/arm/mach-ux500/localtimer.c                   |   28 +++
 arch/arm/mach-ux500/platsmp.c                      |  177 ++++++++++++++++++++
 arch/arm/plat-nomadik/Kconfig                      |    2 +-
 25 files changed, 1113 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-ux500/Kconfig
 create mode 100644 arch/arm/mach-ux500/Makefile
 copy arch/arm/{mach-footbridge => mach-ux500}/Makefile.boot (100%)
 create mode 100644 arch/arm/mach-ux500/board-mop500.c
 create mode 100644 arch/arm/mach-ux500/clock.c
 create mode 100644 arch/arm/mach-ux500/cpu-u8500.c
 create mode 100644 arch/arm/mach-ux500/headsmp.S
 copy arch/arm/{mach-bcmring => mach-ux500}/include/mach/clkdev.h (100%)
 create mode 100644 arch/arm/mach-ux500/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-ux500/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-ux500/include/mach/hardware.h
 create mode 100644 arch/arm/mach-ux500/include/mach/io.h
 create mode 100644 arch/arm/mach-ux500/include/mach/irqs.h
 create mode 100644 arch/arm/mach-ux500/include/mach/memory.h
 create mode 100644 arch/arm/mach-ux500/include/mach/setup.h
 create mode 100644 arch/arm/mach-ux500/include/mach/smp.h
 create mode 100644 arch/arm/mach-ux500/include/mach/system.h
 create mode 100644 arch/arm/mach-ux500/include/mach/timex.h
 create mode 100644 arch/arm/mach-ux500/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-ux500/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-ux500/localtimer.c
 create mode 100644 arch/arm/mach-ux500/platsmp.c
