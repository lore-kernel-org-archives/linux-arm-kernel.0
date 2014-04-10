From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 10 Apr 2014 13:54:50 +0530
Subject: [PATCH 0/6] Further cleanup and enable multiplat build
Message-ID: <1397118296-6846-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is based on latest linux-next and depends on the
following patches:
ARM: EXYNOS: Consolidate Kconfig entries
http://article.gmane.org/gmane.linux.kernel.samsung-soc/28642

Currently cpufreq driver build support has been disabled for
multiplatform for Exynos until the generic CPUfreq driver support
for Exynos gets merged. This (disabling) patch is available in PM tree.
http://www.spinics.net/lists/cpufreq/msg09693.html

Tested on Exynos4210, 4412, 5250 and 5420 based boards.

Arnd Bergmann (1):
  ARM: EXYNOS: Enable multi-platform build support

Sachin Kamat (5):
  ARM: EXYNOS: Remove duplicate lines in Makefile
  ARM: EXYNOS: Staticize exynos_subsys
  ARM: EXYNOS: Migrate Exynos specific macros from plat to mach
  ARM: EXYNOS: Remove unnecessary inclusion of cpu.h
  ARM: multi_v7_defconfig: Enable Exynos platform

 arch/arm/Kconfig                         |   27 ++---------
 arch/arm/configs/exynos_defconfig        |    2 +-
 arch/arm/configs/multi_v7_defconfig      |   10 +++++
 arch/arm/mach-exynos/Kconfig             |   27 +++++++++++
 arch/arm/mach-exynos/Makefile            |    9 ++--
 arch/arm/mach-exynos/common.h            |   72 ++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/cpuidle.c           |    1 -
 arch/arm/mach-exynos/exynos.c            |    4 +-
 arch/arm/mach-exynos/hotplug.c           |    2 -
 arch/arm/mach-exynos/platsmp.c           |    2 -
 arch/arm/mach-exynos/pm.c                |    1 -
 arch/arm/mach-exynos/pmu.c               |    2 -
 arch/arm/plat-samsung/Makefile           |    3 ++
 arch/arm/plat-samsung/include/plat/cpu.h |   61 -------------------------
 14 files changed, 120 insertions(+), 103 deletions(-)

-- 
1.7.9.5
