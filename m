From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 13 Jul 2014 07:23:05 +0900
Subject: [GIT PULL] Samsung fixes-3 for 3.16
Message-ID: <53C1B549.1060706@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit cd3de83f147601356395b57a8673e9c5ff1e59d1:

   Linux 3.16-rc4 (2014-07-06 12:37:51 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-fixes-3

for you to fetch changes up to bed7118988ef48063c72f67cc2701c72663b3870:

   ARM: EXYNOS: Register cpuidle device only on exynos4210 and 5250 
(2014-07-11 08:15:32 +0900)

----------------------------------------------------------------
Samsung fixes-3 for v3.16
- update the parent for Auudss clock because kernel will be hang
   during late boot if the parent clock is disabled in bootloader.
- enable clk handing in power domain because while power domain
   on/off, its regarding clock source will be reset and it causes
   a problem so need to handle it.
- add mux clocks to be used by power domain for exynos5420-mfc
   during power domain on/off and property in device tree also.
- register cpuidle only for exynos4210 and exynos5250 because a
   system failure will be happened on other exynos SoCs.

----------------------------------------------------------------
Arun Kumar K (2):
       clk: exynos5420: Add IDs for clocks used in PD mfc
       ARM: dts: Add clock property for mfc_pd in exynos5420

Prathyush K (1):
       ARM: EXYNOS: Add support for clock handling in power domain

Tomasz Figa (1):
       ARM: EXYNOS: Register cpuidle device only on exynos4210 and 5250

Tushar Behera (1):
       ARM: dts: Update the parent for Audss clocks in Exynos5420

  .../bindings/arm/exynos/power_domain.txt           | 20 +++++++
  arch/arm/boot/dts/exynos5420.dtsi                  |  5 +-
  arch/arm/mach-exynos/exynos.c                      |  6 +--
  arch/arm/mach-exynos/pm_domains.c                  | 61 
+++++++++++++++++++++-
  drivers/clk/samsung/clk-exynos5420.c               |  6 ++-
  include/dt-bindings/clock/exynos5420.h             |  2 +
  6 files changed, 92 insertions(+), 8 deletions(-)
