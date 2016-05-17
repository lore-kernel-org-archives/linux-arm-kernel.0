From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 00:20:26 +0200
Subject: [GIT PULL 1/7] ARM: SoC cleanups and fixes for v4.7
In-Reply-To: <8749147.ztcb6kVhye@wuerfel>
References: <8749147.ztcb6kVhye@wuerfel>
Message-ID: <3000366.nhqNxgKrjJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-cleanups-fixes

for you to fetch changes up to 2e629ebc24d463ffb6c17b15daf908e6f968a1de:

  Merge branches 'next/cleanup' and 'next/fixes-non-critical' into next/cleanups-fixes (2016-05-17 15:06:31 +0200)

----------------------------------------------------------------
ARM: SoC cleanups and fixes for v4.7

Traditionally we've had two separate branches for cleanups and non-critical
bug fixes, but both of these got smaller with each release and the differences
are rather unclear now, so it seems more appropriate to have a combined
branch.

The most notably change is for OMAP, which gets a small rework to simplify
handling of the AUXDATA mechanism used on machines that are not completely
DT based yet, along with other work that is used as preparation for dropping
the legacy board files.

----------------------------------------------------------------
Arnd Bergmann (7):
      ARM: realview: hide unused 'pmu_device' object
      Merge tag 'davinci-for-v4.7/cleanup' of git://git.kernel.org/.../nsekhar/linux-davinci into next/cleanup
      ARM: debug: remove extraneous DEBUG_HI3716_UART option
      Merge tag 'samsung-fixes-non-critical-4.7' of git://git.kernel.org/.../krzk/linux into next/fixes-non-critical
      Merge tag 'omap-for-v4.7/legacy-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/fixes-non-critical
      Merge tag 'omap-for-v4.7/auxdata-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/fixes-non-critical
      Merge branches 'next/cleanup' and 'next/fixes-non-critical' into next/cleanups-fixes

David Lechner (3):
      ARM: davinci: simplify call to of populate
      ARM: davinci: remove unused DA8XX_NUM_UARTS
      ARM: davinci: use IRQCHIP_DECLARE for cp_intc

Javier Martinez Canillas (1):
      ARM: dts: exynos: Add MFC memory banks for Peach boards

Krzysztof Kozlowski (1):
      ARM: EXYNOS: Properly skip unitialized parent clock in power domain on

Linus Walleij (1):
      soc: versatile: dynamically detect RealView HBI numbers

Marek Szyprowski (2):
      ARM: dts: exynos: Fix regulator name to avoid forbidden character on exynos4210-trats
      ARM: dts: exynos: Add interrupt line to MAX8997 PMIC on exynos4210-trats

Olof Johansson (2):
      Merge tag 'versatile-cleanup-1' of git://git.kernel.org/.../linusw/linux-integrator into next/cleanup
      Merge tag 'v4.7-rockchip-soc32-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/cleanup

Peter Griffin (1):
      ARM: rockchip: Fix use of plain integer as NULL pointer

Petr Kulhavy (1):
      ARM: DaVinci USB: removed deprecated properties from MUSB config

Tony Lindgren (4):
      of/platform: Allow secondary compatible match in of_dev_lookup
      ARM: OMAP2+: Simplify auxdata by using the generic match
      ARM: OMAP2+: Add more functions to pwm pdata for ir-rx51
      ARM: OMAP2+: n900 needs MMC slot names for legacy user space

 arch/arm/Kconfig.debug                         |  8 ----
 arch/arm/boot/dts/exynos4210-trats.dts         |  4 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts     |  5 +++
 arch/arm/boot/dts/exynos5800-peach-pi.dts      |  5 +++
 arch/arm/mach-davinci/cp_intc.c                |  3 ++
 arch/arm/mach-davinci/da8xx-dt.c               | 17 +-------
 arch/arm/mach-davinci/usb.c                    | 16 --------
 arch/arm/mach-exynos/pm_domains.c              |  2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c   | 35 +++++++++++++++-
 arch/arm/mach-omap2/pdata-quirks.c             | 57 ++++++++++++++++++--------
 arch/arm/mach-realview/realview_pbx.c          |  2 +
 arch/arm/mach-rockchip/platsmp.c               |  2 +-
 drivers/of/platform.c                          | 28 ++++++++++---
 drivers/soc/versatile/soc-realview.c           | 19 ++-------
 include/linux/platform_data/media/ir-rx51.h    |  1 +
 include/linux/platform_data/pwm_omap_dmtimer.h | 21 ++++++++++
 16 files changed, 144 insertions(+), 81 deletions(-)
