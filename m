From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Aug 2016 21:01:49 +0200
Subject: [GIT PULL] delete the RealView boardfiles
Message-ID: <CACRpkdar=aL6qXrmpmpYJH8NVN4JkN=DfZR3ShmJucNGU4owmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

this deletes the RealView boardfiles, good riddance. All is
device tree now. 3788 deleted lines.

The missing piece was the CLCD patches that got merged
by the fbdev maintainer last week.

I touch oneliners in irqchips and MTD in the process but I
seriously doubt that they mind.

Please pull this in for cleanups so we can get it rotating
in linux-next. (The kautobuild seems happy.)

Yours,
Linus Walleij

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/realview-broomstick-sweep

for you to fetch changes up to 8f2c00629e43b0f32785c3e89b61cca89058929a:

  ARM: realview: imply device tree boot (2016-08-15 20:53:07 +0200)

----------------------------------------------------------------
This deletes the realview boardfiles, consolidates a bit
around the Kconfig options and leaves the mach-realview
directory nice and tidy, with all boards migrated over to
Device Tree.

----------------------------------------------------------------
Linus Walleij (2):
      ARM: realview: delete the RealView board files
      ARM: realview: imply device tree boot

Vladimir Murzin (1):
      ARM: realview: no need to select SMP_ON_UP explicitly

 arch/arm/Kconfig                         |   3 +-
 arch/arm/mach-realview/Kconfig           |  72 +----
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
 27 files changed, 17 insertions(+), 3788 deletions(-)
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
