From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 06 Jun 2015 03:05:24 +0900
Subject: [GIT PULL 4/5] Samsung another DT updates for v4.2
Message-ID: <5571E4E4.1070900@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is another Samsung DT updates for v4.2 but this is based on
v4.1-rc6 + previous tags/samsung-dt-3 because this touches all of exynos
DT stuff and some fixes have been merged until -rc6...

I thought this is the best way to avoid useless merge conflicts.

Please pull and if any problems, please kindly let me know.

Thanks,
Kukjin


The following changes since commit b9974fa208d9175a6d1d21f6b1068e1779295934:

  Merge branch 'v4.2-next/dt-samsung-3rd' into v4.2-next/dt-samsung-4th
(2015-06-03 09:56:00 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt-4

for you to fetch changes up to b7004516781503c0e4782288025ca2ce4a78f020:

  ARM: dts: add sysmmu nodes for exynos5420 (2015-06-04 08:09:42 +0900)

----------------------------------------------------------------
Samsung another DT udpates for v4.2

- use labels for overriding nodes for all of exynos stuff
  (by Krzysztof Kozlowski)

- add sysmmu nodes for exynos SoCs (by Marek Szyprowski)

- for exynos5422-odroidxu3
  : enalbe wake alarm of S2MPS11 RTC
  : Hook up PWM and use it for LEDs
  : add support for Odroid XU3 Lite

- remove duplicated i2c7 for exynos5250-snow
- add JPEG codec nodes for exynos5420
- add vendor prefix for Hardkernel

----------------------------------------------------------------
Andrzej Pietrasiewicz (1):
      ARM: dts: exynos5420: add nodes for jpeg codec

Krzysztof Kozlowski (26):
      ARM: dts: Add labels to exynos4 nodes
      ARM: dts: Use labels for overriding nodes in exynos4210
      ARM: dts: Use labels for overriding nodes in exynos4210-origen
      ARM: dts: Use labels for overriding nodes in exynos4210-smdkv310
      ARM: dts: Use labels for overriding nodes in exynos4210-trats
      ARM: dts: Use labels for overriding nodes in exynos4212
      ARM: dts: Use labels for overriding nodes in exynos4x12
      ARM: dts: Use labels for overriding nodes in exynos4412
      ARM: dts: Use labels for overriding nodes in exynos4412-odroid
      ARM: dts: Use labels for overriding nodes in exynos4412-smdk4412
      ARM: dts: Use labels for overriding nodes in exynos4412-trats2
      ARM: dts: Use labels for overriding nodes in exynos4412-origen
      ARM: dts: Use labels for overriding nodes in exynos4412-tiny4412
      ARM: dts: Add labels to exynos5 nodes
      ARM: dts: Use labels for overriding nodes in exynos5250
      ARM: dts: Remove duplicated I2C7 nodes in exynos5250-snow
      ARM: dts: Use labels for overriding nodes in exynos5420-arndale-octa
      ARM: dts: Use labels for overriding nodes in exynos542x
      ARM: dts: Use labels for overriding nodes in exynos5420-smdk5420
      ARM: dts: Use labels for overriding nodes in exynos5440 boards
      ARM: dts: Use labels for overriding nodes in exynos5422-odroidxu3
      ARM: dts: s3c2416: Add labels to S3C2416 nodes
      ARM: dts: s3c2416: Use labels for overriding nodes in SMDK2416
      ARM: dts: odroidxu3: Enable wake alarm of S2MPS11 RTC
      of: Add vendor prefix for Hardkernel
      ARM: dts: Add Odroid XU3 Lite support

Marek Szyprowski (5):
      ARM: dts: add sysmmu nodes for exynos4
      ARM: dts: add sysmmu nodes for exynos3250
      ARM: dts: add sysmmu nodes for exynos4415
      ARM: dts: add sysmmu nodes for exynos5250
      ARM: dts: add sysmmu nodes for exynos5420

Peter Chubb (1):
      ARM: dts: exynos5422-odroidxu3: Hook up PWM and use it for LEDs

 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/exynos3250.dtsi                  |   33 +
 arch/arm/boot/dts/exynos4.dtsi                     |  140 +-
 arch/arm/boot/dts/exynos4210-origen.dts            |  418 +++---
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |  280 ++--
 arch/arm/boot/dts/exynos4210-trats.dts             |  592 ++++-----
 arch/arm/boot/dts/exynos4210.dtsi                  |   72 +-
 arch/arm/boot/dts/exynos4212.dtsi                  |   12 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  732 +++++------
 arch/arm/boot/dts/exynos4412-odroidx.dts           |   16 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |  892 ++++++-------
 arch/arm/boot/dts/exynos4412-smdk4412.dts          |  210 +--
 arch/arm/boot/dts/exynos4412-tiny4412.dts          |   54 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            | 1332
++++++++++----------
 arch/arm/boot/dts/exynos4412.dtsi                  |   20 +-
 arch/arm/boot/dts/exynos4415.dtsi                  |   11 +
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi          |    8 +-
 arch/arm/boot/dts/exynos4x12.dtsi                  |  290 +++--
 arch/arm/boot/dts/exynos5.dtsi                     |    6 +-
 arch/arm/boot/dts/exynos5250-snow.dts              |   46 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |  332 ++++-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |  634 +++++-----
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |    2 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |  645 +++++-----
 arch/arm/boot/dts/exynos5420.dtsi                  |  281 ++++-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  479 +++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |   20 +
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         |  430 +------
 arch/arm/boot/dts/exynos5440-sd5v1.dts             |   10 +-
 arch/arm/boot/dts/exynos5440-ssdk5440.dts          |   85 +-
 arch/arm/boot/dts/exynos5440.dtsi                  |    4 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |    2 +-
 arch/arm/boot/dts/s3c2416-smdk2416.dts             |   86 +-
 arch/arm/boot/dts/s3c2416.dtsi                     |   18 +-
 35 files changed, 4491 insertions(+), 3703 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
