From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 26 Sep 2012 14:50:55 +0800
Subject: [PATCH 0/6] atmel SoC SPI controller with DT
Message-ID: <1348642261-27554-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I merged the works from Nicolas, Richard, Jean-Christophe's patchset
for atmel SPI controller.

It's based on v3.6-rc7.

Best Regards,
Wenyou Yang

Wenyou Yang (6):
  of_spi: add generic binding support to specify cs gpio
  spi: atmel: add dmaengine and dt support
  ARM: at91: add clocks for spi DT entries
  ARM: dts: add spi nodes for atmel SoCs
  ARM: dts: add spi nodes for atmel boards
  spi: atmel: add dt property for DMA configuration for sam9x5 and
    sam9n12

 Documentation/devicetree/bindings/spi/spi-bus.txt  |    6 +
 .../devicetree/bindings/spi/spi_atmel.txt          |   29 +
 arch/arm/boot/dts/at91sam9260.dtsi                 |   34 +
 arch/arm/boot/dts/at91sam9263.dtsi                 |   34 +
 arch/arm/boot/dts/at91sam9263ek.dts                |   10 +
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |   10 +
 arch/arm/boot/dts/at91sam9g25ek.dts                |   10 +
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   34 +
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |   10 +
 arch/arm/boot/dts/at91sam9n12.dtsi                 |   36 +
 arch/arm/boot/dts/at91sam9n12ek.dts                |   10 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   38 +
 arch/arm/mach-at91/at91sam9260.c                   |    2 +
 arch/arm/mach-at91/at91sam9g45.c                   |    2 +
 arch/arm/mach-at91/at91sam9n12.c                   |    2 +
 arch/arm/mach-at91/at91sam9x5.c                    |    3 +
 drivers/spi/spi-atmel.c                            |  792 ++++++++++++++++++--
 drivers/spi/spi.c                                  |   55 +-
 include/linux/spi/spi.h                            |    3 +
 19 files changed, 1045 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt

-- 
1.7.9.5
