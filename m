From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:57:00 +0530
Subject: [PATCH V6 00/10] Adding SPEAr13xx support
Message-ID: <cover.1298977719.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for SPEAr13xx machine family. Currently support
for to machines SPEAr1300 & SPEAr1310 are added.

Note: These patches were earlier sent as part of a larger patchset:
"Updating SPEAr Support"

Now it is divided into smaller patchsets. In order to apply these patches
cleanly following order of patchsets must be maintained.
- SPEAr3xx & SPEAr6xx Fixes
- SPEAr3xx & SPEAr6xx: Single Image solution and padmux updates
- Adding SPEAr13xx support
- Adding devices support for all spear machines
- Clock Framework & CPU Freq Updates

Bhupesh Sharma (1):
  ST SPEAr13xx: Adding support for SPEAr1310

Deepak Sikri (1):
  ST SPEAr13xx: Adding CPU hotplug support added for SMP platforms

Shiraz Hashim (7):
  ST SPEAr13xx: Adding machine specific header files
  ST SPEAr13xx: Adding machine specific src files
  ST SPEAr13xx: Adding support in SPEAr generic plat/
  ST SPEAr13xx: Added compilation support in arch/arm/
  ST SPEAr13xx: Adding default config file
  ST SPEAr13xx: Adding information in Documentation/ and MAINTAINERS
  ST SPEAr13xx: add L2 cache support

Vipin Kumar (1):
  ST SPEAr13xx: Add padmux support

 Documentation/arm/SPEAr/overview.txt               |   34 +-
 MAINTAINERS                                        |    6 +
 arch/arm/Kconfig                                   |    4 +-
 arch/arm/Makefile                                  |    2 +
 arch/arm/configs/spear13xx_defconfig               |   61 +
 arch/arm/mach-spear13xx/Kconfig                    |   32 +
 arch/arm/mach-spear13xx/Makefile                   |   21 +
 arch/arm/mach-spear13xx/Makefile.boot              |    3 +
 arch/arm/mach-spear13xx/clock.c                    | 1167 ++++++++++++++++++++
 arch/arm/mach-spear13xx/headsmp.S                  |   42 +
 arch/arm/mach-spear13xx/hotplug.c                  |  121 ++
 arch/arm/mach-spear13xx/include/mach/clkdev.h      |   19 +
 arch/arm/mach-spear13xx/include/mach/debug-macro.S |   14 +
 arch/arm/mach-spear13xx/include/mach/entry-macro.S |   22 +
 arch/arm/mach-spear13xx/include/mach/generic.h     |  261 +++++
 arch/arm/mach-spear13xx/include/mach/gpio.h        |   19 +
 arch/arm/mach-spear13xx/include/mach/hardware.h    |   31 +
 arch/arm/mach-spear13xx/include/mach/io.h          |   19 +
 arch/arm/mach-spear13xx/include/mach/irqs.h        |  128 +++
 arch/arm/mach-spear13xx/include/mach/memory.h      |   19 +
 arch/arm/mach-spear13xx/include/mach/misc_regs.h   |  386 +++++++
 arch/arm/mach-spear13xx/include/mach/smp.h         |   25 +
 arch/arm/mach-spear13xx/include/mach/spear.h       |   95 ++
 arch/arm/mach-spear13xx/include/mach/spear1300.h   |   21 +
 arch/arm/mach-spear13xx/include/mach/spear1310.h   |   64 ++
 arch/arm/mach-spear13xx/include/mach/system.h      |   35 +
 arch/arm/mach-spear13xx/include/mach/timex.h       |   19 +
 arch/arm/mach-spear13xx/include/mach/uncompress.h  |   19 +
 arch/arm/mach-spear13xx/include/mach/vmalloc.h     |   18 +
 arch/arm/mach-spear13xx/localtimer.c               |   25 +
 arch/arm/mach-spear13xx/platsmp.c                  |  162 +++
 arch/arm/mach-spear13xx/spear1300.c                |   38 +
 arch/arm/mach-spear13xx/spear1300_evb.c            |   67 ++
 arch/arm/mach-spear13xx/spear1310.c                |  494 +++++++++
 arch/arm/mach-spear13xx/spear1310_evb.c            |   86 ++
 arch/arm/mach-spear13xx/spear13xx.c                |  697 ++++++++++++
 arch/arm/mm/Kconfig                                |    2 +-
 arch/arm/plat-spear/Kconfig                        |    8 +
 arch/arm/plat-spear/Makefile                       |    1 +
 39 files changed, 4273 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/configs/spear13xx_defconfig
 create mode 100644 arch/arm/mach-spear13xx/Kconfig
 create mode 100644 arch/arm/mach-spear13xx/Makefile
 create mode 100644 arch/arm/mach-spear13xx/Makefile.boot
 create mode 100644 arch/arm/mach-spear13xx/clock.c
 create mode 100644 arch/arm/mach-spear13xx/headsmp.S
 create mode 100644 arch/arm/mach-spear13xx/hotplug.c
 create mode 100644 arch/arm/mach-spear13xx/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-spear13xx/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-spear13xx/include/mach/generic.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/gpio.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/hardware.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/io.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/irqs.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/memory.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/misc_regs.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/smp.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear1300.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear1310.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/system.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/timex.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-spear13xx/localtimer.c
 create mode 100644 arch/arm/mach-spear13xx/platsmp.c
 create mode 100644 arch/arm/mach-spear13xx/spear1300.c
 create mode 100644 arch/arm/mach-spear13xx/spear1300_evb.c
 create mode 100644 arch/arm/mach-spear13xx/spear1310.c
 create mode 100644 arch/arm/mach-spear13xx/spear1310_evb.c
 create mode 100644 arch/arm/mach-spear13xx/spear13xx.c

-- 
1.7.2.2
