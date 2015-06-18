From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Jun 2015 15:18:27 +0200
Subject: [PATCH 0/3] introducing Atmel sama5d2 SoC
Message-ID: <cover.1434632966.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a little series to introduce the new Atmel Cortex-A5 sama5d2 SoC.
The product is not yet announced so you cannot find the datasheet yet. But be
sure to find it when it's released at the usual location: atmel.com!

The support is basic for now but allows to boot the chip and use the sama5d2
Xplained board.

This series is dependent on other patches sent for clocks (PMC + generic
clocks), irqchip and Ethernet. These patches will hopefuly progress as this
series goes upstream and is finaly merged in arm-soc.

More material is on its way to being published or already under review (like
the flexcom for instance). Stay tunned for more fun!

Ludovic Desroches (1):
  ARM: at91/dt: add basic dtsi for sama5d2 SoC

Nicolas Ferre (2):
  ARM: at91/soc: add basic support for new sama5d2 SoC
  ARM: at91/dt: add minimal sama5d2 Xplained board

 Documentation/arm/Atmel/README                     |   6 +
 .../devicetree/bindings/arm/atmel-at91.txt         |   2 +
 arch/arm/Kconfig.debug                             |   6 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        | 113 +++
 arch/arm/boot/dts/sama5d2.dtsi                     | 843 +++++++++++++++++++++
 arch/arm/include/debug/at91.S                      |   5 +-
 arch/arm/mach-at91/Kconfig                         |  12 +
 arch/arm/mach-at91/sama5.c                         |   3 +
 arch/arm/mach-at91/soc.h                           |   3 +
 10 files changed, 993 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/at91-sama5d2_xplained.dts
 create mode 100644 arch/arm/boot/dts/sama5d2.dtsi

-- 
2.1.3
