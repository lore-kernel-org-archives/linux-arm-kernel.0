From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 26 Nov 2010 14:48:59 +0800
Subject: [PATCH 00/15] ARM: mxs: Add initial support for MX23 and MX28
Message-ID: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is the successor of the following one.

[PATCH 00/11] ARM: imx: Add initial i.MX28 support
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-November/031464.html

It puts everything about MX23 and MX28 into mach-mxs to address
the concern from Uwe and Sascha.

It's being developed against Sascha's imx-for-2.6.38 tree,
and supports single image for MX23 and MX28, since they share
the same PHYS_OFFSET.

Shawn Guo (15):
 arch/arm/Kconfig                                |   10 +
 arch/arm/Makefile                               |    1 +
 arch/arm/mach-mxs/Kconfig                       |   34 +
 arch/arm/mach-mxs/Makefile                      |   14 +
 arch/arm/mach-mxs/Makefile.boot                 |    3 +
 arch/arm/mach-mxs/clock-mx23.c                  |  521 ++++++++++++++++
 arch/arm/mach-mxs/clock-mx28.c                  |  732 +++++++++++++++++++++++
 arch/arm/mach-mxs/clock.c                       |  201 +++++++
 arch/arm/mach-mxs/cpu.c                         |   11 +
 arch/arm/mach-mxs/devices-mx23.h                |   16 +
 arch/arm/mach-mxs/devices-mx28.h                |   22 +
 arch/arm/mach-mxs/devices.c                     |   75 +++
 arch/arm/mach-mxs/devices/Kconfig               |    5 +
 arch/arm/mach-mxs/devices/Makefile              |    2 +
 arch/arm/mach-mxs/devices/platform-duart.c      |   47 ++
 arch/arm/mach-mxs/devices/platform-fec.c        |   51 ++
 arch/arm/mach-mxs/gpio.c                        |  364 +++++++++++
 arch/arm/mach-mxs/icoll.c                       |   77 +++
 arch/arm/mach-mxs/include/mach/clkdev.h         |    7 +
 arch/arm/mach-mxs/include/mach/clock.h          |   64 ++
 arch/arm/mach-mxs/include/mach/common.h         |   33 +
 arch/arm/mach-mxs/include/mach/debug-macro.S    |   51 ++
 arch/arm/mach-mxs/include/mach/devices-common.h |   46 ++
 arch/arm/mach-mxs/include/mach/entry-macro.S    |   36 ++
 arch/arm/mach-mxs/include/mach/gpio.h           |   49 ++
 arch/arm/mach-mxs/include/mach/hardware.h       |   66 ++
 arch/arm/mach-mxs/include/mach/io.h             |   22 +
 arch/arm/mach-mxs/include/mach/iomux-mx23.h     |   29 +
 arch/arm/mach-mxs/include/mach/iomux-mx28.h     |   44 ++
 arch/arm/mach-mxs/include/mach/iomux.h          |   77 +++
 arch/arm/mach-mxs/include/mach/irqs.h           |   32 +
 arch/arm/mach-mxs/include/mach/memory.h         |   24 +
 arch/arm/mach-mxs/include/mach/mx23.h           |  147 +++++
 arch/arm/mach-mxs/include/mach/mx28.h           |  227 +++++++
 arch/arm/mach-mxs/include/mach/mxs.h            |   60 ++
 arch/arm/mach-mxs/include/mach/system.h         |   27 +
 arch/arm/mach-mxs/include/mach/timex.h          |   21 +
 arch/arm/mach-mxs/include/mach/uncompress.h     |   82 +++
 arch/arm/mach-mxs/include/mach/vmalloc.h        |   22 +
 arch/arm/mach-mxs/iomux.c                       |  110 ++++
 arch/arm/mach-mxs/mach-mx23evk.c                |   59 ++
 arch/arm/mach-mxs/mach-mx28evk.c                |  108 ++++
 arch/arm/mach-mxs/mm-mx23.c                     |   48 ++
 arch/arm/mach-mxs/mm-mx28.c                     |   48 ++
 arch/arm/mach-mxs/regs-clkctrl-mx23.h           |  455 ++++++++++++++
 arch/arm/mach-mxs/regs-clkctrl-mx28.h           |  663 ++++++++++++++++++++
 arch/arm/mach-mxs/system.c                      |  152 +++++
 arch/arm/mach-mxs/timer.c                       |  285 +++++++++
 48 files changed, 5280 insertions(+), 0 deletions(-)
