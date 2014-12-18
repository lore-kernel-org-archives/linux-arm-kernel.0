From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 18 Dec 2014 21:45:22 +0200
Subject: [PATCH 0/3] UART driver for Conexat Digicolor SoCs
Message-ID: <cover.1418930377.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches adds a driver for the peripheral known as USART of the
Conexant CX92755 SoC. The CX92755 is one an ARM based SoC series known as
Digicolor. USART apparently stands for Universal Synchronous/Asynchronous
Receiver/Transmitter. Besides plain UART, the USART can also do SPI and
I2S. Here we only add a UART driver, others may follow later.

CX92755 is based on Cortex-A8. I plan to post ARM basic platform support code
(along with clocksource and interrupt controller drivers) in the coming few
days.

Baruch Siach (3):
  devicetree: bindings: add Conexant vendor prefix
  serial: driver for Conexant Digicolor USART
  serial: add device tree binding documentation for Conexant USART

 .../devicetree/bindings/serial/digicolor-usart.txt |  27 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/tty/serial/Kconfig                         |  15 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/digicolor-usart.c               | 563 +++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 6 files changed, 610 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/digicolor-usart.txt
 create mode 100644 drivers/tty/serial/digicolor-usart.c

-- 
2.1.3
