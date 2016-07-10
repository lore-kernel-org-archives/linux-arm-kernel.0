From: vw@iommu.org (Wan Zongshun)
Date: Sun, 10 Jul 2016 15:27:20 +0800
Subject: [PATCH v2 00/10] ARM: NUC900: Add NUC970 SoC support
Message-ID: <1468135649-19980-1-git-send-email-vw@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series added Nuvoton new SoC NUC970 development board
support, this nuc970 belongs to nuc900 series, but many features are
not compatible with old nuc900 SoCs like nuc910, nuc920.

Those patches are basing on old w90x900 codes, and are using standard
linux subsystem interface, such as dts, driver/clk, driver/clocksource
, driver/irqchip drivers.

The old w90x900 plat such as nuc910,nuc960 codes will also be changed
to new style according to nuc970 codes after those patches was accepted.

PATCH V2:
The V2 patches change some code style, re-archtect some drivers and add reset
and soc drivers, split some dts patches according to maillist's comments.

Wan Zongshun (10):
  ARM: NUC900: Add nuc970 machine support
  irqchip: add irqchip driver for nuc900
  Clocksource: add nuc970 clocksource driver
  clk: add Clock driver for nuc970
  power/reset: Add reset driver support for nuc900
  soc: Add SoC specific driver support for nuc900
  ARM: dts: Add clock header file into dt-bindings
  ARM: dts: nuc900: Add nuc970 dts files
  Documentation: devicetree: Add dts description for nuc900
  nuc900: add nuc970 platform defconfig file

 .../devicetree/bindings/arm/nuvoton/nuc970.txt     |  12 +
 .../bindings/clock/nuvoton,nuc970-clk.txt          |  13 +
 .../interrupt-controller/nuvoton,nuc900-aic.txt    |  15 +
 .../bindings/reset/nuvoton,nuc900-reset.txt        |  12 +
 .../devicetree/bindings/serial/nuc970-uart.txt     |  22 +
 .../bindings/soc/nuvoton/nuvoton,nuc900-soc.txt    |  12 +
 .../bindings/timer/nuvoton,nuc970-tmr.txt          |  20 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/nuc970-evb.dts                   |  34 +
 arch/arm/boot/dts/nuc970.dtsi                      |  88 ++
 arch/arm/configs/nuc970_defconfig                  |  76 ++
 arch/arm/mach-w90x900/Kconfig                      |  20 +
 arch/arm/mach-w90x900/Makefile                     |   3 +
 arch/arm/mach-w90x900/include/mach/irqs.h          |   5 +
 arch/arm/mach-w90x900/nuc900.c                     |  41 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/nuc900/Makefile                        |   6 +
 drivers/clk/nuc900/clk-apll.c                      | 168 ++++
 drivers/clk/nuc900/clk-ccf.h                       |  53 ++
 drivers/clk/nuc900/clk-nuc970.c                    | 925 +++++++++++++++++++++
 drivers/clk/nuc900/clk-upll.c                      |  83 ++
 drivers/clocksource/Kconfig                        |   8 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-nuc900.c                 | 305 +++++++
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-nuc900.c                       | 150 ++++
 drivers/power/reset/Kconfig                        |   7 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/nuc900-reset.c                 |  93 +++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/nuvoton/Kconfig                        |  10 +
 drivers/soc/nuvoton/Makefile                       |   1 +
 drivers/soc/nuvoton/soc-nuc900.c                   | 100 +++
 include/dt-bindings/clock/nuc970-clock.h           | 233 ++++++
 35 files changed, 2522 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuc970.txt
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,nuc970-clk.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nuvoton,nuc900-aic.txt
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,nuc900-reset.txt
 create mode 100644 Documentation/devicetree/bindings/serial/nuc970-uart.txt
 create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/nuvoton,nuc900-soc.txt
 create mode 100644 Documentation/devicetree/bindings/timer/nuvoton,nuc970-tmr.txt
 create mode 100644 arch/arm/boot/dts/nuc970-evb.dts
 create mode 100644 arch/arm/boot/dts/nuc970.dtsi
 create mode 100644 arch/arm/configs/nuc970_defconfig
 create mode 100644 arch/arm/mach-w90x900/nuc900.c
 create mode 100644 drivers/clk/nuc900/Makefile
 create mode 100644 drivers/clk/nuc900/clk-apll.c
 create mode 100644 drivers/clk/nuc900/clk-ccf.h
 create mode 100644 drivers/clk/nuc900/clk-nuc970.c
 create mode 100644 drivers/clk/nuc900/clk-upll.c
 create mode 100644 drivers/clocksource/timer-nuc900.c
 create mode 100644 drivers/irqchip/irq-nuc900.c
 create mode 100644 drivers/power/reset/nuc900-reset.c
 create mode 100644 drivers/soc/nuvoton/Kconfig
 create mode 100644 drivers/soc/nuvoton/Makefile
 create mode 100644 drivers/soc/nuvoton/soc-nuc900.c
 create mode 100644 include/dt-bindings/clock/nuc970-clock.h

-- 
2.7.4
