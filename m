From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 15 May 2015 20:29:13 +0200
Subject: [PATCH 0/2] 8250 UART driver for NXP LPC18xx family
Message-ID: <1431714555-7063-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a serial port driver for the 8250-
based UART found on LPC18xx/43xx devices. The UART is
16550A compatible with additional features like RS485
support, synchronous mode, IrDA, and DMA.

For now only basic UART and RS485 operation is supported.

The plan is add additional features like DMA support once
the PL080 DMA controller gets device tree bindings.

Joachim Eastwood (2):
  serial: 8250: add LPC18xx/43xx UART driver
  doc: dt: add documentation for nxp,lpc1850-uart

 .../bindings/serial/nxp,lpc1850-uart.txt           |  21 +++
 drivers/tty/serial/8250/8250_lpc18xx.c             | 204 +++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig                    |   8 +
 drivers/tty/serial/8250/Makefile                   |   1 +
 4 files changed, 234 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt
 create mode 100644 drivers/tty/serial/8250/8250_lpc18xx.c

-- 
1.8.0
