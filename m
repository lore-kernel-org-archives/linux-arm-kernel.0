From: lars.persson@axis.com (Lars Persson)
Date: Wed, 10 Feb 2016 13:41:49 +0100
Subject: [PATCH 0/8] arm: Add Artpec-6 SoC
Message-ID: <cover.1455107681.git.larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basic support for the Axis Artpec-6 ARM SoC. Timers, interrupts, UARTs and
ethernet are wired up.

Lars Persson (8):
  clk: add device tree binding for artpec-6 pll1 clock
  clk: add artpec-6 pll1 clock driver
  arm: add device-tree SoC bindings for Axis Artpec-6
  arm: dts: add Artpec-6 soc dtsi file
  arm: dts: add Artpec-6 development board dts
  arm: initial machine port for artpec-6 SoC
  arm: multi_v7_defconfig: add MACH_ARTPEC6
  arm: mach-artpec: add entry to MAINTAINERS

 Documentation/devicetree/bindings/arm/axis.txt     |   8 +
 .../devicetree/bindings/clock/artpec6.txt          |  14 ++
 MAINTAINERS                                        |  10 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/artpec6-devboard.dts             |  57 +++++
 arch/arm/boot/dts/artpec6.dtsi                     | 238 +++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig                |   2 +
 arch/arm/mach-artpec/Kconfig                       |  22 ++
 arch/arm/mach-artpec/Makefile                      |   1 +
 arch/arm/mach-artpec/board-artpec6.c               |  66 ++++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-artpec6.c                          |  70 ++++++
 14 files changed, 494 insertions(+)
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
