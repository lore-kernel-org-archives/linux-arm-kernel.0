From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 28 Jul 2015 12:25:48 +0200
Subject: [PATCH v2 0/3] ARM: at91: introducing Atmel sama5d2 SoC
Message-ID: <1438079151-29653-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a little series to introduce the new Atmel Cortex-A5 sama5d2 SoC.
The product is not yet announced so you cannot find the datasheet yet. But be
sure to find it when it's released at the usual location: atmel.com!

The support is basic for now but allows to boot the chip and use the sama5d2
Xplained board.

This series is dependent on other patches sent for clocks (PMC + generic
clocks), irqchip and Ethernet. Some of these patches are already in linux-next
and other are progressing as this series goes upstream and is finaly merged in
arm-soc.

More material is on its way to being published or already under review (like
the flexcom or QSPI for instance). Stay tunned for more fun!

Changes in v2:
- change the meaningless config HAVE_AT91_GENERATED to HAVE_AT91_GENERATED_CLK
- modify README file for clarity
- fix sdmmc clocks and memory range
- add flexcom and audio Class D amplifier peripheral clock definitions
- add qspi peripheral clock definitions
- add more generated clock definitions
- fix DMA definitions for crypto peripherals
- add spi, i2c and rtc nodes
- enable spi and i2c nodes
- enable sdmmc0
- move to stdout-path for console

Ludovic Desroches (1):
  ARM: at91/dt: add basic dtsi for sama5d2 SoC

Nicolas Ferre (2):
  ARM: at91/soc: add basic support for new sama5d2 SoC
  ARM: at91/dt: add minimal sama5d2 Xplained board

 Documentation/arm/Atmel/README                     |   5 +
 .../devicetree/bindings/arm/atmel-at91.txt         |   2 +
 arch/arm/Kconfig.debug                             |   6 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        | 145 +++
 arch/arm/boot/dts/sama5d2.dtsi                     | 985 +++++++++++++++++++++
 arch/arm/include/debug/at91.S                      |   5 +-
 arch/arm/mach-at91/Kconfig                         |  12 +
 arch/arm/mach-at91/sama5.c                         |   3 +
 arch/arm/mach-at91/soc.h                           |   3 +
 10 files changed, 1166 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/at91-sama5d2_xplained.dts
 create mode 100644 arch/arm/boot/dts/sama5d2.dtsi

-- 
2.1.3
