From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 22 Dec 2013 03:23:21 +0900
Subject: [GIT PULL 2nd 1/5] Samsung non-critical fixes for v3.14
Message-ID: <52B5DC99.6010801@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 236940d2c951a84735fdd7b958b5159eaf501784:

   ARM: dts: Update display clock frequency for Origen-4412 (2013-12-16 
04:41:57 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-fixes-2

for you to fetch changes up to ca7c11fc8df0657ddeffc1cd98428abd739e1e10:

   ARM: dts: Use MSHC controller for eMMC memory for exynos4412-trats2 
(2013-12-21 08:01:31 +0900)

----------------------------------------------------------------
Samsung non-critical 2nd fixes for v3.14
- Correct HSMMC1 card detection type for s3c6410-mini6410
- Fix different key mapping backslash and search key for exynos5250-snow
- Fix definitions of div_mmc_pre4 divider for CLK_SET_RATE_PARENT
- Fix clock provider for mshc on exynos4412
- Fix definitions of mshc dt nodes for exynos4x12
- use mshc controller for eMMC for exynos4412-trats2

----------------------------------------------------------------
Doug Anderson (2):
       ARM: dts: Add the missing "\" key in non-US keyboards for 
exynos5250-snow
       ARM: dts: Fix exynos5250-snow's search key to be L_META

Seungwon Jeon (1):
       ARM: dts: add clock provider for mshc node for Exynos4412 SOC

Tomasz Figa (4):
       ARM: S3C64XX: Correct card detect type for HSMMC1 for MINI6410
       clk: samsung: exynos4: Fix definition of div_mmc_pre4 divider
       ARM: dts: Fix definition of MSHC device tree nodes for exynos4x12
       ARM: dts: Use MSHC controller for eMMC memory for exynos4412-trats2

  arch/arm/boot/dts/exynos4412-odroidx.dts |  5 +----
  arch/arm/boot/dts/exynos4412-origen.dts  |  5 +----
  arch/arm/boot/dts/exynos4412-trats2.dts  | 20 ++++++++++++++++----
  arch/arm/boot/dts/exynos4412.dtsi        |  7 -------
  arch/arm/boot/dts/exynos4x12.dtsi        | 13 +++++++++++++
  arch/arm/boot/dts/exynos5250-snow.dts    |  3 ++-
  arch/arm/mach-s3c64xx/mach-mini6410.c    | 10 ++++++++++
  drivers/clk/samsung/clk-exynos4.c        |  3 ++-
  8 files changed, 45 insertions(+), 21 deletions(-)
