From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 30 May 2015 23:14:43 +0200
Subject: [PATCH v2 0/2] 8250 UART driver for NXP LPC18xx family
Message-ID: <1433020485-20994-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a serial port driver for the 8250-
based UART found on LPC18xx/43xx devices. The UART is
16550A compatible with additional features like RS485
support, synchronous mode, IrDA, and DMA.

Driver includes basic UART support, RS485 mode and
optional DMA support. Tested both DMA and non-DMA
mode on EA4357 Dev Kit successfully.

Changes since v1:
 - DMA support + doc update
 - Cleaned up probe function

DMA support for LPC18xx will be posted soonish.

Joachim Eastwood (2):
  serial: 8250: add LPC18xx/43xx UART driver
  doc: dt: add documentation for nxp,lpc1850-uart

 .../bindings/serial/nxp,lpc1850-uart.txt           |  28 +++
 drivers/tty/serial/8250/8250_lpc18xx.c             | 230 +++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig                    |   8 +
 drivers/tty/serial/8250/Makefile                   |   1 +
 4 files changed, 267 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt
 create mode 100644 drivers/tty/serial/8250/8250_lpc18xx.c

-- 
1.8.0
