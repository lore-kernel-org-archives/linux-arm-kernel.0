From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 29 Jan 2015 09:34:14 +0900
Subject: [GIT PULL 3/4] Samsung 2nd DT updates for v3.20
Message-ID: <54C98006.2020405@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is 2nd Samsung DT updates for v3.20, please pull.

Thanks,
Kukjin


The following changes since commit 23c76dc666471dce5ce71b620839d2465723a7c9:

  ARM: dts: Configure regulators for suspend on exynos Peach boards
(2015-01-15 00:30:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt-2

for you to fetch changes up to 6591a02e17e6d6587c3cf7588d523fa6f26b584a:

  ARM: dts: reduce total RAM by 22 MiB for exynos5422-odroidxu3
(2015-01-24 13:24:10 +0900)

----------------------------------------------------------------
Samsung 2nd DT updates for v3.20

- for all of Samsung SoCs
  : use generic power domain bindings
  : add 'dr_mode' property for hsotg/dwc2 devices

- exynos3250-rinato and exynos3250-monk
  : add regulator-haptic

- exynos5422-odroidxu3
  : reduce total RAM by 22 MiB because last 22 MiB
    for secure monitor cannot be accessed by kernel
  : add on-board INA231 sensors and LDO26 of PMIC
    for the sensors

Note that this is based on tags/samsung-dt

----------------------------------------------------------------
Jaewon Kim (2):
      ARM: dts: Add regulator-haptic node for exynos3250-rinato
      ARM: dts: Add regulator-haptic node for exynos3250-monk

Kevin Hilman (1):
      ARM: dts: add on-board INA231 sensors for exynos5422-odroidxu3

Marek Szyprowski (3):
      ARM: dts: convert to generic power domain bindings for exynos DT
      ARM: dts: add 'dr_mode' property to hsotg devices for exynos boards
      ARM: dts: reduce total RAM by 22 MiB for exynos5422-odroidxu3

 .../bindings/arm/exynos/power_domain.txt           |  2 +-
 .../devicetree/bindings/iommu/samsung,sysmmu.txt   |  6 ++--
 .../devicetree/bindings/media/s5p-mfc.txt          |  4 +--
 .../devicetree/bindings/video/exynos_dsim.txt      |  4 +--
 .../devicetree/bindings/video/samsung-fimd.txt     |  4 +--
 arch/arm/boot/dts/exynos3250-monk.dts              |  8 +++++
 arch/arm/boot/dts/exynos3250-rinato.dts            |  8 +++++
 arch/arm/boot/dts/exynos3250.dtsi                  | 11 ++++--
 arch/arm/boot/dts/exynos4.dtsi                     | 25 ++++++++-----
 arch/arm/boot/dts/exynos4210-trats.dts             |  1 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |  1 +
 arch/arm/boot/dts/exynos4210.dtsi                  |  1 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  1 +
 arch/arm/boot/dts/exynos4412-trats2.dts            |  1 +
 arch/arm/boot/dts/exynos4415.dtsi                  |  7 ++++
 arch/arm/boot/dts/exynos4x12.dtsi                  |  7 ++--
 arch/arm/boot/dts/exynos5250.dtsi                  | 12 ++++---
 arch/arm/boot/dts/exynos5420.dtsi                  | 10 ++++--
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         | 41
+++++++++++++++++++++-
 arch/arm/boot/dts/s5pv210-aquila.dts               |  1 +
 arch/arm/boot/dts/s5pv210-goni.dts                 |  1 +
 arch/arm/boot/dts/s5pv210-smdkv210.dts             |  1 +
 22 files changed, 123 insertions(+), 34 deletions(-)
