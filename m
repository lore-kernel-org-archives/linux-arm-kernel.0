From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 22 Jun 2014 17:22:16 +0900
Subject: [GIT PULL] Samsung fixes-1 for 3.16
Message-ID: <53A69238.5070709@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-fixes-1

for you to fetch changes up to 7cbcb9d46f9194eb1f88c253a08c0292b2883acc:

   ARM: EXYNOS: Don't rely on firmware's secondary_cpu_start for mcpm 
(2014-06-21 19:30:53 +0900)

----------------------------------------------------------------
Samsung fixes for 3.16

- use WFI macro in platform_do_lowpower because exynos cpuhotplug
   includes a hardcoded WFI instruction and it causes compile error
   in Thumb-2 mode.
- fix GIC reg sizes for exynos4 SoCs
- remove reset timer counter value during boot and resume for mct
   to fix a big jump in printk timestamps
- fix pm code to check cortex-A9 for another exynos SoCs
- don't rely on firmware's secondary_cpu_start for mcpm

----------------------------------------------------------------
Abhilash Kesavan (1):
       ARM: EXYNOS: fix pm code to check for cortex A9 rather than the SoC

Chirantan Ekbote (1):
       clocksource: exynos_mct: Don't reset the counter during boot and 
resume

Doug Anderson (1):
       ARM: EXYNOS: Don't rely on firmware's secondary_cpu_start for mcpm

Leela Krishna Amudala (1):
       ARM: EXYNOS: Use wfi macro in platform_do_lowpower

Tomasz Figa (1):
       ARM: dts: fix reg sizes of GIC for exynos4

  arch/arm/boot/dts/exynos4.dtsi     |  2 +-
  arch/arm/mach-exynos/hotplug.c     |  8 +-------
  arch/arm/mach-exynos/mcpm-exynos.c | 11 ++++++-----
  arch/arm/mach-exynos/pm.c          | 15 +++++++++------
  drivers/clocksource/exynos_mct.c   |  9 +++------
  5 files changed, 20 insertions(+), 25 deletions(-)
