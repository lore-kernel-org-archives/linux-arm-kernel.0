From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 Jun 2013 06:08:55 +0900
Subject: [GIT PULL 4/6] exynos DT
Message-ID: <51B791E7.7010301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:

   Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/exynos-dt-1

for you to fetch changes up to a38089057fa450944f2e2d07885d76fd727c8d16:

   ARM: dts: add ohci and ehci controller nodes for EXYNOS5440 
(2013-06-12 04:58:34 +0900)

----------------------------------------------------------------
update exynos DT for
- usb3phy and dwc3 for exynos5250
- keypad for exynos4412
- TMU clock for exynos4210
- MFC clock for exynos4
- DP controller for exynos5250
- G2D clock for exynos4
- some exynos boards

----------------------------------------------------------------
Dongjin Kim (2):
       ARM: dts: add max77686 node entry for ODROID-X
       ARM: dts: add vmmc regulator support for ODROID-X

Girish K S (1):
       ARM: dts: add dts node for the ahci sata exynos5440

Jingoo Han (2):
       ARM: dts: add pin state information for DP HPD support to Exynos5250
       ARM: dts: Document DP clock in samsung,exynos5-dp binding

Sachin Kamat (13):
       ARM: dts: Remove keypad entries from exynos4x12-pinctrl.dtsi
       ARM: dts: Add keypad entries to Exynos4412 based Origen
       ARM: dts: Add keypad entries to SMDK4412
       ARM: dts: Add MFC clock entries for exynos4
       ARM: dts: Update MFC documentation for clock entries
       ARM: dts: Add TMU clock entries to exynos4210.dtsi
       ARM: dts: Enable TMU on Origen4210 board
       ARM: dts: Remove combiner IRQ node from exynos4x12.dtsi
       clk: exynos4: Add additional G2D clocks
       ARM: dts: Remove duplicate and add missing G2D nodes
       ARM: dts: Add clock entries to G2D node for exynos4210
       ARM: dts: Add clock entries to G2D node for exynos4x12
       ARM: dts: Update G2D documentation for clock entries

Thomas Abraham (2):
       ARM: dts: add max8997 device node for exynos4210-origen board
       ARM: dts: add ohci and ehci controller nodes for EXYNOS5440

Vikas Sajjan (3):
       ARM: dts: Add DT node for DP controller for Arndale Board
       ARM: dts: Add clock provider information for DP controller in 
Exynos5250 SoC
       ARM: dts: Add display timing node to exynos5250-arndale.dts

Vivek Gautam (3):
       ARM: dts: Enabling samsung-usb3phy driver for exynos5250
       ARM: dts: Add device tree bindings for dwc3-exynos
       ARM: dts: Enabling dwc3-exynos driver for exynos5250

Youngmin Nam (1):
       ARM: dts: Enable RTC by default on EXYNOS5440

  .../devicetree/bindings/clock/exynos4-clock.txt    |   3 +-
  .../devicetree/bindings/gpu/samsung-g2d.txt        |   5 +
  .../devicetree/bindings/media/s5p-mfc.txt          |   5 +
  .../devicetree/bindings/usb/exynos-usb.txt         |  34 ++++
  .../devicetree/bindings/video/exynos_dp.txt        |   6 +
  arch/arm/boot/dts/exynos4.dtsi                     |   2 +
  arch/arm/boot/dts/exynos4210-origen.dts            | 147 +++++++++++++++
  arch/arm/boot/dts/exynos4210.dtsi                  |   5 +
  arch/arm/boot/dts/exynos4412-odroidx.dts           | 197 
+++++++++++++++++++++
  arch/arm/boot/dts/exynos4412-origen.dts            |  66 +++++++
  arch/arm/boot/dts/exynos4412-smdk4412.dts          |  85 ++++++++-
  arch/arm/boot/dts/exynos4x12-pinctrl.dtsi          |  56 ------
  arch/arm/boot/dts/exynos4x12.dtsi                  |  10 +-
  arch/arm/boot/dts/exynos5250-arndale.dts           |  28 +++
  arch/arm/boot/dts/exynos5250-pinctrl.dtsi          |   7 +
  arch/arm/boot/dts/exynos5250-smdk5250.dts          |   3 +
  arch/arm/boot/dts/exynos5250.dtsi                  |  34 +++-
  arch/arm/boot/dts/exynos5440.dtsi                  |  25 ++-
  drivers/clk/samsung/clk-exynos4.c                  |   9 +-
  19 files changed, 657 insertions(+), 70 deletions(-)
