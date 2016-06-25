From: vw@iommu.org (Wan Zongshun)
Date: Sat, 25 Jun 2016 18:32:24 +0800
Subject: [PATCH 0/6] ARM: NUC900: Add NUC970 SoC support
Message-ID: <1466850744-21909-1-git-send-email-vw@iommu.org>
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

Wan Zongshun (6):
  ARM: NUC900: Add nuc970 machine support
  ARM: dts: nuc900: Add nuc970 dts files
  Clocksource: add nuc970 clocksource driver
  irqchip: add irqchip driver for nuc900
  clk: add Clock driver for nuc970
  nuc900: add nuc970 platform defconfig file

 .../devicetree/bindings/arm/nuvoton/nuc970.txt     |   30 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/nuc970-evb.dts                   |   20 +
 arch/arm/boot/dts/nuc970.dtsi                      |   93 ++
 arch/arm/configs/nuc970_defconfig                  | 1278 ++++++++++++++++++++
 arch/arm/mach-w90x900/Kconfig                      |   25 +
 arch/arm/mach-w90x900/Makefile                     |    3 +
 arch/arm/mach-w90x900/include/mach/irqs.h          |   69 ++
 .../mach-w90x900/include/mach/nuc970-regs-aic.h    |   53 +
 .../mach-w90x900/include/mach/nuc970-regs-gcr.h    |   56 +
 .../mach-w90x900/include/mach/nuc970-regs-timer.h  |   44 +
 arch/arm/mach-w90x900/mach-nuc970.c                |  144 +++
 drivers/clk/Makefile                               |    1 +
 drivers/clk/nuc900/Makefile                        |    6 +
 drivers/clk/nuc900/clk-apll.c                      |  168 +++
 drivers/clk/nuc900/clk-ccf.h                       |   53 +
 drivers/clk/nuc900/clk-nuc970.c                    |  920 ++++++++++++++
 drivers/clk/nuc900/clk-upll.c                      |   83 ++
 drivers/clocksource/Kconfig                        |    8 +
 drivers/clocksource/Makefile                       |    1 +
 drivers/clocksource/timer-nuc900.c                 |  207 ++++
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-nuc900.c                       |  104 ++
 include/dt-bindings/clock/nuc970-clock.h           |  233 ++++
 24 files changed, 3601 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuc970.txt
 create mode 100644 arch/arm/boot/dts/nuc970-evb.dts
 create mode 100644 arch/arm/boot/dts/nuc970.dtsi
 create mode 100644 arch/arm/configs/nuc970_defconfig
 create mode 100644 arch/arm/mach-w90x900/include/mach/nuc970-regs-aic.h
 create mode 100644 arch/arm/mach-w90x900/include/mach/nuc970-regs-gcr.h
 create mode 100644 arch/arm/mach-w90x900/include/mach/nuc970-regs-timer.h
 create mode 100644 arch/arm/mach-w90x900/mach-nuc970.c
 create mode 100644 drivers/clk/nuc900/Makefile
 create mode 100644 drivers/clk/nuc900/clk-apll.c
 create mode 100644 drivers/clk/nuc900/clk-ccf.h
 create mode 100644 drivers/clk/nuc900/clk-nuc970.c
 create mode 100644 drivers/clk/nuc900/clk-upll.c
 create mode 100644 drivers/clocksource/timer-nuc900.c
 create mode 100644 drivers/irqchip/irq-nuc900.c
 create mode 100644 include/dt-bindings/clock/nuc970-clock.h

-- 
2.7.4
