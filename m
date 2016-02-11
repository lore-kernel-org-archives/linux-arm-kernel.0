From: lars.persson@axis.com (Lars Persson)
Date: Thu, 11 Feb 2016 15:04:34 +0100
Subject: [PATCH v2 0/8] arm: Add Artpec-6 SoC
Message-ID: <cover.1455198819.git.larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basic support for the Axis Artpec-6 ARM SoC. Timers, interrupts, UARTs and
ethernet are wired up.

Changes since v1:
- Corrected bindings for axis,artpec6-pll1-clock.
- Moved the uart aliases to the board dts.
- Kconfig cleanup.
- Added a device tree binding for the dma configuration.
- Added CONFIG_SYNOPSYS_DWC_ETH_QOS to multi_v7_defconfig.
- Added binding documentation for axis,artpec6-dev-board.

Lars Persson (8):
  clk: add device tree binding for artpec-6 pll1 clock
  clk: add artpec-6 pll1 clock driver
  arm: add device-tree SoC bindings for Axis Artpec-6
  arm: dts: add Artpec-6 SoC dtsi file
  arm: dts: add Artpec-6 development board dts
  arm: initial machine port for artpec-6 SoC
  arm: multi_v7_defconfig: add MACH_ARTPEC6
  arm: mach-artpec: add entry to MAINTAINERS

 Documentation/devicetree/bindings/arm/axis.txt     |  29 +++
 .../devicetree/bindings/clock/artpec6.txt          |  16 ++
 MAINTAINERS                                        |  10 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/artpec6-devboard.dts             |  64 ++++++
 arch/arm/boot/dts/artpec6.dtsi                     | 236 +++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig                |   3 +
 arch/arm/mach-artpec/Kconfig                       |  20 ++
 arch/arm/mach-artpec/Makefile                      |   1 +
 arch/arm/mach-artpec/board-artpec6.c               |  72 +++++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-artpec6.c                          |  70 ++++++
 14 files changed, 527 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/axis.txt
 create mode 100644 Documentation/devicetree/bindings/clock/artpec6.txt
 create mode 100644 arch/arm/boot/dts/artpec6-devboard.dts
 create mode 100644 arch/arm/boot/dts/artpec6.dtsi
 create mode 100644 arch/arm/mach-artpec/Kconfig
 create mode 100644 arch/arm/mach-artpec/Makefile
 create mode 100644 arch/arm/mach-artpec/board-artpec6.c
 create mode 100644 drivers/clk/clk-artpec6.c

-- 
2.1.4
