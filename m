From: viresh.kumar@st.com (Viresh KUMAR)
Date: Thu, 25 Mar 2010 14:10:43 +0530
Subject: [PATCH V2 Resend 00/12] Adding Support for SPEAr Platform under ARM
	architecture
Message-ID: <1269506455-15173-1-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following set of patches are for adding ST Microelctronics SPEAr Platform under
ARM architecture in Linux.

Hierarchy in SPEAr is as follows:
SPEAr (Platform)
	- SPEAr3XX (3XX SOC series, based on ARM9)
		- SPEAr300 (SOC)
			- SPEAr300_EVB (Evaluation Board)
		- SPEAr310 (SOC)
			- SPEAr310_EVB (Evaluation Board)
		- SPEAr320 (SOC)
			- SPEAr320_EVB (Evaluation Board)
	- SPEAr6XX (6XX SOC series, based on ARM9)
		- SPEAr600 (SOC)
			- SPEAr600_EVB (Evaluation Board)
	- SPEAr13XX (13XX SOC series, based on ARM CORTEXA9)
		- SPEAr1300 (SOC)

Current patch will add support for SPEAr3XX and SPEAr6XX family. SPEAr13XX is
under development phase.

Changes from V1:

1. Changes done according to review comments
2. Added support for GPIO PL061
3. Removed unnecessary inclusions from defconfigs
4. Removed GPT driver. GPT code merged with time.c
5. Added support for pad multiplexing for spear

