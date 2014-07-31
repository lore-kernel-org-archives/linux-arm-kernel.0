From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 01 Aug 2014 03:20:06 +0900
Subject: [GIT PULL] Samsung 2nd DT updates for v3.17
Message-ID: <53DA88D6.9010700@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6da287ad0266cca1fa8f88fb8b1c466e8164671f:

   Merge branch 'v3.17-next/power-exynos' into v3.17-next/dt-samsung-2 
(2014-07-29 06:09:42 +0900)

are available in the git repository at:


   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-dt-2

for you to fetch changes up to a9408a6bba0de106d702fe5fa36fdc545116e9ab:

   ARM: dts: Add missing pinctrl for uart0/1 for exynos3250 (2014-07-30 
07:57:32 +0900)

----------------------------------------------------------------
Samsung DT 2nd updates for v3.17

This is based on tags/exynos-power because this DT changes
are depending PMU cleanup.

Fixes boot for exynos5260 and exynos5410,
- Since exynos cannot boot without obtaining PMU address via
   DT from now on, add PMU node for exynos5260 and exynos5410

For preparing exynos5250-spring,
- move max77686 and cypress,cyapa trackpad from exynos5250-
   cros-common to exynos5250-snow DT file
(Note exynos5250-spring is not included in this branch yet)

For exynos3250,
- add TMU node and remove duplicated interrupt-parent
- add missing pinctrl property for uart0 and uart1

For exynos5250-smdk5250 board
- add max77686 pmic interrupt property which is connected to
   gpx3

----------------------------------------------------------------
Andreas Faerber (5):
       ARM: dts: Document exynos5410 PMU
       ARM: dts: Add PMU to exynos5410
       ARM: EXYNOS: Add support for Exynos5410 PMU
       ARM: dts: max77686 is exynos5250-snow only
       ARM: dts: cypress,cyapa trackpad is exynos5250-Snow only

Chanwoo Choi (3):
       ARM: dts: Add TMU dt node to monitor the temperature for exynos3250
       ARM: dts: Remove duplicate 'interrput-parent' property for exynos3250
       ARM: dts: Add missing pinctrl for uart0/1 for exynos3250

Thomas Abraham (1):
       ARM: dts: Specify MAX77686 pmic interrupt for exynos5250-smdk5250

Vikas Sajjan (2):
       ARM: dts: Add PMU DT node for exynos5260 SoC
       ARM: EXYNOS: Add exynos5260 PMU compatible string to DT match table

  .../devicetree/bindings/arm/samsung/pmu.txt        |   2 +
  arch/arm/boot/dts/exynos3250.dtsi                  |  15 +-
  arch/arm/boot/dts/exynos5250-cros-common.dtsi      | 159 
--------------------
  arch/arm/boot/dts/exynos5250-smdk5250.dts          |   2 +
  arch/arm/boot/dts/exynos5250-snow.dts              | 165 
+++++++++++++++++++++
  arch/arm/boot/dts/exynos5260.dtsi                  |   5 +
  arch/arm/boot/dts/exynos5410.dtsi                  |   5 +
  arch/arm/mach-exynos/exynos.c                      |   2 +
  8 files changed, 194 insertions(+), 161 deletions(-)
