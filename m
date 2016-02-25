From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Feb 2016 14:15:07 +0100
Subject: [PATCH 0/4] RealView boardfile endgame
Message-ID: <1456406111-18579-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set deletes the RealView board files and moves it
over to a pure Device Tree boot, deleting ~3500 LoC.

Prerequisites:
- The MTD driver patch handling the flash memory write
  protection and VPP enable must go into the MTD subsystem.
  http://marc.info/?l=linux-arm-kernel&m=145380689210787&w=2

- The CLCD device tree support patches (uncontroversial set)
  must go into the FBDEV subsystem.
  http://marc.info/?l=linux-fbdev&m=145622172219039&w=2

- I must queue the device tree patches for the Evaluation
  Boards and Platform Baseboard and Platform Baseboard
  Explore before these patches.

However this is how it will look once the above is in place,
and it will support everything the kernel already supports
today.

Tested on the real hardware for PB1176JZF-S and PB11MPCore.
Tested on QEMU for 1136, 1176, 11MPCore and Cortex-A9 EB,
Platform Baseboard for Cortex-A8 and Platform Baseboard Explore
for Cortex-A9 variants.

Linus Walleij (4):
  ARM: realview: delete the RealView board files
  ARM: realview: reduce the RealView Kconfig
  ARM: realview: imply Device Tree config
  ARM: realview: cut board options from defconfig

 arch/arm/configs/realview_defconfig      |  11 -
 arch/arm/mach-realview/Kconfig           | 144 +--------
 arch/arm/mach-realview/Makefile          |  12 +-
 arch/arm/mach-realview/board-eb.h        |  94 ------
 arch/arm/mach-realview/board-pb1176.h    |  81 -----
 arch/arm/mach-realview/board-pb11mp.h    |  96 ------
 arch/arm/mach-realview/board-pba8.h      |  71 -----
 arch/arm/mach-realview/board-pbx.h       | 106 -------
 arch/arm/mach-realview/core.c            | 404 -------------------------
 arch/arm/mach-realview/core.h            |  58 ----
 arch/arm/mach-realview/hardware.h        |  40 ---
 arch/arm/mach-realview/hotplug.h         |   1 +
 arch/arm/mach-realview/irqs-eb.h         | 114 -------
 arch/arm/mach-realview/irqs-pb1176.h     |  77 -----
 arch/arm/mach-realview/irqs-pb11mp.h     |  97 ------
 arch/arm/mach-realview/irqs-pba8.h       |  71 -----
 arch/arm/mach-realview/irqs-pbx.h        |  87 ------
 arch/arm/mach-realview/platform.h        | 247 ----------------
 arch/arm/mach-realview/platsmp-dt.c      |   3 +-
 arch/arm/mach-realview/platsmp.c         |  86 ------
 arch/arm/mach-realview/realview_eb.c     | 492 -------------------------------
 arch/arm/mach-realview/realview_pb1176.c | 395 -------------------------
 arch/arm/mach-realview/realview_pb11mp.c | 385 ------------------------
 arch/arm/mach-realview/realview_pba8.c   | 307 -------------------
 arch/arm/mach-realview/realview_pbx.c    | 402 -------------------------
 25 files changed, 16 insertions(+), 3865 deletions(-)
 delete mode 100644 arch/arm/mach-realview/board-eb.h
 delete mode 100644 arch/arm/mach-realview/board-pb1176.h
 delete mode 100644 arch/arm/mach-realview/board-pb11mp.h
 delete mode 100644 arch/arm/mach-realview/board-pba8.h
 delete mode 100644 arch/arm/mach-realview/board-pbx.h
 delete mode 100644 arch/arm/mach-realview/core.c
 delete mode 100644 arch/arm/mach-realview/core.h
 delete mode 100644 arch/arm/mach-realview/hardware.h
 create mode 100644 arch/arm/mach-realview/hotplug.h
 delete mode 100644 arch/arm/mach-realview/irqs-eb.h
 delete mode 100644 arch/arm/mach-realview/irqs-pb1176.h
 delete mode 100644 arch/arm/mach-realview/irqs-pb11mp.h
 delete mode 100644 arch/arm/mach-realview/irqs-pba8.h
 delete mode 100644 arch/arm/mach-realview/irqs-pbx.h
 delete mode 100644 arch/arm/mach-realview/platform.h
 delete mode 100644 arch/arm/mach-realview/platsmp.c
 delete mode 100644 arch/arm/mach-realview/realview_eb.c
 delete mode 100644 arch/arm/mach-realview/realview_pb1176.c
 delete mode 100644 arch/arm/mach-realview/realview_pb11mp.c
 delete mode 100644 arch/arm/mach-realview/realview_pba8.c
 delete mode 100644 arch/arm/mach-realview/realview_pbx.c

-- 
2.4.3
