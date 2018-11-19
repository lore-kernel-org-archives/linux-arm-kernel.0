From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 19 Nov 2018 22:39:23 +0530
Subject: [PATCH 00/16] Add initial RDA8810PL SoC and Orange Pi boards support
Message-ID: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset adds initial RDA8810PL SoC and Orange Pi boards (2G IoT and
i96) support. RDA8810PL is an ARM Cortex A5 based SoC with Vivante's GC860
GPU. The SoC has been added as a new ARM sub architecture with myself
and Andreas as the maintainers.

More information about the boards can be found in below links:

1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/

This patchset is based on the initial revision sent out by Andreas long
back (http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/515951.html).

I have extended his patchset with proper irqchip and UART drivers. Now,
boards can boot into initramfs with console at UART2.

Thanks,
Mani

Andreas F?rber (4):
  dt-bindings: Add RDA Micro vendor prefix
  dt-bindings: arm: Document RDA8810PL and reference boards
  ARM: Prepare RDA8810PL SoC
  dt-bindings: serial: Document RDA Micro UART

Manivannan Sadhasivam (12):
  arm: dts: Add devicetree for RDA8810PL SoC
  arm: dts: Add devicetree for OrangePi 2G IoT board
  arm: dts: Add devicetree for OrangePi i96 board
  dt-bindings: interrupt-controller: Document RDA8810PL intc
  arm: dts: rda8810pl: Add interrupt controller support
  irqchip: Add RDA8810PL interrupt driver
  dt-bindings: timer: Document RDA8810PL SoC timer
  arm: dts: rda8810pl: Add timer support
  clocksource: Add clock driver for RDA8810PL SoC
  arm: dts: rda8810pl: Add interrupt support for UART
  tty: serial: Add RDA8810PL UART driver
  MAINTAINERS: Add entry for RDA Micro SoC architecture

 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/devicetree/bindings/arm/rda.txt |  17 +
 .../interrupt-controller/rda,8810pl-intc.txt  |  61 ++
 .../bindings/serial/rda,8810pl-uart.txt       |  15 +
 .../bindings/timer/rda,8810pl-timer.txt       |  21 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 MAINTAINERS                                   |  14 +
 arch/arm/Kconfig                              |   2 +
 arch/arm/Makefile                             |   1 +
 arch/arm/boot/dts/Makefile                    |   3 +
 .../boot/dts/rda8810pl-orangepi-2g-iot.dts    |  35 +
 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts  |  35 +
 arch/arm/boot/dts/rda8810pl.dtsi              | 116 +++
 arch/arm/mach-rda/Kconfig                     |   9 +
 arch/arm/mach-rda/Makefile                    |   1 +
 drivers/clocksource/Kconfig                   |   7 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-rda.c               | 187 ++++
 drivers/irqchip/Kconfig                       |   4 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-rda-intc.c                | 116 +++
 drivers/tty/serial/Kconfig                    |  19 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/rda-uart.c                 | 831 ++++++++++++++++++
 include/uapi/linux/serial_core.h              |   3 +
 25 files changed, 1507 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rda.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
 create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
 create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts
 create mode 100644 arch/arm/boot/dts/rda8810pl.dtsi
 create mode 100644 arch/arm/mach-rda/Kconfig
 create mode 100644 arch/arm/mach-rda/Makefile
 create mode 100644 drivers/clocksource/timer-rda.c
 create mode 100644 drivers/irqchip/irq-rda-intc.c
 create mode 100644 drivers/tty/serial/rda-uart.c

-- 
2.17.1
