From: anders.berg@lsi.com (Anders Berg)
Date: Tue, 15 Apr 2014 14:06:09 +0200
Subject: [PATCH 0/5] Add platform support for LSI AXM55xx
Message-ID: <cover.1397552154.git.anders.berg@lsi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set of patches introduces basic platform support for the LSI AXM5516 SoC.
This is another 16 core machine (4x4 cluster config). Please review and provide
feedback.

Regards,
Anders


Anders Berg (5):
  ARM: Add platform support for LSI AXM55xx SoC
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
 arch/arm/mach-axxia/Kconfig                        |  19 ++
 arch/arm/mach-axxia/Makefile                       |   2 +
 arch/arm/mach-axxia/Makefile.boot                  |   2 +
 arch/arm/mach-axxia/axxia.c                        | 117 ++++++++
 arch/arm/mach-axxia/axxia.h                        |  42 +++
 arch/arm/mach-axxia/headsmp.S                      |  44 +++
 arch/arm/mach-axxia/platsmp.c                      | 183 ++++++++++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-axxia.c                            | 281 +++++++++++++++++++
 drivers/power/reset/Kconfig                        |   8 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/axxia-reset.c                  |  97 +++++++
 22 files changed, 1736 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/axxia.txt
 create mode 100644 Documentation/devicetree/bindings/clock/clk-axxia.txt
 create mode 100644 Documentation/devicetree/bindings/power_supply/axxia-reset.txt
 create mode 100644 arch/arm/boot/dts/axm5516-amarillo.dts
 create mode 100644 arch/arm/boot/dts/axm5516-cpus.dtsi
 create mode 100644 arch/arm/boot/dts/axm55xx.dtsi
 create mode 100644 arch/arm/configs/axm55xx_defconfig
 create mode 100644 arch/arm/mach-axxia/Kconfig
 create mode 100644 arch/arm/mach-axxia/Makefile
 create mode 100644 arch/arm/mach-axxia/Makefile.boot
 create mode 100644 arch/arm/mach-axxia/axxia.c
 create mode 100644 arch/arm/mach-axxia/axxia.h
 create mode 100644 arch/arm/mach-axxia/headsmp.S
 create mode 100644 arch/arm/mach-axxia/platsmp.c
 create mode 100644 drivers/clk/clk-axxia.c
 create mode 100644 drivers/power/reset/axxia-reset.c

-- 
1.8.3.2
