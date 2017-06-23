From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 23 Jun 2017 11:49:36 +0200
Subject: [PATCH v2 0/9] Add and make use of a common rs485 device tree parsing
 function
Message-ID: <20170623094945.31908-1-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this is v2 of a series that targets to consolidate parsing the rs485 specific
dt properties in a single place.

The main change since (implicit) v1 sent with Message-Id:
20170621102130.21024-1-u.kleine-koenig at pengutronix.de is that
rs485-rts-delay is now optional.

Sascha Hauer (6):
  serial: Add common rs485 device tree parsing function
  serial: atmel: Use common rs485 device tree parsing function
  serial: fsl_lpuart: Use common rs485 device tree parsing function
  serial: omap-serial: Use common rs485 device tree parsing function
  serial: imx: default to half duplex rs485
  serial: imx: Use common rs485 device tree parsing function

Uwe Kleine-K?nig (3):
  serial: fsl_lpuart: clear unsupported options in .rs485_config()
  dt-bindings: serial/rs485: make rs485-rts-delay optional
  of: document rs485 bindings for Atmel USART, Freescale UARTs and OMAP
    UART

 .../devicetree/bindings/serial/atmel-usart.txt     |  1 +
 .../devicetree/bindings/serial/fsl-imx-uart.txt    |  1 +
 .../devicetree/bindings/serial/fsl-lpuart.txt      |  1 +
 .../devicetree/bindings/serial/omap_serial.txt     |  1 +
 Documentation/devicetree/bindings/serial/rs485.txt |  5 +--
 drivers/tty/serial/Kconfig                         |  4 ++
 drivers/tty/serial/Makefile                        |  2 +
 drivers/tty/serial/atmel_serial.c                  | 17 +-------
 drivers/tty/serial/fsl_lpuart.c                    | 29 ++++++++++---
 drivers/tty/serial/imx.c                           |  5 ++-
 drivers/tty/serial/of.c                            | 47 ++++++++++++++++++++++
 drivers/tty/serial/omap-serial.c                   | 12 +-----
 include/linux/serial_core.h                        | 13 ++++++
 13 files changed, 100 insertions(+), 38 deletions(-)
 create mode 100644 drivers/tty/serial/of.c

-- 
2.11.0
