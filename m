From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 15 Oct 2017 09:48:23 +0200
Subject: [GIT PULL 3/4] ARM: dts: exynos: Pull for v4.15
In-Reply-To: <20171015074825.11338-1-krzk@kernel.org>
References: <20171015074825.11338-1-krzk@kernel.org>
Message-ID: <20171015074825.11338-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

New board and a some improvements/cleanups.

Best regards,
Krzysztof


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.15

for you to fetch changes up to 3991e054832e52119b238b397e5e510d7fee5bb4:

  dt-bindings: samsung: Document binding for new Odroid HC1 board (2017-10-15 09:31:22 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for 4.15

1. Add new board: Hardkernel Odroid HC1.
2. Fix incomplete Odroid-XU3/4 thermal-zones definition leading to
   possible overheat if first pair of A7+A15 cores is idle but rest of
   CPUs are busy.
3. Add capacity-dmips-mhz properties for CPUs of octa-core SoCs.
4. Add power button to Odroid XU3/4.
5. Improvements in Gscaler, HDMI and Mixer blocks on Exynos5.
6. Add suspend quirk to DWC3 USB controller to fix enumeration of
   SuperSpeed devices on Odroid XU4.
7. Add HDMI and MHL to Trats2.
8. Cleanups (redundant properties and nodes).

----------------------------------------------------------------
Andrzej Pietrasiewicz (1):
      ARM: dts: exynos: Add dwc3 SUSPHY quirk

Brian Kim (1):
      ARM: dts: exynos: Add power button for Odroid XU3/4

Dietmar Eggemann (2):
      ARM: dts: exynos: add exynos5420 cpu capacity-dmips-mhz information
      ARM: dts: exynos: add exynos5422 cpu capacity-dmips-mhz information

Hoegeun Kwon (2):
      ARM: dts: exynos: Remove the display-timing and delay from Rinato
      ARM: dts: exynos: Use specific compatibles for proper Gscaler limits on Exynos5250 and Exynos5420

Krzysztof Kozlowski (1):
      dt-bindings: samsung: Document binding for new Odroid HC1 board

Maciej Purski (1):
      ARM: dts: exynos: Add HDMI and Sil9234 to Trats2 board

Marek Szyprowski (7):
      ARM: dts: exynos: Remove redundant interrupt properties in gpio-keys on Odroid boards
      ARM: dts: exynos: Move HDMI PHY node from boards to exynos5250.dtsi
      ARM: dts: exynos: Cleanup HDMI DCC definitions on Exynos5250 and Exynos542x boards
      ARM: dts: exynos: Add status property to Exynos 5250 HDMI and Mixer nodes
      ARM: dts: exynos: Add status property to Exynos 542x Mixer nodes
      ARM: dts: exynos: Move audio clocks configuration to odroidxu3-audio.dtsi
      ARM: dts: exynos: Add support for Hardkernel's Odroid HC1 board

Willy Wolff (1):
      ARM: dts: exynos: fix incomplete Odroid-XU3/4 thermal-zones definition

 .../bindings/arm/samsung/samsung-boards.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos3250-rinato.dts            |  22 -
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   2 -
 arch/arm/boot/dts/exynos4412-odroidx.dts           |   2 -
 arch/arm/boot/dts/exynos4412-trats2.dts            | 111 ++++
 arch/arm/boot/dts/exynos5250-arndale.dts           |  22 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |  18 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |  18 +-
 arch/arm/boot/dts/exynos5250-spring.dts            |  18 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |  18 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   4 +
 arch/arm/boot/dts/exynos5420-cpus.dtsi             |   8 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   4 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   9 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |   5 +-
 arch/arm/boot/dts/exynos5422-cpus.dtsi             |   8 +
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 443 +++++++++++++
 arch/arm/boot/dts/exynos5422-odroidhc1.dts         | 213 ++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi  |  13 +
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 711 ++++++++-------------
 arch/arm/boot/dts/exynos54xx.dtsi                  |   2 +
 22 files changed, 1110 insertions(+), 543 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5422-odroid-core.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidhc1.dts
