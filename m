From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 20 May 2012 07:39:26 +0900
Subject: [GIT PULL] Samsung devel-2 for v3.5
Message-ID: <4FB8211E.6070905@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Here is second development of Samsung stuff for v3.5:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/devel-samsung-2

It is adding support second irq set for s3c2416, suspend/resume for 
exynos5250 and none of interrupt combiner controller for exynos5250.

Since above patches have dependencies with pm of exynos4412 is in 
next/devel-samsung and regarding dt update is in next/exynos5250-1 
branch, so I made this on top of them.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


The following changes since commit 2de05a57467c43f58802cdeaa547aee73396b6f3:

   Merge branch 'next/devel-exynos5250-1' into next/devel-samsung-2 
(2012-05-20 03:04:59 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/devel-samsung-2

Heiko Stuebner (1):
       ARM: S3C24XX: add support for second irq set of S3C2416

Jongpill Lee (5):
       ARM: EXYNOS: Remove GIC save & restore function
       ARM: EXYNOS: Rename of function for pm.c
       ARM: EXYNOS: Add PMU table for EXYNOS5250
       ARM: EXYNOS: Add Clock register list for save and restore
       ARM: EXYNOS: Support suspend and resume for EXYNOS5250

Thomas Abraham (1):
       ARM: dts: Add node for interrupt combiner controller on EXYNOS5250

  arch/arm/boot/dts/exynos5250.dtsi              |   16 ++
  arch/arm/mach-exynos/Kconfig                   |    2 +
  arch/arm/mach-exynos/Makefile                  |    2 +-
  arch/arm/mach-exynos/clock-exynos5.c           |   51 ++++++-
  arch/arm/mach-exynos/cpuidle.c                 |    2 +-
  arch/arm/mach-exynos/include/mach/pm-core.h    |    2 +-
  arch/arm/mach-exynos/include/mach/pmu.h        |    4 +-
  arch/arm/mach-exynos/include/mach/regs-clock.h |   18 ++-
  arch/arm/mach-exynos/include/mach/regs-pmu.h   |  141 +++++++++++++++-
  arch/arm/mach-exynos/pm.c                      |  223 
++++++++----------------
  arch/arm/mach-exynos/pmu.c                     |  200 
+++++++++++++++++++--
  arch/arm/mach-s3c24xx/include/mach/irqs.h      |   15 ++-
  arch/arm/mach-s3c24xx/irq-s3c2416.c            |   98 +++++++++++
  arch/arm/mach-s3c24xx/s3c2416.c                |    1 +
  arch/arm/plat-samsung/include/plat/s3c2416.h   |    3 +
  15 files changed, 602 insertions(+), 176 deletions(-)
