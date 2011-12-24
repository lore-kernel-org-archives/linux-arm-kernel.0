From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 24 Dec 2011 09:53:33 +0900
Subject: [GIT PULL] Samsung cleanup-mmc for v3.3
Message-ID: <087e01ccc1d6$76499e40$62dcdac0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the samsung-cleanup-mmc for v3.3
It depends on next-samsung-devel-dt1 branch which has been requested pull
before this.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 0561ceabd0f13871900d116278fe9268aeb714d1:

  ARM: dts: Add intial dts file for EXYNOS4210 SoC, SMDKV310 and ORIGEN
(2011-12-23 10:07:12 +0900)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next-samsung-cleanup-mmc2

Rajeshwari Shinde (3):
      ARM: SAMSUNG: Remove SDHCI bus clocks from platform data
      ARM: SAMSUNG: Add lookup of sdhci-s3c clocks using generic names
      mmc: sdhci-s3c: Use generic clock names for sdhci bus clock options

 arch/arm/mach-exynos/Makefile              |    1 -
 arch/arm/mach-exynos/clock.c               |   88 +++++++++------
 arch/arm/mach-exynos/setup-sdhci.c         |   22 ----
 arch/arm/mach-s3c2416/Makefile             |    1 -
 arch/arm/mach-s3c2416/clock.c              |   68 ++++++-----
 arch/arm/mach-s3c2416/setup-sdhci.c        |   24 ----
 arch/arm/mach-s3c64xx/Makefile             |    1 -
 arch/arm/mach-s3c64xx/clock.c              |  126 +++++++++++++--------
 arch/arm/mach-s3c64xx/setup-sdhci.c        |   24 ----
 arch/arm/mach-s5pc100/Makefile             |    1 -
 arch/arm/mach-s5pc100/clock.c              |  130 +++++++++++++---------
 arch/arm/mach-s5pc100/setup-sdhci.c        |   23 ----
 arch/arm/mach-s5pv210/Makefile             |    1 -
 arch/arm/mach-s5pv210/clock.c              |  167
+++++++++++++++++-----------
 arch/arm/mach-s5pv210/setup-sdhci.c        |   22 ----
 arch/arm/plat-s3c24xx/s3c2443-clock.c      |   16 ++-
 arch/arm/plat-samsung/include/plat/sdhci.h |   31 -----
 drivers/mmc/host/sdhci-s3c.c               |    7 +-
 18 files changed, 361 insertions(+), 392 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s3c2416/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s3c64xx/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s5pc100/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s5pv210/setup-sdhci.c
