From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 04 Aug 2015 16:29:06 +0900
Subject: [GIT PULL 3/5] Samsung DT updates for v4.3
Message-ID: <55C069C2.7040208@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull Samsung DT updates for v4.3.

Thanks,
Kukjin


The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt-1

for you to fetch changes up to 5e080b078fa1f929d9aa5586985d5e7c0739d207:

  ARM: dts: Extend exynos5420-pinctrl nodes using labels instead of
paths (2015-07-21 13:01:23 +0900)

----------------------------------------------------------------
Samsung 1st DT updates for v4.3

- for exynos3250
  : update video-phy node with syscon phandle
- for exynos4210
  : add CPU OPP and regulator supply property
  : use labels for overriding nodes for exynos4210-universal_c210
- for exynos4412-trats2
  : set max17047 over heat and voltage thresholds
- for exynos5250 and 5420
  : extend exynos5250/5420-pinctrl nodes using labels
  : include exynos5250/5420-pinctrl after the nodes definitions
- for exynos5410-smdk5410
  : clean up indentation
- for exynos5422-odroidxu3
  : define default thermal-zones for exynos5422
  : enable USB3 regulators, TMU and thermal-zones
  : add pwm-fan node

----------------------------------------------------------------
Anand Moon (5):
      ARM: dts: Enable USB3 regulators for exynos5422-odroidxu3
      ARM: dts: Add pwm-fan node for exynos5422-odroidxu3
      ARM: dts: Enable TMU for exynos5422-odroidxu3
      ARM: dts: Define default thermal-zones for exynos5422
      ARM: dts: Enable thermal-zones for exynos5422-odroidxu3

Andreas Faerber (1):
      ARM: dts: Clean up indentation for exynos5410-smdk5410

Beata Michalska (1):
      ARM: dts: Update video-phy node with syscon phandle for exynos3250

Javier Martinez Canillas (4):
      ARM: dts: Include exynos5250-pinctrl after the nodes were defined
for exynos5250
      ARM: dts: Extend exynos5250-pinctrl nodes using labels instead of
paths
      ARM: dts: Include exynos5420-pinctrl after the nodes were defined
for exynos5420
      ARM: dts: Extend exynos5420-pinctrl nodes using labels instead of
paths

Krzysztof Kozlowski (2):
      ARM: dts: Set max17047 over heat and voltage thresholds for
exynos4412-trats2
      ARM: dts: Use labels for overriding nodes for
exynos4210-universal_c210

Thomas Abraham (1):
      ARM: dts: add CPU OPP and regulator supply property for exynos4210

 arch/arm/boot/dts/exynos3250.dtsi                  |    2 +-
 arch/arm/boot/dts/exynos4210-origen.dts            |    4 +
 arch/arm/boot/dts/exynos4210-trats.dts             |    4 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |  618 ++++----
 arch/arm/boot/dts/exynos4210.dtsi                  |   12 +
 arch/arm/boot/dts/exynos4412-trats2.dts            |    3 +
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          | 1600
++++++++++----------
 arch/arm/boot/dts/exynos5250.dtsi                  |    3 +-
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |    6 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          | 1411 +++++++++--------
 arch/arm/boot/dts/exynos5420.dtsi                  |    3 +-
 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi      |   59 +
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   46 +
 13 files changed, 1951 insertions(+), 1820 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
