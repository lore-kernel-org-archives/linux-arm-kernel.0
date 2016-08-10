From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Aug 2016 14:40:25 +0200
Subject: [PATCH 0/5] RealView boardfile removal
Message-ID: <1470832830-10274-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a repost of the earlier posted RealView boardfile
removal patchset: now that Tomi has merged the CLCD patches
this can be merged, ridding the world from another ton of
boardfiles, with all RealView variants booting just as nicely
as before.

Vladimir's patch and some new patches on top are added to
reduce the Kconfig mess, looking for ACKs from MTD and
irqchips to merge that. Will send a pull request after some
ACK grace time.

Linus Walleij (4):
  ARM: realview: delete the RealView board files
  ARM: realview: reduce the RealView Kconfig
  ARM: realview: cut board options from defconfig
  ARM: realview: imply device tree boot

Vladimir Murzin (1):
  ARM: realview: no need to select SMP_ON_UP explicitly

 arch/arm/configs/realview_defconfig      |  11 -
 arch/arm/mach-realview/Kconfig           | 145 +--------
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
 drivers/irqchip/Makefile                 |   2 +-
 drivers/mtd/maps/Kconfig                 |   2 +-
 27 files changed, 18 insertions(+), 3868 deletions(-)
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
2.7.4
