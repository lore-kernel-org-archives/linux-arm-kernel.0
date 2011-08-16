From: robherring2@gmail.com (Rob Herring)
Date: Tue, 16 Aug 2011 15:34:52 -0500
Subject: [PATCH 0/6] Initial Calxeda Highbank support
Message-ID: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This adds initial platform support for Calxeda's Highbank ARM SOC. 

If any of the mach header clean-up series go in, then I can drop some 
headers. Several are already empty. This will need some rework if/when
Marc Z's localtimers rework patches are merged:

http://article.gmane.org/gmane.linux.ports.arm.kernel/127831/

Based on 3.1-rc2 plus previously posted L2x0 and GIC devicetree
binding support. The L2x0 support is merged in rmk's for-next branch.
The GIC bindings are still being discussed.

Rob

Martin Bogomolni (1):
  ARM: highbank: Add cpu hotplug support

Rob Herring (5):
  ARM: highbank: add devicetree source
  ARM: add Highbank core platform support
  MAINTAINERS: add Calxeda Highbank ARM platform
  ARM: highbank: add SMP support
  ARM: highbank: add suspend support

 Documentation/devicetree/bindings/arm/calxeda.txt |    8 +
 MAINTAINERS                                       |    6 +
 arch/arm/Kconfig                                  |   19 ++-
 arch/arm/Makefile                                 |    1 +
 arch/arm/boot/dts/highbank.dts                    |  212 +++++++++++++++++++++
 arch/arm/mach-highbank/Makefile                   |    5 +
 arch/arm/mach-highbank/Makefile.boot              |    1 +
 arch/arm/mach-highbank/clock.c                    |   63 ++++++
 arch/arm/mach-highbank/core.h                     |    3 +
 arch/arm/mach-highbank/highbank.c                 |  164 ++++++++++++++++
 arch/arm/mach-highbank/hotplug.c                  |   56 ++++++
 arch/arm/mach-highbank/include/mach/debug-macro.S |   20 ++
 arch/arm/mach-highbank/include/mach/entry-macro.S |    9 +
 arch/arm/mach-highbank/include/mach/gpio.h        |    1 +
 arch/arm/mach-highbank/include/mach/io.h          |    8 +
 arch/arm/mach-highbank/include/mach/irqs.h        |    6 +
 arch/arm/mach-highbank/include/mach/memory.h      |    1 +
 arch/arm/mach-highbank/include/mach/system.h      |   26 +++
 arch/arm/mach-highbank/include/mach/timex.h       |    6 +
 arch/arm/mach-highbank/include/mach/uncompress.h  |    9 +
 arch/arm/mach-highbank/include/mach/vmalloc.h     |    6 +
 arch/arm/mach-highbank/localtimer.c               |   37 ++++
 arch/arm/mach-highbank/platsmp.c                  |   79 ++++++++
 arch/arm/mach-highbank/pm.c                       |   55 ++++++
 arch/arm/mach-highbank/sysregs.h                  |   30 +++
 arch/arm/mach-highbank/system.c                   |   33 ++++
 arch/arm/mm/Kconfig                               |    2 +-
 27 files changed, 864 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/calxeda.txt
 create mode 100644 arch/arm/boot/dts/highbank.dts
 create mode 100644 arch/arm/mach-highbank/Makefile
 create mode 100644 arch/arm/mach-highbank/Makefile.boot
 create mode 100644 arch/arm/mach-highbank/clock.c
 create mode 100644 arch/arm/mach-highbank/core.h
 create mode 100644 arch/arm/mach-highbank/highbank.c
 create mode 100644 arch/arm/mach-highbank/hotplug.c
 create mode 100644 arch/arm/mach-highbank/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-highbank/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-highbank/include/mach/gpio.h
 create mode 100644 arch/arm/mach-highbank/include/mach/io.h
 create mode 100644 arch/arm/mach-highbank/include/mach/irqs.h
 create mode 100644 arch/arm/mach-highbank/include/mach/memory.h
 create mode 100644 arch/arm/mach-highbank/include/mach/system.h
 create mode 100644 arch/arm/mach-highbank/include/mach/timex.h
 create mode 100644 arch/arm/mach-highbank/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-highbank/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-highbank/localtimer.c
 create mode 100644 arch/arm/mach-highbank/platsmp.c
 create mode 100644 arch/arm/mach-highbank/pm.c
 create mode 100644 arch/arm/mach-highbank/sysregs.h
 create mode 100644 arch/arm/mach-highbank/system.c

-- 
1.7.4.1
