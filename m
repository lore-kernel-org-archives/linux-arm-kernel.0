From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Feb 2015 20:35:37 +0100
Subject: [PATCH 0/9] ARM: samsung: randconfig build fixes
Message-ID: <1423769746-582629-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a set of mostly trivial build fixes for bugs I have encountered
in random configurations. I'm sending them separate from the other
platforms since we have a lot of them for the various samsung platforms
here.

Kukjin, please pick them up into a fixes branch for 3.20 or send
an Ack so we can apply them directly.

Let me know if anything looks wrong with some of the patches.

Thanks,

	Arnd

Arnd Bergmann (9):
  ARM: s3c64xx: add I2C dependencies where needed
  ARM: s3c64xx: fix building without CONFIG_PM_SLEEP
  ARM: s3c64xx: fix __initdata section mismatch
  ARM: s3c24xx: use SAMSUNG_WAKEMASK for s3c2416
  ARM: s3c24xx: fix building without PM_SLEEP
  ARM: s3c24xx: fix header file inclusions
  ARM: s3c24xx: avoid a Kconfig warning
  ARM: EXYNOS: suspend requires regulator access
  ARM: EXYNOS: make exynos 4210 cpuidle build without SMP

 arch/arm/mach-exynos/Kconfig                 |  1 +
 arch/arm/mach-exynos/pm.c                    | 19 +++++++++++++++----
 arch/arm/mach-s3c24xx/Kconfig                | 19 ++++++++++---------
 arch/arm/mach-s3c24xx/Makefile               |  3 ++-
 arch/arm/mach-s3c24xx/include/mach/pm-core.h | 24 ++++++++++++++++++++++--
 arch/arm/mach-s3c24xx/pm-s3c2416.c           |  3 ++-
 arch/arm/mach-s3c24xx/pm.c                   |  6 ++++--
 arch/arm/mach-s3c24xx/s3c2410.c              |  2 +-
 arch/arm/mach-s3c24xx/s3c2412.c              |  2 +-
 arch/arm/mach-s3c24xx/s3c2416.c              |  2 +-
 arch/arm/mach-s3c24xx/s3c2440.c              |  4 ++--
 arch/arm/mach-s3c24xx/s3c2442.c              |  4 ++--
 arch/arm/mach-s3c24xx/s3c244x.c              |  7 ++-----
 arch/arm/mach-s3c64xx/Kconfig                |  4 +++-
 arch/arm/mach-s3c64xx/Makefile               |  3 ++-
 arch/arm/mach-s3c64xx/mach-smdk6410.c        |  2 +-
 arch/arm/mach-s3c64xx/pm.c                   |  2 ++
 arch/arm/plat-samsung/include/plat/pm.h      | 14 +++++++++++---
 arch/arm/plat-samsung/pm-debug.c             |  1 +
 arch/arm/plat-samsung/pm.c                   | 20 --------------------
 20 files changed, 85 insertions(+), 57 deletions(-)

-- 
2.1.0.rc2
