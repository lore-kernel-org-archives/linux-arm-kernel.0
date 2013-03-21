From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Mar 2013 22:51:05 +0100
Subject: [PATCH 0/9] More ux500 multiplatform stuff
In-Reply-To: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1363902674-6456-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Your patches from this morning made me curious about how much is still
missing to actually enable multiplatform support on ux500. This is
what I came up with, on top of your patches. Feel free to take what
you need if you don't already have the same patches.

I've successfully built "allmodconfig" with all the other v6/v7
platforms enabled as well.

	Arnd

Arnd Bergmann (9):
  ARM: ux500: move mach/msp.h to include/linux/platform_data.h
  ARM: ux500: split out prcmu initialization
  ARM: ux500: make irqs.h local to platform
  ARM: ux500: kill mach/hardware.h some more
  staging: ste_rmi4: kill platform_data hack
  power: pm2301_charger: remove __devinit annotations
  ARM: ux500: make remaining headers local
  ARM: ux500: move to multiplatform
  ARM: ux500: build hotplug.o for ARMv7-a

 arch/arm/Kconfig                                   |  16 ---
 arch/arm/mach-ux500/Kconfig                        |  14 +++
 arch/arm/mach-ux500/Makefile                       |   2 +
 arch/arm/mach-ux500/board-mop500-audio.c           |   6 +-
 arch/arm/mach-ux500/board-mop500-sdi.c             |   2 +-
 arch/arm/mach-ux500/board-mop500-u8500uib.c        |   9 +-
 arch/arm/mach-ux500/board-mop500.c                 |  64 +---------
 arch/arm/mach-ux500/board-mop500.h                 |   4 +-
 arch/arm/mach-ux500/cpu-db8500.c                   |   6 +-
 arch/arm/mach-ux500/cpu.c                          |   4 +-
 arch/arm/mach-ux500/devices-common.c               |   2 +-
 arch/arm/mach-ux500/devices-db8500.c               |   6 +-
 arch/arm/mach-ux500/devices-db8500.h               |   2 +-
 arch/arm/mach-ux500/devices.c                      |   2 +-
 arch/arm/mach-ux500/{include/mach => }/devices.h   |   0
 arch/arm/mach-ux500/hotplug.c                      |   2 +-
 arch/arm/mach-ux500/id.c                           |   2 +-
 arch/arm/mach-ux500/include/mach/timex.h           |   6 -
 arch/arm/mach-ux500/include/mach/uncompress.h      |  58 ---------
 .../{include/mach => }/irqs-board-mop500.h         |   0
 .../mach-ux500/{include/mach => }/irqs-db8500.h    |  25 ----
 arch/arm/mach-ux500/{include/mach => }/irqs.h      |   4 +-
 arch/arm/mach-ux500/platsmp.c                      |   2 +-
 arch/arm/mach-ux500/{include/mach => }/setup.h     |   0
 arch/arm/mach-ux500/timer.c                        |   4 +-
 drivers/clocksource/clksrc-dbx500-prcmu.c          |   2 -
 drivers/crypto/ux500/cryp/cryp.c                   |   2 -
 drivers/crypto/ux500/cryp/cryp_core.c              |   1 -
 drivers/crypto/ux500/hash/hash_core.c              |   1 -
 drivers/mfd/db8500-prcmu.c                         | 140 ++++++++++++++++-----
 drivers/power/pm2301_charger.c                     |   6 +-
 drivers/staging/ste_rmi4/Makefile                  |   1 -
 .../staging/ste_rmi4/board-mop500-u8500uib-rmi4.c  |  31 -----
 drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c      |  31 +++--
 drivers/staging/ste_rmi4/synaptics_i2c_rmi4.h      |   1 -
 include/linux/mfd/dbx500-prcmu.h                   |   2 +
 .../linux/platform_data/asoc-ux500-msp.h           |   0
 sound/soc/ux500/mop500_ab8500.c                    |   2 -
 sound/soc/ux500/ux500_msp_dai.c                    |   3 +-
 sound/soc/ux500/ux500_msp_i2s.c                    |   3 +-
 sound/soc/ux500/ux500_msp_i2s.h                    |   2 +-
 41 files changed, 187 insertions(+), 283 deletions(-)
 rename arch/arm/mach-ux500/{include/mach => }/devices.h (100%)
 delete mode 100644 arch/arm/mach-ux500/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/uncompress.h
 rename arch/arm/mach-ux500/{include/mach => }/irqs-board-mop500.h (100%)
 rename arch/arm/mach-ux500/{include/mach => }/irqs-db8500.h (83%)
 rename arch/arm/mach-ux500/{include/mach => }/irqs.h (95%)
 rename arch/arm/mach-ux500/{include/mach => }/setup.h (100%)
 delete mode 100644 drivers/staging/ste_rmi4/board-mop500-u8500uib-rmi4.c
 rename arch/arm/mach-ux500/include/mach/msp.h => include/linux/platform_data/asoc-ux500-msp.h (100%)

-- 
1.8.1.2
