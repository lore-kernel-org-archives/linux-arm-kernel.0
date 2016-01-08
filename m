From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 09 Jan 2016 00:07:11 +0100
Subject: ARM: SoC fixes for 4.4-rc
Message-ID: <4470295.CVKI4nqEPx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

one last minute pull request here, only a few but all highly anticipated fixes
so I hope we can still make it into the final release.

The following changes since commit 80373d37bee562060ce4d3e5272b708e8db5d1fc:

  ARM: tegra: Fix suspend hang on Tegra124 Chromebooks (2015-12-22 15:41:37 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 841bcd2e5014f83ed99e88bd550645d8848ce19a:

  Merge tag 'omap-for-v4.4/onenand-corruption' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2016-01-08 17:46:45 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 4.4-rc

This is the final small set of ARM SoC bug fixes for linux-4.4,
almost all regressions:

OMAP:		data corruption on the Nokia N900 flash
Allwinner:	Two defconfig change to get USB working again
ARM Versatile:	Interrupt numbers gone bad after an older bug fix
Nomadik:	Crashes from incorrect L2 cache settings
VIA vt8500:	SD/MMC support on WM8650 never worked

----------------------------------------------------------------
Arnd Bergmann (1):
      Merge tag 'omap-for-v4.4/onenand-corruption' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Linus Walleij (2):
      ARM: nomadik: set latencies to 8 cycles
      ARM: versatile: fix MMC/SD interrupt assignment

Roman Volkov (1):
      dts: vt8500: Add SDHC node to DTS file for WM8650

Timo Sigurdsson (2):
      ARM: Fix broken USB support in sunxi_defconfig
      ARM: Fix broken USB support in multi_v7_defconfig for sunxi devices

Tony Lindgren (1):
      ARM: OMAP2+: Fix onenand rate detection to avoid filesystem corruption

 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi |  6 +++---
 arch/arm/boot/dts/versatile-ab.dts         | 10 +++++++---
 arch/arm/boot/dts/versatile-pb.dts         | 20 +++++++++++++++++++-
 arch/arm/boot/dts/wm8650.dtsi              |  9 +++++++++
 arch/arm/configs/multi_v7_defconfig        |  1 +
 arch/arm/configs/sunxi_defconfig           |  1 +
 arch/arm/mach-omap2/gpmc-onenand.c         | 14 +++++++++-----
 7 files changed, 49 insertions(+), 12 deletions(-)