Viresh Kumar (12):
  ST SPEAr: Added ARM PrimeXsys System Controller SP810 header file
  ST SPEAr: Added basic header files for SPEAr3xx machine family
  ST SPEAr: Added basic header files for SPEAr6xx machine family
  ST SPEAr: Added basic header files for SPEAr platform
  ST SPEAr: Added clock framework for SPEAr platform and machines
  ST SPEAr: Added source files for SPEAr platform
  ST SPEAr: Added source files for SPEAr3xx machine family
  ST SPEAr: Added source files for SPEAr6xx machine family
  ST SPEAr: Added support for SPEAr platform and machines in arch/arm/
  ST SPEAr: Added default configuration files for SPEAr machines
  ST SPEAr: Updated Maintainers and added Documentation/arm/SPEAr
  ST SPEAr: Adding gpio pad multiplexing support

 Documentation/arm/00-INDEX                        |    2 +
 Documentation/arm/SPEAr/overview.txt              |   60 ++
 MAINTAINERS                                       |   40 ++
 arch/arm/Kconfig                                  |   13 +
 arch/arm/Makefile                                 |    5 +
 arch/arm/configs/spear300_defconfig               |  773 ++++++++++++++++++++
 arch/arm/configs/spear310_defconfig               |  775 +++++++++++++++++++++
 arch/arm/configs/spear320_defconfig               |  775 +++++++++++++++++++++
 arch/arm/configs/spear600_defconfig               |  760 ++++++++++++++++++++
 arch/arm/include/asm/hardware/sp810.h             |   59 ++
 arch/arm/mach-spear3xx/Kconfig                    |   33 +
 arch/arm/mach-spear3xx/Kconfig300                 |   17 +
 arch/arm/mach-spear3xx/Kconfig310                 |   17 +
 arch/arm/mach-spear3xx/Kconfig320                 |   17 +
 arch/arm/mach-spear3xx/Makefile                   |   26 +
 arch/arm/mach-spear3xx/Makefile.boot              |    3 +
 arch/arm/mach-spear3xx/clock.c                    |  389 +++++++++++
 arch/arm/mach-spear3xx/include/mach/clkdev.h      |   19 +
 arch/arm/mach-spear3xx/include/mach/debug-macro.S |   14 +
 arch/arm/mach-spear3xx/include/mach/entry-macro.S |   46 ++
 arch/arm/mach-spear3xx/include/mach/generic.h     |  205 ++++++
 arch/arm/mach-spear3xx/include/mach/gpio.h        |   19 +
 arch/arm/mach-spear3xx/include/mach/hardware.h    |   20 +
 arch/arm/mach-spear3xx/include/mach/io.h          |   19 +
 arch/arm/mach-spear3xx/include/mach/irqs.h        |   65 ++
 arch/arm/mach-spear3xx/include/mach/memory.h      |   19 +
 arch/arm/mach-spear3xx/include/mach/misc_regs.h   |  163 +++++
 arch/arm/mach-spear3xx/include/mach/spear.h       |  144 ++++
 arch/arm/mach-spear3xx/include/mach/spear300.h    |   67 ++
 arch/arm/mach-spear3xx/include/mach/spear310.h    |   46 ++
 arch/arm/mach-spear3xx/include/mach/spear320.h    |   70 ++
 arch/arm/mach-spear3xx/include/mach/system.h      |   19 +
 arch/arm/mach-spear3xx/include/mach/timex.h       |   19 +
 arch/arm/mach-spear3xx/include/mach/uncompress.h  |   19 +
 arch/arm/mach-spear3xx/include/mach/vmalloc.h     |   19 +
 arch/arm/mach-spear3xx/spear300.c                 |  403 +++++++++++
 arch/arm/mach-spear3xx/spear300_evb.c             |   77 ++
 arch/arm/mach-spear3xx/spear310.c                 |  154 ++++
 arch/arm/mach-spear3xx/spear310_evb.c             |   84 +++
 arch/arm/mach-spear3xx/spear320.c                 |  399 +++++++++++
 arch/arm/mach-spear3xx/spear320_evb.c             |   81 +++
 arch/arm/mach-spear3xx/spear3xx.c                 |  548 +++++++++++++++
 arch/arm/mach-spear6xx/Kconfig                    |   20 +
 arch/arm/mach-spear6xx/Kconfig600                 |   17 +
 arch/arm/mach-spear6xx/Makefile                   |   12 +
 arch/arm/mach-spear6xx/Makefile.boot              |    3 +
 arch/arm/mach-spear6xx/clock.c                    |  483 +++++++++++++
 arch/arm/mach-spear6xx/include/mach/clkdev.h      |   19 +
 arch/arm/mach-spear6xx/include/mach/debug-macro.S |   14 +
 arch/arm/mach-spear6xx/include/mach/entry-macro.S |   55 ++
 arch/arm/mach-spear6xx/include/mach/generic.h     |   45 ++
 arch/arm/mach-spear6xx/include/mach/gpio.h        |   19 +
 arch/arm/mach-spear6xx/include/mach/hardware.h    |   21 +
 arch/arm/mach-spear6xx/include/mach/io.h          |   20 +
 arch/arm/mach-spear6xx/include/mach/irqs.h        |   96 +++
 arch/arm/mach-spear6xx/include/mach/memory.h      |   19 +
 arch/arm/mach-spear6xx/include/mach/misc_regs.h   |  173 +++++
 arch/arm/mach-spear6xx/include/mach/spear.h       |  173 +++++
 arch/arm/mach-spear6xx/include/mach/spear600.h    |   21 +
 arch/arm/mach-spear6xx/include/mach/system.h      |   19 +
 arch/arm/mach-spear6xx/include/mach/timex.h       |   19 +
 arch/arm/mach-spear6xx/include/mach/uncompress.h  |   19 +
 arch/arm/mach-spear6xx/include/mach/vmalloc.h     |   19 +
 arch/arm/mach-spear6xx/spear600.c                 |   25 +
 arch/arm/mach-spear6xx/spear600_evb.c             |   51 ++
 arch/arm/mach-spear6xx/spear6xx.c                 |  158 +++++
 arch/arm/plat-spear/Kconfig                       |   31 +
 arch/arm/plat-spear/Makefile                      |    6 +
 arch/arm/plat-spear/clock.c                       |  435 ++++++++++++
 arch/arm/plat-spear/include/plat/clkdev.h         |   20 +
 arch/arm/plat-spear/include/plat/clock.h          |  126 ++++
 arch/arm/plat-spear/include/plat/debug-macro.S    |   38 +
 arch/arm/plat-spear/include/plat/gpio.h           |   24 +
 arch/arm/plat-spear/include/plat/io.h             |   22 +
 arch/arm/plat-spear/include/plat/memory.h         |   20 +
 arch/arm/plat-spear/include/plat/padmux.h         |   92 +++
 arch/arm/plat-spear/include/plat/system.h         |   41 ++
 arch/arm/plat-spear/include/plat/timex.h          |   19 +
 arch/arm/plat-spear/include/plat/uncompress.h     |   43 ++
 arch/arm/plat-spear/include/plat/vmalloc.h        |   19 +
 arch/arm/plat-spear/padmux.c                      |  164 +++++
 arch/arm/plat-spear/time.c                        |  292 ++++++++
 82 files changed, 9414 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/arm/SPEAr/overview.txt
 create mode 100644 arch/arm/configs/spear300_defconfig
 create mode 100644 arch/arm/configs/spear310_defconfig
 create mode 100644 arch/arm/configs/spear320_defconfig
 create mode 100644 arch/arm/configs/spear600_defconfig
 create mode 100644 arch/arm/include/asm/hardware/sp810.h
 create mode 100644 arch/arm/mach-spear3xx/Kconfig
 create mode 100644 arch/arm/mach-spear3xx/Kconfig300
 create mode 100644 arch/arm/mach-spear3xx/Kconfig310
 create mode 100644 arch/arm/mach-spear3xx/Kconfig320
 create mode 100644 arch/arm/mach-spear3xx/Makefile
 create mode 100644 arch/arm/mach-spear3xx/Makefile.boot
 create mode 100755 arch/arm/mach-spear3xx/clock.c
 create mode 100644 arch/arm/mach-spear3xx/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-spear3xx/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-spear3xx/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-spear3xx/include/mach/generic.h
 create mode 100644 arch/arm/mach-spear3xx/include/mach/gpio.h
 create mode 100644 arch/arm/mach-spear3xx/include/mach/hardware.h
 create mode 100644 arch/arm/mach-spear3xx/include/mach/io.h
 create mode 100644 arch/arm/mach-spear3xx/include/mach/irqs.h
 create mode 100644 arch/arm/mach-spear3xx/include/mach/memory.h
 create mode 100755 arch/arm/mach-spear3xx/include/mach/misc_regs.h
 create mode 100644 arch/arm/mach-spear3xx/include/mach/spear.h
 create mode 100644 arch/arm/mach-spear3xx/include/mach/spear300.h
 create mode 100644 arch/arm/mach-spear3xx/include/mach/spear310.h
 create mode 100644 arch/arm/mach-spear3xx/include/mach/spear320.h
 create mode 100644 arch/arm/mach-spear3xx/include/mach/system.h
 create mode 100644 arch/arm/mach-spear3xx/include/mach/timex.h
 create mode 100644 arch/arm/mach-spear3xx/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-spear3xx/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-spear3xx/spear300.c
 create mode 100644 arch/arm/mach-spear3xx/spear300_evb.c
 create mode 100644 arch/arm/mach-spear3xx/spear310.c
 create mode 100644 arch/arm/mach-spear3xx/spear310_evb.c
 create mode 100644 arch/arm/mach-spear3xx/spear320.c
 create mode 100644 arch/arm/mach-spear3xx/spear320_evb.c
 create mode 100644 arch/arm/mach-spear3xx/spear3xx.c
 create mode 100644 arch/arm/mach-spear6xx/Kconfig
 create mode 100644 arch/arm/mach-spear6xx/Kconfig600
 create mode 100644 arch/arm/mach-spear6xx/Makefile
 create mode 100644 arch/arm/mach-spear6xx/Makefile.boot
 create mode 100755 arch/arm/mach-spear6xx/clock.c
 create mode 100644 arch/arm/mach-spear6xx/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-spear6xx/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-spear6xx/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-spear6xx/include/mach/generic.h
 create mode 100644 arch/arm/mach-spear6xx/include/mach/gpio.h
 create mode 100644 arch/arm/mach-spear6xx/include/mach/hardware.h
 create mode 100644 arch/arm/mach-spear6xx/include/mach/io.h
 create mode 100755 arch/arm/mach-spear6xx/include/mach/irqs.h
 create mode 100644 arch/arm/mach-spear6xx/include/mach/memory.h
 create mode 100755 arch/arm/mach-spear6xx/include/mach/misc_regs.h
 create mode 100644 arch/arm/mach-spear6xx/include/mach/spear.h
 create mode 100644 arch/arm/mach-spear6xx/include/mach/spear600.h
 create mode 100644 arch/arm/mach-spear6xx/include/mach/system.h
 create mode 100644 arch/arm/mach-spear6xx/include/mach/timex.h
 create mode 100644 arch/arm/mach-spear6xx/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-spear6xx/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-spear6xx/spear600.c
 create mode 100644 arch/arm/mach-spear6xx/spear600_evb.c
 create mode 100644 arch/arm/mach-spear6xx/spear6xx.c
 create mode 100644 arch/arm/plat-spear/Kconfig
 create mode 100644 arch/arm/plat-spear/Makefile
 create mode 100755 arch/arm/plat-spear/clock.c
 create mode 100644 arch/arm/plat-spear/include/plat/clkdev.h
 create mode 100755 arch/arm/plat-spear/include/plat/clock.h
 create mode 100644 arch/arm/plat-spear/include/plat/debug-macro.S
 create mode 100644 arch/arm/plat-spear/include/plat/gpio.h
 create mode 100644 arch/arm/plat-spear/include/plat/io.h
 create mode 100644 arch/arm/plat-spear/include/plat/memory.h
 create mode 100644 arch/arm/plat-spear/include/plat/padmux.h
 create mode 100644 arch/arm/plat-spear/include/plat/system.h
 create mode 100644 arch/arm/plat-spear/include/plat/timex.h
 create mode 100644 arch/arm/plat-spear/include/plat/uncompress.h
 create mode 100644 arch/arm/plat-spear/include/plat/vmalloc.h
 create mode 100644 arch/arm/plat-spear/padmux.c
 create mode 100644 arch/arm/plat-spear/time.c
