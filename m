From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 02 Apr 2015 03:15:54 +0900
Subject: [GIT PULL 1/5] Samsung non-critical-fixes for v4.1
Message-ID: <551C35DA.6070003@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-fixes-v4.1

for you to fetch changes up to a11176e65b8727158bc355ca0cb00bf70cd69e48:

  ARM: S3C24XX: avoid a Kconfig warning (2015-02-27 05:50:25 +0900)

----------------------------------------------------------------
Samsung non-critical fixes for v4.1

- mostly trivial build fixes with random configurations
  from Arnd Bergmann

  for s3c24xx:
  avoid a Kconfig warning and fix header file inclusions,
  and fix building without PM_SLEEP and use SAMSUNG_WAKEMASK

  for s3c64xx:
  fix __initdata section mismatch and add I2C dependencies,
  and fix building with PM_SLEEP

----------------------------------------------------------------
Arnd Bergmann (7):
      ARM: S3C64XX: add I2C dependencies where needed
      ARM: S3C64XX: fix building without CONFIG_PM_SLEEP
      ARM: S3C64XX: fix __initdata section mismatch
      ARM: S3C24XX: use SAMSUNG_WAKEMASK for s3c2416
      ARM: S3C24XX: fix building without PM_SLEEP
      ARM: S3C24XX: fix header file inclusions
      ARM: S3C24XX: avoid a Kconfig warning

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
 18 files changed, 69 insertions(+), 53 deletions(-)
