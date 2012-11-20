From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Nov 2012 00:05:31 +0900
Subject: [GIT PULL 6/7] Samsung devel for v3.8
Message-ID: <50AB9C3B.9080203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is for other Samsung devel for v3.8.

This includes supporting legacy i2c controller and ARM down clock 
support for exynos5 and small changes.

Please pull from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/devel-samsung

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 0a9d5ac307aefbb2c772537d3fe7f75046d563ac:

   ARM: EXYNOS: removing exynos-drm device registration from non-dt 
platforms (2012-10-29 21:51:55 +0900)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/devel-samsung

Abhilash Kesavan (4):
       ARM: EXYNOS: Setup legacy i2c controller interrupts
       ARM: EXYNOS: Add aliases for i2c controller
       ARM: EXYNOS: Fix i2c suspend/resume for legacy controller
       ARM: EXYNOS: Add ARM down clock support

Colin Cross (2):
       ARM: SAMSUNG: add clock_tree debugfs file in clock
       ARM: SAMSUNG: call clk_get_rate for debugfs rate files

Jingoo Han (1):
       ARM: EXYNOS: Add dp clock support for EXYNOS5

Kukjin Kim (1):
       Merge branch 'next/hdmi-samsung' into next/devel-samsung

Vasanth Ananthan (1):
       ARM: EXYNOS: Clock settings for SATA and SATA PHY

  arch/arm/boot/dts/exynos5250.dtsi              |   27 ++++++---
  arch/arm/mach-exynos/clock-exynos5.c           |   28 ++++++++-
  arch/arm/mach-exynos/cpuidle.c                 |   36 +++++++++++
  arch/arm/mach-exynos/include/mach/regs-clock.h |   19 ++++++
  arch/arm/mach-exynos/include/mach/regs-pmu.h   |    2 +
  arch/arm/mach-exynos/mach-exynos5-dt.c         |   24 ++++++++
  arch/arm/mach-exynos/pm.c                      |    9 +++
  arch/arm/plat-samsung/clock.c                  |   75 
+++++++++++++++++++++++-
  8 files changed, 206 insertions(+), 14 deletions(-)
