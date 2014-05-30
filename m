From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 31 May 2014 04:59:39 +0900
Subject: [GIT PULL 3/5] Samsung Exynos updates for 3.16
Message-ID: <5388E32B.3010908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit fced6dee29f6fb143fe16ea90331176ff77e6120:

   Merge branch 'v3.16-next/cleanup-samsung' into 
v3.16-next/platform-exynos (2014-05-31 02:36:49 +0900)

are available in the git repository at:


   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-exynos

for you to fetch changes up to 9dfa92ec4033c348aae6bafc1881e07229fabaa6:

   ARM: EXYNOS: Enable multi-platform build support (2014-05-31 02:43:51 
+0900)

----------------------------------------------------------------
Samsung Exynos updates for 3.16

- add new SoCs support
   : exynos3250, 5260, 5410 and 5800

- enable multi-platform on exynos
   : consolidate exynos related Kconfig entries

Note that this requires tags/samsung-cleanup and tags/samsung-clk-2
because of mostly migration exynos specific macros into mach-exynos
and exynos related Kconfig entries.

One more merge conflict happens in arch/arm/Kconfig for ARCH_EXYNOS
due to SRAM stuff, even though tried to sort them out. Since just
resolving it would be better I think, please remove ARCH_EXYNOS in
arch/arm/Kconfig when merge conflict happens.

----------------------------------------------------------------
Arnd Bergmann (1):
       ARM: EXYNOS: Enable multi-platform build support

Arun Kumar K (1):
       ARM: EXYNOS: Add 5800 SoC support

Chanwoo Choi (2):
       ARM: EXYNOS: Add Exynos3250 SoC ID
       ARM: EXYNOS: Support secondary CPU boot of Exynos3250

Pankaj Dubey (1):
       ARM: EXYNOS: initial board support for exynos5260 SoC

Sachin Kamat (1):
       ARM: EXYNOS: Consolidate Kconfig entries

Tarek Dakhran (1):
       ARM: EXYNOS: Add support for EXYNOS5410 SoC

  arch/arm/Kconfig                | 19 ---------
  arch/arm/mach-exynos/Kconfig    | 92 
+++++++++++++++++++++++------------------
  arch/arm/mach-exynos/Makefile   |  2 +
  arch/arm/mach-exynos/common.h   | 29 ++++++++++++-
  arch/arm/mach-exynos/exynos.c   |  3 ++
  arch/arm/mach-exynos/firmware.c |  9 +++-
  arch/arm/mach-exynos/platsmp.c  |  2 +-
  arch/arm/plat-samsung/Makefile  |  3 ++
  8 files changed, 96 insertions(+), 63 deletions(-)
