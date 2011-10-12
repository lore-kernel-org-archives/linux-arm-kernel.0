From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 12 Oct 2011 18:06:55 +0200
Subject: [PATCH v2 0/5] tty/serial: atmel_serial: Device Tree support
Message-ID: <1318435620-7481-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The goal of this patch series is to add device tree support to Atmel USART
driver: atmel_serial.
As this driver support RS485 mode, generic RS485 bindings have been added.

Some modifications are also included to ease the transition to parameter
settings comming from device tree.
The enumeration of ports is enhanced to be able to deal with several types
of port numbering: platform data, device tree or automatic.

Nicolas Ferre (5):
      tty/serial: RS485 bindings for device tree
      tty/serial: atmel_serial: change platform_data variable name
      tty/serial: atmel_serial: whitespace and braces modifications
      tty/serial: atmel_serial: auto-enumerate ports
      tty/serial: atmel_serial: add device tree support

 Documentation/devicetree/bindings/serial/rs485.txt |   31 +++++
 .../devicetree/bindings/tty/serial/atmel-usart.txt |   27 +++++
 Documentation/serial/serial-rs485.txt              |    5 +
 drivers/tty/serial/atmel_serial.c                  |  122 +++++++++++++++++---
 4 files changed, 170 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/rs485.txt
 create mode 100644 Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
