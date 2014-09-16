From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 17 Sep 2014 07:41:11 +0900
Subject: [GIT PULL 1/2] Samsung cleanup for 3.18
Message-ID: <5418BC87.8000306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-cleanup

for you to fetch changes up to f6361c6b3880063c2248d4e453331e3dc1efbf83:

   ARM: S3C24XX: remove separate restart code (2014-09-14 02:43:09 +0900)

----------------------------------------------------------------
Samsung cleanup for 3.18
- remove unused <mach/memory.h> in exynos
- local <mach/regs-clock.h> for s5pv210
- cleanup boot address calculate for exynos
- remove separate restart code for s3c24xx

----------------------------------------------------------------
Heiko Stuebner (1):
       ARM: S3C24XX: remove separate restart code

Krzysztof Kozlowski (1):
       ARM: EXYNOS: Do not calculate boot address twice

Kukjin Kim (1):
       ARM: S5PV210: move <mach/regs-clock.h> into mach-s5pv210/

Uwe Kleine-Koenig (1):
       ARM: EXYNOS: remove unused <mach/memory.h>

  arch/arm/mach-exynos/include/mach/memory.h         | 26 
----------------------
  arch/arm/mach-exynos/platsmp.c                     |  4 ++--
  arch/arm/mach-s3c24xx/Kconfig                      |  2 --
  arch/arm/mach-s3c24xx/common.c                     |  4 ----
  arch/arm/mach-s3c24xx/common.h                     |  5 -----
  .../mach-s3c24xx/include/mach/regs-s3c2443-clock.h |  2 --
  arch/arm/mach-s3c24xx/mach-amlm5900.c              |  1 -
  arch/arm/mach-s3c24xx/mach-anubis.c                |  1 -
  arch/arm/mach-s3c24xx/mach-at2440evb.c             |  1 -
  arch/arm/mach-s3c24xx/mach-bast.c                  |  1 -
  arch/arm/mach-s3c24xx/mach-gta02.c                 |  1 -
  arch/arm/mach-s3c24xx/mach-h1940.c                 |  1 -
  arch/arm/mach-s3c24xx/mach-jive.c                  |  1 -
  arch/arm/mach-s3c24xx/mach-mini2440.c              |  1 -
  arch/arm/mach-s3c24xx/mach-n30.c                   |  2 --
  arch/arm/mach-s3c24xx/mach-nexcoder.c              |  1 -
  arch/arm/mach-s3c24xx/mach-osiris.c                |  1 -
  arch/arm/mach-s3c24xx/mach-otom.c                  |  1 -
  arch/arm/mach-s3c24xx/mach-qt2410.c                |  1 -
  arch/arm/mach-s3c24xx/mach-rx1950.c                |  1 -
  arch/arm/mach-s3c24xx/mach-rx3715.c                |  1 -
  arch/arm/mach-s3c24xx/mach-s3c2416-dt.c            |  1 -
  arch/arm/mach-s3c24xx/mach-smdk2410.c              |  1 -
  arch/arm/mach-s3c24xx/mach-smdk2413.c              |  3 ---
  arch/arm/mach-s3c24xx/mach-smdk2416.c              |  1 -
  arch/arm/mach-s3c24xx/mach-smdk2440.c              |  1 -
  arch/arm/mach-s3c24xx/mach-smdk2443.c              |  1 -
  arch/arm/mach-s3c24xx/mach-tct_hammer.c            |  1 -
  arch/arm/mach-s3c24xx/mach-vr1000.c                |  1 -
  arch/arm/mach-s3c24xx/mach-vstms.c                 |  1 -
  arch/arm/mach-s3c24xx/s3c2410.c                    | 13 -----------
  arch/arm/mach-s3c24xx/s3c2412.c                    | 23 
-------------------
  arch/arm/mach-s3c24xx/s3c2416.c                    |  8 -------
  arch/arm/mach-s3c24xx/s3c2443.c                    |  8 -------
  arch/arm/mach-s3c24xx/s3c244x.c                    | 12 ----------
  arch/arm/mach-s5pv210/pm.c                         |  3 +--
  .../mach-s5pv210/{include/mach => }/regs-clock.h   |  3 +--
  arch/arm/mach-s5pv210/s5pv210.c                    |  2 +-
  38 files changed, 5 insertions(+), 137 deletions(-)
  delete mode 100644 arch/arm/mach-exynos/include/mach/memory.h
  rename arch/arm/mach-s5pv210/{include/mach => }/regs-clock.h (99%)
