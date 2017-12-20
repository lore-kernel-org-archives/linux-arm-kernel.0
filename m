From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 20 Dec 2017 18:36:42 +0100
Subject: [GIT PULL 1/3] ARM: dts: exynos: DTS for v4.16
In-Reply-To: <20171220173643.5840-1-krzk@kernel.org>
References: <20171220173643.5840-1-krzk@kernel.org>
Message-ID: <20171220173643.5840-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.16

for you to fetch changes up to 3be1ecf291df8191f5ea395d363acc8fa029b5fd:

  ARM: dts: exynos: Use lower case hex addresses in node unit addresses (2017-12-18 18:15:51 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for 4.16

1. Add sound support to Odroid XU4 (and adjustments to Odroid XU3).
2. Enable WiFi on Trats2.
3. Add CPU perf counters to Exynos54xx.
4. Add power domains to certain chipsets.
5. Add Exynos4412 ISP clock controller which finally solves freezes when
   accessing ISP clocks while having the ISP power domain turned off.
6. Add Pseudo and True RNG to Exynos5.
7. Minor fixes for Trats2, Odroid XU3/XU4, Exynos5410.
8. Cleanup of some of DTC warnings

----------------------------------------------------------------
Dongjin Kim (1):
      ARM: dts: exynos: Fix property values of LDO15/17 for Odroid XU3/XU4

Krzysztof Kozlowski (2):
      ARM: dts: exynos: Add missing interrupt-controller properties to Exynos5410 PMU
      ARM: dts: exynos: Use lower case hex addresses in node unit addresses

Marek Szyprowski (5):
      ARM: dts: exynos: Add Exynos4412 ISP clock controller
      ARM: dts: exynos: Add audio power domain support to Exynos542x SoCs
      ARM: dts: exynos: Fix power domain node names for Exynos5250
      ARM: dts: exynos: Add audio power domain to Exynos5250
      ARM: dts: exynos: Add G3D power domain to Exynos5250

Marian Mihailescu (1):
      ARM: dts: exynos: Add CPU perf counters to Exynos54xx boards

Simon Shields (2):
      ARM: dts: exynos: Correct Trats2 panel reset line
      ARM: dts: exynos: Add bcm4334 device node to Trats2

Sylwester Nawrocki (2):
      ARM: dts: exynos: Switch to dedicated Odroid XU3 sound card binding
      ARM: dts: exynos: Add sound support for Odroid XU4

Tobias Jakobi (1):
      ARM: dts: exynos: Move G2D node to exynos5.dtsi

?ukasz Stelmach (3):
      ARM: dts: exynos: Remove duplicate definitions of SSS nodes for Exynos5
      ARM: dts: exynos: Add DT nodes for PRNG in Exynos5 SoCs
      ARM: dts: exynos: Add nodes for True Random Number Generator

 arch/arm/boot/dts/exynos3250.dtsi                 |  34 +++---
 arch/arm/boot/dts/exynos4.dtsi                    |  57 +++++-----
 arch/arm/boot/dts/exynos4210.dtsi                 |   8 +-
 arch/arm/boot/dts/exynos4412-pinctrl.dtsi         |   2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts           |  29 ++++-
 arch/arm/boot/dts/exynos4412.dtsi                 |  93 +++++++++-------
 arch/arm/boot/dts/exynos5.dtsi                    |  45 ++++++--
 arch/arm/boot/dts/exynos5250.dtsi                 | 126 +++++++++++++---------
 arch/arm/boot/dts/exynos5260.dtsi                 |  26 ++---
 arch/arm/boot/dts/exynos5410.dtsi                 |  18 ++++
 arch/arm/boot/dts/exynos5420-cpus.dtsi            |  10 ++
 arch/arm/boot/dts/exynos5420.dtsi                 |  71 ++++++++----
 arch/arm/boot/dts/exynos5422-cpus.dtsi            |  10 ++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi     |   6 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi |  60 +++++++----
 arch/arm/boot/dts/exynos5422-odroidxu4.dts        |  52 +++++++++
 arch/arm/boot/dts/exynos5440.dtsi                 |  14 +--
 arch/arm/boot/dts/exynos54xx.dtsi                 |  26 +++--
 18 files changed, 464 insertions(+), 223 deletions(-)
