From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 May 2014 07:07:41 +0900
Subject: [GIT PULL 4th 1/2 v2] Samsung Exynos multiplatform for 3.16
Message-ID: <53850CAD.6080102@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I sorted out the branch as per Olof's suggestion and sending v2 
pull-request for that (4th pull-request). Also sent multi_v7_defconfig 
update patch to arm at kernel.org.

Please pull this for 3.16.
If any problems, please kindly let me know.

Thanks,
Kukjin

The following changes since commit dfacdfef06090ca0c131f45dfd3f3ca3452a8ed3:

   Merge branch 'v3.16-next/dt-samsung' into v3.16-next/multiplatform 
(2014-05-26 06:19:01 +0900)

are available in the git repository at:


   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/exynos-multiplatform-v2

for you to fetch changes up to f7b163d16d412e14be49f47240ffaba328aaab6c:

   cpufreq: exynos: Fix driver compilation with ARCH_MULTIPLATFORM 
(2014-05-27 23:52:50 +0900)

----------------------------------------------------------------
Exynos mutiplatform support for 3.16

Here is enabling the exynos platform as part of a multiplatform
kernel. This is including ARCH_EXYNOS related Kconfig entries
consolidation. And fixes exynos-cpufreq driver compilation with
ARCH_MULTIPLATFORM.

Note that this is based on tags/exynos-soc. And tags/samsung-dt,
tags/samsung-clk are merged on top of that.

----------------------------------------------------------------
Arnd Bergmann (1):
       ARM: EXYNOS: Enable multi-platform build support

Sachin Kamat (1):
       ARM: EXYNOS: Consolidate Kconfig entries

Tomasz Figa (1):
       cpufreq: exynos: Fix driver compilation with ARCH_MULTIPLATFORM

  arch/arm/Kconfig                     | 20 ---------
  arch/arm/mach-exynos/Kconfig         | 81 
++++++++++++------------------------
  arch/arm/mach-exynos/Makefile        |  2 +
  arch/arm/plat-samsung/Makefile       |  3 ++
  drivers/cpufreq/Kconfig.arm          |  6 +--
  drivers/cpufreq/exynos-cpufreq.c     |  2 -
  drivers/cpufreq/exynos-cpufreq.h     | 30 +++++++------
  drivers/cpufreq/exynos4210-cpufreq.c | 39 ++++++++++++++---
  drivers/cpufreq/exynos4x12-cpufreq.c | 40 +++++++++++++++---
  drivers/cpufreq/exynos5250-cpufreq.c | 43 +++++++++++++++----
  10 files changed, 151 insertions(+), 115 deletions(-)
