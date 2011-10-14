From: robherring2@gmail.com (Rob Herring)
Date: Thu, 13 Oct 2011 22:02:08 -0500
Subject: [GIT PULL] Calxeda Highbank platform support
Message-ID: <4E97A630.3070603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Please pull initial support for Calxeda highbank platform. This is based
on my GIC DT binding pull request.

As it appears vmalloc.h and memory.h clean-ups won't make it for 3.2,
this includes those headers. I'll post follow-ups to delete them if they
do in fact go in.

Regards,
Rob

The following changes since commit 8322153302d9bb3fdceda9e0df00d3c69d1964bd:

  ARM: gic: add OF based initialization (2011-10-13 20:40:29 -0500)

are available in the git repository at:

  http://sources.calxeda.com/git/kernel/linux.git hb_for_3.2

Martin Bogomolni (1):
      ARM: highbank: Add cpu hotplug support

Rob Herring (6):
      ARM: l2x0: add empty l2x0_of_init
      ARM: highbank: add devicetree source
      ARM: add Highbank core platform support
      MAINTAINERS: add Calxeda Highbank ARM platform
      ARM: highbank: add SMP support
      ARM: highbank: add suspend support

 Documentation/devicetree/bindings/arm/calxeda.txt |    8 +
 MAINTAINERS                                       |    6 +
 arch/arm/Kconfig                                  |   16 ++-
 arch/arm/Kconfig.debug                            |    7 +
 arch/arm/Makefile                                 |    1 +
 arch/arm/boot/dts/highbank.dts                    |  198
+++++++++++++++++++++
 arch/arm/include/asm/hardware/cache-l2x0.h        |    7 +
 arch/arm/mach-highbank/Makefile                   |    6 +
 arch/arm/mach-highbank/Makefile.boot              |    1 +
 arch/arm/mach-highbank/clock.c                    |   62 +++++++
 arch/arm/mach-highbank/core.h                     |    9 +
 arch/arm/mach-highbank/highbank.c                 |  145 +++++++++++++++
 arch/arm/mach-highbank/hotplug.c                  |   56 ++++++
 arch/arm/mach-highbank/include/mach/debug-macro.S |   19 ++
 arch/arm/mach-highbank/include/mach/entry-macro.S |    7 +
 arch/arm/mach-highbank/include/mach/gpio.h        |    1 +
 arch/arm/mach-highbank/include/mach/io.h          |    7 +
 arch/arm/mach-highbank/include/mach/irqs.h        |    6 +
 arch/arm/mach-highbank/include/mach/memory.h      |    1 +
 arch/arm/mach-highbank/include/mach/system.h      |   26 +++
 arch/arm/mach-highbank/include/mach/timex.h       |    6 +
 arch/arm/mach-highbank/include/mach/uncompress.h  |    9 +
 arch/arm/mach-highbank/include/mach/vmalloc.h     |    1 +
 arch/arm/mach-highbank/lluart.c                   |   34 ++++
 arch/arm/mach-highbank/localtimer.c               |   40 ++++
 arch/arm/mach-highbank/platsmp.c                  |   78 ++++++++
 arch/arm/mach-highbank/pm.c                       |   55 ++++++
 arch/arm/mach-highbank/sysregs.h                  |   52 ++++++
 arch/arm/mach-highbank/system.c                   |   33 ++++
 arch/arm/mm/Kconfig                               |    2 +-
 30 files changed, 897 insertions(+), 2 deletions(-)
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
 create mode 100644 arch/arm/mach-highbank/lluart.c
 create mode 100644 arch/arm/mach-highbank/localtimer.c
 create mode 100644 arch/arm/mach-highbank/platsmp.c
 create mode 100644 arch/arm/mach-highbank/pm.c
 create mode 100644 arch/arm/mach-highbank/sysregs.h
 create mode 100644 arch/arm/mach-highbank/system.c
