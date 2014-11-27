From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 27 Nov 2014 16:06:42 +0900
Subject: [GIT PULL 3/4] Samsung 3rd round of DT updates for v3.19
Message-ID: <5476CD82.5050705@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a427d15062ac46a00a22d2f0b9d05093c18ff2f1:

  ARM: dts: Add micro SD card SDHCI node for exynos4412-trats
(2014-11-07 08:28:24 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt-3

for you to fetch changes up to 1888eb75e68caceaab2fe0db820bd6ed574a468f:

  ARM: dts: add sysreg phandle to i2c device nodes for exynos
(2014-11-27 03:24:45 +0900)

----------------------------------------------------------------
Samsung 3rd DT updates for v3.19

- exynos3250
  : remove unused bootargs on exynos3250-rinato
  : add new board dt file for exynos3250-monk
- exynos4
  : add missing clock for MFC
  : specify default clocks for camera
- exynos4x12
  : add TMU related DT nodes
- exynos4412-trats2
  : add max77693-haptic and pwm nodes, enable TMU support
- exynos4412-odroid
  : specify audio clock parents and rates
- exynos5250 and exynos5420
  : add syscon based phandle to i2c device nodes
- exynos5250-spring
  : add trackpad, temperature sensor and usb3505 pinctrl

Note: based on previous tags/samsung-dt-2 for v3.19

----------------------------------------------------------------
Andreas Faerber (3):
      ARM: dts: Add usb3503 pinctrl to exynos5250-spring
      ARM: dts: Add temperature sensor to exynos5250-spring
      ARM: dts: Add trackpad to exynos5250-spring

Chanwoo Choi (2):
      Documentation: devicetree: Add Exynos-based boards compatible string
      ARM: dts: Remove unused bootargs from exynos3250-rinato

Jaewon Kim (2):
      ARM: dts: add pwm node for exynos4412-trats2
      ARM: dts: Add max77693-haptic node for exynos4412-trats2

Lukasz Majewski (2):
      ARM: dts: Device tree node definition for TMU on exynos4x12
      ARM: dts: Enable TMU support for exynos4412-trats2

Marek Szyprowski (1):
      ARM: dts: add missing clock to MFC device for exynos4

Pankaj Dubey (1):
      ARM: dts: add sysreg phandle to i2c device nodes for exynos

Sylwester Nawrocki (2):
      ARM: dts: Specify default clocks for Exynos4 camera devices
      ARM: dts: Specify audio clock parents and rates for
exynos4412-odroid-common

Youngjun Cho (1):
      ARM: dts: add board dts file for Exynos3250-based Monk board

 .../devicetree/bindings/arm/samsung-boards.txt     |  19 +-
 .../devicetree/bindings/i2c/i2c-s3c2410.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/exynos3250-monk.dts              | 579
+++++++++++++++++++++
 arch/arm/boot/dts/exynos3250-rinato.dts            |   4 -
 arch/arm/boot/dts/exynos4.dtsi                     |   4 +-
 arch/arm/boot/dts/exynos4210-trats.dts             |  16 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |  16 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  26 +
 arch/arm/boot/dts/exynos4412-trats2.dts            |  50 +-
 arch/arm/boot/dts/exynos4x12.dtsi                  |  10 +
 arch/arm/boot/dts/exynos5250-spring.dts            |  30 ++
 arch/arm/boot/dts/exynos5250.dtsi                  |   4 +
 arch/arm/boot/dts/exynos5420.dtsi                  |   4 +
 14 files changed, 751 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos3250-monk.dts
