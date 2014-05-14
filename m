From: anders.berg@avagotech.com (Anders Berg)
Date: Wed, 14 May 2014 20:37:55 +0200
Subject: [PATCH v3 0/6] Add platform support for LSI AXM55xx
Message-ID: <cover.1400072260.git.anders.berg@avagotech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is version 3 of this series to introduces basic platform support for the LSI
AXM5516 SoC.

No major changes since v2. Ready to be applied to the arm-soc tree?

Changes:

v3:
    * Sorted Kconfig entries alphabetically

v2:
    * Rebased to arm-soc/for-next
    * Removed redundant HAVE_SMP and ARCH_WANT_OPTIONAL_GPIOLIB from Kconfig
    * Use CPU_METHOD_OF_DECLARE to register smp_operations
    * Rework smp operations to avoid holding pen and custom headsmp.S
    * Clean up board file
    * Corrected clock properties for arm,sp804 dts node.
    * Changed machine compatible strings to include full model number.
    * Break out clk-axxia driver as separate patch
    * Removed Makefile.boot


Anders Berg (6):
  ARM: Add platform support for LSI AXM55xx SoC
  clk: Add clock driver for AXM55xx SoC
  ARM: dts: Device tree for AXM55xx.
  ARM: axxia: Adding defconfig for AXM55xx
  power: reset: Add Axxia system reset driver
  ARM: dts: axxia: Add reset controller

 Documentation/devicetree/bindings/arm/axxia.txt    |  12 +
 .../devicetree/bindings/clock/clk-axxia.txt        |  88 ++++++
 .../bindings/power_supply/axxia-reset.txt          |  20 ++
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   2 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/axm5516-amarillo.dts             |  51 ++++
 arch/arm/boot/dts/axm5516-cpus.dtsi                | 204 ++++++++++++++
 arch/arm/boot/dts/axm55xx.dtsi                     | 311 +++++++++++++++++++++
 arch/arm/configs/axm55xx_defconfig                 | 248 ++++++++++++++++
 arch/arm/mach-axxia/Kconfig                        |  16 ++
 arch/arm/mach-axxia/Makefile                       |   2 +
 arch/arm/mach-axxia/axxia.c                        |  28 ++
 arch/arm/mach-axxia/platsmp.c                      |  89 ++++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-axxia.c                            | 281 +++++++++++++++++++
 drivers/power/reset/Kconfig                        |   8 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/axxia-reset.c                  |  97 +++++++
 19 files changed, 1462 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/axxia.txt
 create mode 100644 Documentation/devicetree/bindings/clock/clk-axxia.txt
 create mode 100644 Documentation/devicetree/bindings/power_supply/axxia-reset.txt
 create mode 100644 arch/arm/boot/dts/axm5516-amarillo.dts
 create mode 100644 arch/arm/boot/dts/axm5516-cpus.dtsi
 create mode 100644 arch/arm/boot/dts/axm55xx.dtsi
 create mode 100644 arch/arm/configs/axm55xx_defconfig
 create mode 100644 arch/arm/mach-axxia/Kconfig
 create mode 100644 arch/arm/mach-axxia/Makefile
 create mode 100644 arch/arm/mach-axxia/axxia.c
 create mode 100644 arch/arm/mach-axxia/platsmp.c
 create mode 100644 drivers/clk/clk-axxia.c
 create mode 100644 drivers/power/reset/axxia-reset.c

-- 
1.8.3.2
