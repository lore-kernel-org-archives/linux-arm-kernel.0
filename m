From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 12 Nov 2012 16:52:20 +0800
Subject: [PATCH 00/17] atmel SoC SPI controller with dmaengine and DT 
Message-ID: <1352710357-3265-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set of patches is to add dmaengine and DT support for atmel spi.
The work is based on Jean-Christophe, Nicolas and Richard's work.
I have tested it on at91sam9x5ek, at91sam9m10g45ek.

It is based on v3.7-rc5.

Best Regards,
Wenyou Yang.

Jean-Christophe PLAGNIOL-VILLARD (3):
  of: add dma-mask binding
  of_spi: add generic binding support to specify cs gpio
  spi/atmel_spi: add DT support

Nicolas Ferre (5):
  spi/atmel_spi: add physical base address
  spi/atmel_spi: call unmapping on transfers buffers
  spi/atmel_spi: status information passed through controller data
  spi/atmel_spi: add flag to controller data for lock operations
  spi/atmel_spi: add dmaengine support

Richard Genoud (6):
  spi/atmel_spi: Fix spi-atmel driver to adapt to slave_config changes
  spi/atmel_spi: correct 16 bits transfers using PIO
  spi/atmel_spi: correct 16 bits transfer with DMA
  ARM: at91: add clocks for spi DT entries
  ARM: dts: add spi nodes for atmel SoC
  ARM: dts: add spi nodes for atmel boards

Wenyou Yang (3):
  spi/atmel_spi: add version propety as the spi data
  spi/atmel_spi: add function to read the spi data from the dts
  mtd: m25p80: change the m25p80_read to reading page to page

 Documentation/devicetree/bindings/spi/spi-bus.txt  |    6 +
 .../devicetree/bindings/spi/spi_atmel.txt          |   27 +
 arch/arm/boot/dts/at91sam9260.dtsi                 |   34 +
 arch/arm/boot/dts/at91sam9263.dtsi                 |   34 +
 arch/arm/boot/dts/at91sam9263ek.dts                |    9 +
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |    9 +
 arch/arm/boot/dts/at91sam9g25ek.dts                |    9 +
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   34 +
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |    9 +
 arch/arm/boot/dts/at91sam9n12.dtsi                 |   34 +
 arch/arm/boot/dts/at91sam9n12ek.dts                |    9 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   34 +
 arch/arm/mach-at91/at91sam9260.c                   |    2 +
 arch/arm/mach-at91/at91sam9g45.c                   |    2 +
 arch/arm/mach-at91/at91sam9n12.c                   |    2 +
 arch/arm/mach-at91/at91sam9x5.c                    |    2 +
 drivers/mtd/devices/m25p80.c                       |   44 +-
 drivers/of/platform.c                              |   23 +-
 drivers/spi/spi-atmel.c                            |  728 ++++++++++++++++++--
 drivers/spi/spi.c                                  |   55 +-
 include/linux/spi/spi.h                            |    3 +
 21 files changed, 1045 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt

-- 
1.7.9.5
