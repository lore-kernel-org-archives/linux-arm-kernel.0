From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 07 Mar 2013 11:23:46 +0900
Subject: [GIT PULL 3/5] Samsung timer for v3.10
Message-ID: <016801ce1ada$cc116d90$643448b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is re-work samsung-time which was s5p-time to support
clocksource/clockevent API for s3c and s5pc100 timer driver. And this enables to
support high resolution timer and tickles mode on them.

Note, this depends on previous pull request (cleanup-s3c) because of touching
while s3c stuff.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


The following changes since commit 7488335dcf382574c47fb27fcbad3f04a9841db6:

  ARM: S3C24XX: cleanup the included soc init functions in common.h (2013-03-05
10:42:48 +0900)
	
are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/timer-samsung

for you to fetch changes up to ad38bdd15d5b97dcb1ffc46ea77c237e30312fbb:

  ARM: SAMSUNG: Remove unused plat-samsung/time.c (2013-03-05 20:19:54 +0900)

----------------------------------------------------------------
Romain Naour (5):
      ARM: SAMSUNG: Rename s5p-time to samsung-time
      ARM: S3C24XX: Add samsung-time support for s3c24xx
      ARM: S3C64XX: Add samsung-time support for s3c64xx
      ARM: S5PC100: Add samsung-time support for s5pc100
      ARM: SAMSUNG: Remove unused plat-samsung/time.c

 arch/arm/Kconfig                                   |   11 +-
 arch/arm/mach-exynos/Kconfig                       |    2 +-
 arch/arm/mach-exynos/mach-universal_c210.c         |    6 +-
 arch/arm/mach-s3c24xx/Kconfig                      |    6 +
 arch/arm/mach-s3c24xx/mach-amlm5900.c              |    5 +-
 arch/arm/mach-s3c24xx/mach-anubis.c                |    4 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c             |    4 +-
 arch/arm/mach-s3c24xx/mach-bast.c                  |    4 +-
 arch/arm/mach-s3c24xx/mach-gta02.c                 |    4 +-
 arch/arm/mach-s3c24xx/mach-h1940.c                 |    5 +-
 arch/arm/mach-s3c24xx/mach-jive.c                  |    4 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c              |    4 +-
 arch/arm/mach-s3c24xx/mach-n30.c                   |    6 +-
 arch/arm/mach-s3c24xx/mach-nexcoder.c              |    4 +-
 arch/arm/mach-s3c24xx/mach-osiris.c                |    4 +-
 arch/arm/mach-s3c24xx/mach-otom.c                  |    4 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c                |    4 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c                |    4 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c                |    4 +-
 arch/arm/mach-s3c24xx/mach-smdk2410.c              |    4 +-
 arch/arm/mach-s3c24xx/mach-smdk2413.c              |    8 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c              |    4 +-
 arch/arm/mach-s3c24xx/mach-smdk2440.c              |    4 +-
 arch/arm/mach-s3c24xx/mach-smdk2443.c              |    4 +-
 arch/arm/mach-s3c24xx/mach-tct_hammer.c            |    4 +-
 arch/arm/mach-s3c24xx/mach-vr1000.c                |    4 +-
 arch/arm/mach-s3c24xx/mach-vstms.c                 |    4 +-
 arch/arm/mach-s3c64xx/Kconfig                      |    2 +
 arch/arm/mach-s3c64xx/mach-anw6410.c               |    4 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    4 +-
 arch/arm/mach-s3c64xx/mach-hmt.c                   |    4 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c              |    4 +-
 arch/arm/mach-s3c64xx/mach-ncp.c                   |    4 +-
 arch/arm/mach-s3c64xx/mach-real6410.c              |    4 +-
 arch/arm/mach-s3c64xx/mach-smartq.c                |    2 +
 arch/arm/mach-s3c64xx/mach-smartq5.c               |    3 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c               |    3 +-
 arch/arm/mach-s3c64xx/mach-smdk6400.c              |    4 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    4 +-
 arch/arm/mach-s5p64x0/Kconfig                      |    4 +-
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |    6 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |    6 +-
 arch/arm/mach-s5pc100/Kconfig                      |    1 +
 arch/arm/mach-s5pc100/mach-smdkc100.c              |    4 +-
 arch/arm/mach-s5pv210/Kconfig                      |    2 +-
 arch/arm/mach-s5pv210/mach-aquila.c                |    6 +-
 arch/arm/mach-s5pv210/mach-goni.c                  |    6 +-
 arch/arm/mach-s5pv210/mach-smdkc110.c              |    6 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    6 +-
 arch/arm/mach-s5pv210/mach-torbreck.c              |    6 +-
 arch/arm/plat-samsung/Kconfig                      |    2 +-
 arch/arm/plat-samsung/Makefile                     |    3 +-
 arch/arm/plat-samsung/include/plat/cpu.h           |    4 -
 arch/arm/plat-samsung/include/plat/s5p-time.h      |   40 ---
 arch/arm/plat-samsung/include/plat/samsung-time.h  |   53 ++++
 .../plat-samsung/{s5p-time.c => samsung-time.c}    |  138 +++++-----
 arch/arm/plat-samsung/time.c                       |  287 --------------------
 57 files changed, 275 insertions(+), 472 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/s5p-time.h
 create mode 100644 arch/arm/plat-samsung/include/plat/samsung-time.h
 rename arch/arm/plat-samsung/{s5p-time.c => samsung-time.c} (68%)
 delete mode 100644 arch/arm/plat-samsung/time.c
