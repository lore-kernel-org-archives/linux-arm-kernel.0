From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 15 Feb 2016 09:34:05 +0900
Subject: [GIT PULL 6/7] ARM: dts: Exynos stuff for v4.6
In-Reply-To: <1455496446-23779-1-git-send-email-k.kozlowski@samsung.com>
References: <1455496446-23779-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1455496446-23779-7-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Rest of DTS changes for v4.6. This also pulls early DT changes (related
to SROM controller) because rest of patches depend on it.

Kind regards,
Krzysztof


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.6

for you to fetch changes up to 36a0282a41493400428d7df8c99701fb4ee344c2:

  ARM: dts: Replace legacy *,wakeup property with wakeup-source for exynos boards (2016-01-29 09:09:49 +0900)

----------------------------------------------------------------
Samsung DeviceTree updates and improvements for v4.6:
1. Add SROM controller device nodes.
2. Add Ethernet chip as child of SROM controller on SMDK5410.
3. Allow simultaneous usage exynos-rng and s5p-sss drivers on Exynos5.
4. Cleanup CPU configuration on Exynos542x/5800.
5. Add necessary nodes for cpufreq-dt driver on Exynos542x/5800 (OPPs,
   regulator supplies) which allows frequency and voltage scalling
   of this SoC.
6. Minor cleanups.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (2):
      ARM: dts: Add cluster regulator supply properties for exynos542x/5800
      ARM: dts: Extend existing CPU OPP for exynos5800

Hakjoo Kim (1):
      ARM: dts: Add pinctrl support to exynos5410

Krzysztof Kozlowski (3):
      Merge tag 'samsung-dt-srom-4.6' into next/dt
      ARM: dts: Allow simultaneous usage exynos-rng and s5p-sss drivers on exynos5
      ARM: dts: Make CPU configuration more readable on exynos542x/5800

Marek Szyprowski (1):
      ARM: dts: Add GSCL block parent clock management to pm domain on exynos542x

Pankaj Dubey (2):
      ARM: dts: Add SROM device node for exynos4
      ARM: dts: Add SROM device node for exynos5

Pavel Fedin (2):
      ARM: dts: Add SROM to exynos5410
      ARM: dts: Add Ethernet chip to exynos5410-smdk5410

Sudeep Holla (2):
      ARM: dts: Replace legacy *,wakeup property with wakeup-source on s5pv210
      ARM: dts: Replace legacy *,wakeup property with wakeup-source for exynos boards

Thomas Abraham (1):
      ARM: dts: Add CPU OPP properties for exynos542x/5800

 arch/arm/boot/dts/exynos3250-monk.dts              |   6 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |   6 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   5 +
 arch/arm/boot/dts/exynos4210-origen.dts            |  10 +-
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |   2 +-
 arch/arm/boot/dts/exynos4210-trats.dts             |   2 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |   4 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   2 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |   2 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |   2 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts          |   2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |   4 +-
 arch/arm/boot/dts/exynos5.dtsi                     |   5 +
 arch/arm/boot/dts/exynos5250-arndale.dts           |  12 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |   4 +-
 arch/arm/boot/dts/exynos5250-spring.dts            |   4 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          | 406 +++++++++++++++++++++
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |  41 +++
 arch/arm/boot/dts/exynos5410.dtsi                  |  47 +++
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |  11 +-
 arch/arm/boot/dts/exynos5420-cpus.dtsi             | 102 ++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |  13 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   9 +
 arch/arm/boot/dts/exynos5420.dtsi                  | 170 +++++----
 arch/arm/boot/dts/exynos5422-cpus.dtsi             | 140 ++++---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   8 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |  13 +-
 arch/arm/boot/dts/exynos5800.dtsi                  | 108 ++++++
 arch/arm/boot/dts/s5pv210-aquila.dts               |   4 +-
 arch/arm/boot/dts/s5pv210-goni.dts                 |   4 +-
 arch/arm/boot/dts/s5pv210-smdkv210.dts             |   2 +-
 32 files changed, 989 insertions(+), 163 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5410-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5420-cpus.dtsi
