From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Mar 2014 23:13:49 +0900
Subject: [GIT PULL 2/2] Samsung 2nd DT updates for v3.15
Message-ID: <5328549D.1090008@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 86feafebbec2b510daf36ffbdbe10228ed890b00:

   ARM: dts: use macros in clock bindings for exynos5440 (2014-02-26 
09:53:31 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-dt-2

for you to fetch changes up to ba0d7ed391b7b3fb5ca98d9cf4d067b7f5ed956b:

   ARM: dts: enable ahci sata and sata phy for exynos5250 (2014-03-18 
07:49:14 +0900)

----------------------------------------------------------------
Samsung 2nd DT updates for v3.15
- add DT entry for AHCI SATA and SATA PHY with using generic
   PHY framework for exynos5250 and arndale, smdk5250 boards.
- add SSS DT node for exynos5420 and exynos5250
- remove leftover spi0 node for smdk5250 board
- add ADC and thermistor nodes for exynos4412-trats2 board
- move common irq-combiner node for exynos4x12 from exynos4212
   and exynos4412
- add ADC, PMU and GPS_ALIVE power domain nodes for exynos4x12

Note that based on previous tags/samsung-dt and tags/exynos-clk

----------------------------------------------------------------
Chanwoo Choi (5):
       ARM: dts: Add ADC's dt data to read raw data for exynos4x12
       ARM: dts: Add PMU dt data to support PMU for exynos4x12
       ARM: dts: Add GPS_ALIVE power domain for exynos4x12
       ARM: dts: Move common dt data for interrupt combiner controller 
for exynos4x12
       ARM: dts: Add ADC and themistor nodes for exynos4412-trats2

Mark Brown (1):
       ARM: dts: Remove leftover spi0 node for smdk5250

Naveen Krishna Chatradhi (1):
       ARM: dts: add dt node for sss module for exynos5250/5420

Yuvaraj Kumar C D (1):
       ARM: dts: enable ahci sata and sata phy for exynos5250

  .../devicetree/bindings/ata/exynos-sata-phy.txt    | 14 ---------
  .../devicetree/bindings/ata/exynos-sata.txt        | 25 +++++++++------
  .../devicetree/bindings/phy/samsung-phy.txt        | 36 
++++++++++++++++++++++
  arch/arm/boot/dts/exynos4.dtsi                     |  5 +++
  arch/arm/boot/dts/exynos4212.dtsi                  | 13 +++-----
  arch/arm/boot/dts/exynos4412-trats2.dts            | 21 +++++++++++++
  arch/arm/boot/dts/exynos4412.dtsi                  | 14 +++------
  arch/arm/boot/dts/exynos4x12.dtsi                  | 26 ++++++++++++++++
  arch/arm/boot/dts/exynos5250-arndale.dts           | 21 +++++++++++++
  arch/arm/boot/dts/exynos5250-smdk5250.dts          | 21 +++++++------
  arch/arm/boot/dts/exynos5250.dtsi                  | 26 +++++++++++++---
  arch/arm/boot/dts/exynos5420.dtsi                  |  9 ++++++
  12 files changed, 175 insertions(+), 56 deletions(-)
  delete mode 100644 
Documentation/devicetree/bindings/ata/exynos-sata-phy.txt
