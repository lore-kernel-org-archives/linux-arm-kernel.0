From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 13 Oct 2015 04:59:27 +0900
Subject: [GIT PULL] Samsung DT updates for v4.4
Message-ID: <561C111F.3060704@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

Here is Samsung DT updates for v4.4, please pull.

Thanks,
Kukjin

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt-1

for you to fetch changes up to df829b06f0079165d9dc7719af8f8a7da852fe51:

  ARM: dts: Use GPIO constants for flags cells in exynos5440 boards
(2015-10-08 07:39:58 +0900)

----------------------------------------------------------------
Samsung DT updates for v4.4

- New board support
  : add exynos5250-snow-rev5 DT file to support Snow Rev5+ board
  : add exynos5422-odroidxu4 DT file to support Odroid XU4 board
  : split exynos5422-odroidxu3-audio DT file from odroidxu3-common

- USE GPIO constants for flags cells for exynos boards
- fix cpu compatible value to 'arm926ej-s' for s3c2416

- add DMA support for serial ports for exynos4
- add suspend opp for exynos4412
- remove regulator-compatible usage for exynos4412-trats2

- enable EC vboot context support for Peach boards
- move display-timings node to DP for exynos5250-arndale, smdk5250 and
smdk5420

- for exynos4412-odroid/odroidu3
  : unify voltage regulator style and
  : remove redundant pinctrl settings
  : add pwm-fan node and use it as a colling device

- for exynos5422-odroidxu3
  : fix power off method and LEDs

- dt-bindings
  : grounded AC0KB pin on S2MPS11
  : entry how to use PWM FAN as a cooling device

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      ARM: dts: add suspend opp to exynos4412

Emilio Lopez (1):
      ARM: dts: Enable EC vboot context support on Peach boards

Javier Martinez Canillas (7):
      ARM: dts: Add Exynos5250 Snow Rev5+ support on exynos5250-snow-rev5
      ARM: dts: Remove regulator-compatible usage in exynos4412-trats2
      ARM: dts: Use GPIO constants for flags cells in exynos3250 boards
      ARM: dts: Use GPIO constants for flags cells in exynos4120 boards
      ARM: dts: Use GPIO constants for flags cells in exynos4412 boards
      ARM: dts: Use GPIO constants for flags cells in
exynos5420/5422/5800 boards
      ARM: dts: Use GPIO constants for flags cells in exynos5440 boards

Kamil Debski (1):
      ARM: dts: Add pwm-fan node for exynos4412-odroidu3

Krzysztof Kozlowski (5):
      ARM: dts: Fix LEDs on exynos5422-odroidxu3
      dt-bindings: Document grounded ACOKB pin on S2MPS11
      ARM: dts: Fix power off method for exynos5422-odroidxu3-common
      ARM: dts: Split audio configuration to separate
exynos5422-odroidxu3-audio
      ARM: dts: Add support Odroid XU4 board for exynos5422-odroidxu4

Kukjin Kim (1):
      Merge tag 'samsung-dt-4.4-2' of http://github.com/krzk/linux into
v4.4-next/dt-samsung

Lukasz Majewski (2):
      dt-bindings: Documentation entry to explain how to use PWM FAN as
a cooling device
      ARM: dts: use pwm-fan device as a cooling device for
exynos4412-odroidu3

Robert Baldyga (1):
      ARM: dts: Add DMA support for serial ports in exynos4

Sean Paul (1):
      ARM: dts: Move display-timings node from fimd to dp in
exynos5250-arndale, smdk5250 and smdk5420

Tobias Jakobi (2):
      ARM: dts: Remove redundant pinctrl settings in exynos4412-odroid
      ARM: dts: Unify voltage regulator style in exynos4412-odroid

Vladimir Zapolskiy (1):
      ARM: dts: Fix cpu compatible value for s3c2416

 .../devicetree/bindings/hwmon/pwm-fan.txt          |  29 +-
 Documentation/devicetree/bindings/mfd/s2mps11.txt  |   4 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/exynos3250-monk.dts              |   8 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |  10 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   8 +
 arch/arm/boot/dts/exynos4210-origen.dts            |  15 +-
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |   3 +-
 arch/arm/boot/dts/exynos4210-trats.dts             |  29 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |  42 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  27 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |  45 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |   8 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |  15 +-
 arch/arm/boot/dts/exynos4412-tiny4412.dts          |   9 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            | 139 ++---
 arch/arm/boot/dts/exynos4412.dtsi                  |   1 +
 arch/arm/boot/dts/exynos5250-arndale.dts           |   8 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |  16 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      | 684
+++++++++++++++++++++
 arch/arm/boot/dts/exynos5250-snow-rev5.dts         |  47 ++
 arch/arm/boot/dts/exynos5250-snow.dts              | 671
+-------------------
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   3 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   9 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |  14 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi  |  61 ++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 103 +---
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |  51 ++
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         |  51 ++
 arch/arm/boot/dts/exynos5422-odroidxu4.dts         |  48 ++
 arch/arm/boot/dts/exynos5440-ssdk5440.dts          |   5 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   9 +-
 arch/arm/boot/dts/s3c2416.dtsi                     |   2 +-
 33 files changed, 1207 insertions(+), 969 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5250-snow-common.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5250-snow-rev5.dts
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu4.dts
