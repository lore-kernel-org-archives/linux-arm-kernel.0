From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 Aug 2013 07:35:08 +0900
Subject: [GIT PULL 2/2] Samsung Exynos DT for v3.12
Message-ID: <160101ce9c63$31b146c0$9513d440$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt-1

for you to fetch changes up to 6f9d02a056fff8e965da0f940a09d4c39a4fe80a:

  ARM: dts: Add USB host node for Exynos4 (2013-08-19 05:07:17 +0900)

----------------------------------------------------------------
Samsung Exynos DT updates for v3.12
- update codec, pmic, usb hub for Arndale
- add exynos4412-trats 2 board dt
- update camera, spi, sensor for Trats2
- update fimc, sensor for Trats
- add support tmu for exynos5440
- add support g2d for exynos5250
- correct camera pinctrl for exynos4x12
- add support camera subsystem for exynos4
- add support basic pm domain, fimd, dp for exynos5420
- add support secure-firmware for OrigenQuad
- update mfc and add support mfc for exynos5420
- add usb host node for exynos4

----------------------------------------------------------------
Amit Daniel Kachhap (1):
      ARM: dts: Add device tree node for exynos5440 TMU controller

Andrew Bresticker (1):
      ARM: dts: add audio clock controller for exynos5420

Andrzej Hajda (3):
      ARM: dts: Add SPI1 controller and s5c73m3 sensor node for TRATS2
      ARM: dts: Add Exynos4210 SoC camera port pinctrl nodes
      ARM: dts: Add S5K5BA sensor regulator definitions for Trats board

Arun Kumar K (4):
      ARM: dts: Update clocks entry in MFC binding documentation
      ARM: dts: Remove unsused MFC clock from exynos4
      ARM: dts: Update 5250 MFC node
      ARM: dts: Add MFC node for exynos 5420

Dongjin Kim (1):
      ARM: dts: Add USB host node for Exynos4

Jacek Anaszewski (1):
      ARM: dts: Add AK8975 device node for Exynos4412 TRATS2 board

Kukjin Kim (1):
      ARM: dts: re-ordering exynos dtbs in Makefile

Mark Brown (6):
      ARM: dts: Hook up IRQ for PMIC on Arndale
      ARM: dts: Put Arndale fixed voltage regulators on a simple-bus
      ARM: dts: Hook up supplies for Arndale S5M8767
      ARM: dts: Add WM1811A audio CODEC to Arndale bindings
      ARM: dts: Enable USB hub on Arndale
      ARM: dts: Hook up internal PHY on Arndale

Padmavathi Venna (1):
      ARM: dts: Correct the /include entry on exynos5420 dtsi file

Sachin Kamat (1):
      ARM: dts: Add G2D support to exynos5250

Sylwester Nawrocki (9):
      ARM: dts: Correct camera pinctrl nodes for Exynos4x12 SoCs
      ARM: dts: Add pinctrl entries for Exynos4x12 FIMC-IS peripherals
      ARM: dts: Add ISP power domain node for Exynos4x12
      ARM: dts: Use generic DMA bindings for Exynos4 SPI devices
      ARM: dts: Add camera subsystem device nodes to exynos4.dtsi
      ARM: dts: Add camera subsystem nodes to exynos4x12.dtsi
      ARM: dts: Add camera device nodes for Exynos4412 TRATS2 board
      ARM: dts: Add camera device nodes for Exynos4210 SoCs
      ARM: dts: Add FIMC nodes for Exynos4210 Trats board

Tomasz Figa (1):
      ARM: dts: Add basic dts for Exynos4412-based Trats 2 board

Tushar Behera (1):
      ARM: dts: Add secure-firmware boot support for OrigenQaud board

Vikas Sajjan (6):
      ARM: dts: Move display-timing information inside FIMD DT node for
exynos5250
      ARM: dts: Update FIMD DT node for Exynos5 SoCs
      ARM: dts: Add FIMD DT node to exynos5420 DTS files
      ARM: dts: Update DP controller DT Node for Exynos5 based SoCs
      ARM: dts: Add DP controller DT node to exynos5420 SoC
      ARM: dts: Add pin state information for DP HPD support to Exynos5420

Yadwinder Singh Brar (1):
      ARM: dts: Add basic PM domains for EXYNOS5420

 .../devicetree/bindings/media/s5p-mfc.txt          |   10 +-
 arch/arm/boot/dts/Makefile                         |    5 +-
 arch/arm/boot/dts/exynos4.dtsi                     |  122 ++++-
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          |   23 +
 arch/arm/boot/dts/exynos4210-trats.dts             |  100 +++-
 arch/arm/boot/dts/exynos4210.dtsi                  |   30 +
 arch/arm/boot/dts/exynos4412-origen.dts            |    5 +
 arch/arm/boot/dts/exynos4412-trats2.dts            |  579
++++++++++++++++++++
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi          |   61 ++-
 arch/arm/boot/dts/exynos4x12.dtsi                  |  103 ++++
 arch/arm/boot/dts/exynos5.dtsi                     |   19 +
 arch/arm/boot/dts/exynos5250-arndale.dts           |  105 +++-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   32 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |   38 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |    7 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   31 ++
 arch/arm/boot/dts/exynos5420.dtsi                  |   75 ++-
 arch/arm/boot/dts/exynos5440.dtsi                  |   27 +
 18 files changed, 1288 insertions(+), 84 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4412-trats2.dts
