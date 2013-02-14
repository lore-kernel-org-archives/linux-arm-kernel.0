From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 14:49:16 +0100
Subject: [PATCH 00/11] ARM warning fixes for arm-soc
Message-ID: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a set of bug fixes, most of which I have posted
at least one time before. I will add them to the
next/fixes-non-critical branch now, unless there are
any last-minute objections.

Arnd Bergmann (11):
  ARM: disable virt_to_bus/virt_to_bus almost everywhere
  ARM: samsung: fix assembly syntax for new gas
  ARM: w90x900: fix legacy assembly syntax
  ARM: shmobile: fix defconfig warning on CONFIG_USB
  ARM: sa1100: don't warn about mach/ide.h
  ARM: integrator/versatile: fix NOMMU warnings
  ARM: integrator: fix build with INTEGRATOR_AP off
  ARM: pick Versatile by default for !MMU
  ARM: mvebu: allow selecting mvebu without Armada XP
  ARM: s3c: i2c: add platform_device forward declaration
  scripts/sortextable: silence script output

 arch/arm/Kconfig                                 |  7 ++++++-
 arch/arm/configs/marzen_defconfig                |  1 -
 arch/arm/configs/shark_defconfig                 |  1 -
 arch/arm/include/asm/dma.h                       |  2 +-
 arch/arm/include/asm/memory.h                    |  2 ++
 arch/arm/mach-integrator/common.h                |  5 -----
 arch/arm/mach-integrator/core.c                  |  2 +-
 arch/arm/mach-integrator/integrator_ap.c         |  2 +-
 arch/arm/mach-integrator/integrator_cp.c         |  2 +-
 arch/arm/mach-mvebu/Makefile                     |  5 +++--
 arch/arm/mach-s3c24xx/include/mach/debug-macro.S | 12 ++++++------
 arch/arm/mach-s3c24xx/include/mach/entry-macro.S |  4 ++--
 arch/arm/mach-s3c24xx/pm-h1940.S                 |  2 +-
 arch/arm/mach-s3c24xx/sleep-s3c2410.S            | 12 ++++++------
 arch/arm/mach-s3c24xx/sleep-s3c2412.S            | 12 ++++++------
 arch/arm/mach-sa1100/lart.c                      |  3 ---
 arch/arm/mach-versatile/Kconfig                  |  5 +++++
 arch/arm/mach-versatile/core.c                   |  2 +-
 arch/arm/mach-w90x900/include/mach/entry-macro.S |  4 ++--
 arch/arm/plat-samsung/include/plat/debug-macro.S | 18 +++++++++---------
 include/linux/platform_data/i2c-s3c2410.h        |  2 ++
 scripts/sortextable.h                            |  2 +-
 22 files changed, 56 insertions(+), 51 deletions(-)

-- 
1.8.1.2
