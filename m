From: radu.pirea@microchip.com (Radu Pirea)
Date: Fri, 4 May 2018 18:47:08 +0300
Subject: [PATCH v2 0/6] Driver for at91 usart in spi mode
Message-ID: <20180504154714.5109-1-radu.pirea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the second version of driver. I added a mfd driver which by
default probes atmel_serial driver and if in dt is specified to probe
the spi driver, then the spi-at91-usart driver will be probed. The
compatible for atmel_serial is now the compatible for at91-usart mfd
driver and compatilbe for atmel_serial driver was changed in order to
keep the bindings for serial as they are.

Changes in v1:
- added spi-at91-usart driver

Changes in v2:
- added at91-usart mfd driver
- modified spi-at91-usart driver to work as mfd driver child
- modified atmel_serial driver to work as mfd driver child

Radu Pirea (6):
  MAINTAINERS: add at91 usart mfd driver
  mfd: at91-usart: added mfd driver for usart
  MAINTAINERS: add at91 usart spi driver
  dt-bindings: add binding for at91-usart in spi mode
  spi: at91-usart: add driver for at91-usart as spi
  tty/serial: atmel: changed the driver to work under at91-usart mfd

 .../bindings/spi/microchip,at91-usart-spi.txt |  28 +
 MAINTAINERS                                   |  14 +
 drivers/mfd/Kconfig                           |  10 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/at91-usart.c                      |  81 +++
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-at91-usart.c                  | 545 ++++++++++++++++++
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/atmel_serial.c             |  29 +-
 include/dt-bindings/mfd/at91-usart.h          |  17 +
 11 files changed, 722 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
 create mode 100644 drivers/mfd/at91-usart.c
 create mode 100644 drivers/spi/spi-at91-usart.c
 create mode 100644 include/dt-bindings/mfd/at91-usart.h

-- 
2.17.0
