From: radu.pirea@microchip.com (Radu Pirea)
Date: Fri, 13 Apr 2018 19:11:14 +0300
Subject: [PATCH 0/3] Driver for AT91 USART in SPI mode
Message-ID: <20180413161117.20274-1-radu.pirea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I wrote this driver for USART IP that is found in AT91 and SAMA5 SoCs. The
IP has an internal chip select, but is not used because is deasserted and
asserted after every byte sent over the wires. Gpio chip selects are used
instead of internal one. The driver works with actual USART nodes from
device tree of boards, but compatible must be changed, SCK pin muxed and
cs-gpio, size-cells and address-cells must be added. Of course, at the end
of the wires must be an SPI slave linked, not a serial console. :)

I tested the driver on sama5d4-xplained and sama5d3-xplained and works
without issues.

Radu Pirea (3):
  MAINTAINERS: add usart spi driver
  dt-bindings: add binding for at91-usart in spi mode
  spi: at91-usart: add driver for at91-usart as spi

 .../bindings/spi/microchip,at91-usart-spi.txt |  24 +
 MAINTAINERS                                   |   7 +
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-at91-usart.c                  | 545 ++++++++++++++++++
 5 files changed, 585 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
 create mode 100644 drivers/spi/spi-at91-usart.c

-- 
2.17.0
