From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 May 2015 23:13:41 +0200
Subject: ARM: SoC fixes for 4.1-rc5
Message-ID: <8909968.IG30INqnXc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e26081808edadfd257c6c9d81014e3b25e9a6118:

  Linux 4.1-rc4 (2015-05-18 10:13:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 5530c84f62b49a2e9f8c11a079d00f85ea20bb09:

  ARM: multi_v7_defconfig: Replace CONFIG_USB_ISP1760_HCD by CONFIG_USB_ISP1760 (2015-05-29 14:31:35 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 4.1-rc5

Two weeks worth of small bug fixes this time, nothing sticking out
this time:

- one defconfig change to adapt to a modified Kconfig symbol
- two fixes for i.MX for backwards compatibility with older DT
  files that was accidentally broken
- one regression fix for irq handling on pxa
- three small dt files on omap, and one each for imx and exynos

----------------------------------------------------------------
Anthoine Bourgeois (1):
      ARM: dts: omap3-devkit8000: Fix NAND DT node

Arnd Bergmann (4):
      Merge tag 'imx-fixes-4.1-2' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'omap-for-v4.1/fixes-rc4' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'samsung-fixes-3' of git://git.kernel.org/.../kgene/linux-samsung into fixes
      Merge tag 'imx-fixes-4.1-3' of git://git.kernel.org/.../shawnguo/linux into fixes

Geert Uytterhoeven (1):
      ARM: multi_v7_defconfig: Replace CONFIG_USB_ISP1760_HCD by CONFIG_USB_ISP1760

Inki Dae (1):
      ARM: dts: set display clock correctly for exynos4412-trats2

Lucas Stach (2):
      ARM: imx6: allow booting with old DT
      ARM: imx6: gpc: don't register power domain if DT data is missing

Philippe Reynes (1):
      ARM: dts: imx27: only map 4 Kbyte for fec registers

Robert Jarzmik (1):
      ARM: pxa: pxa_cplds: signedness bug in probe

Robert Nelson (1):
      ARM: dts: am335x-boneblack: disable RTC-only sleep

Romain Izard (1):
      ARM: dts: Fix WLAN interrupt line for AM335x EVM-SK

Shawn Guo (1):
      ARM: dts: fix imx27 dtb build rule

 arch/arm/boot/dts/Makefile              |  2 +-
 arch/arm/boot/dts/am335x-boneblack.dts  |  4 ----
 arch/arm/boot/dts/am335x-evmsk.dts      |  2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts |  2 +-
 arch/arm/boot/dts/imx27.dtsi            |  2 +-
 arch/arm/boot/dts/omap3-devkit8000.dts  |  2 ++
 arch/arm/configs/multi_v7_defconfig     |  2 +-
 arch/arm/mach-imx/gpc.c                 | 16 +++++++++++++---
 arch/arm/mach-pxa/pxa_cplds_irqs.c      |  2 +-
 9 files changed, 21 insertions(+), 13 deletions(-)
