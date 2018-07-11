From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Wed, 11 Jul 2018 15:16:35 +0200
Subject: [PATCH 0/3] add ISO7816 support
Message-ID: <20180711131638.12622-1-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set of patches adds support for the ISO7816 standard. The USART devices in
Microchip SoCs have an ISO7816 mode. It allows to let the USART managing
the CLK and I/O signals of a smart card.

Nicolas Ferre (3):
  tty/serial_core: add ISO7816 infrastructure
  tty/serial: atmel: add ISO7816 support
  tty/serial: atmel: manage shutdown in case of RS485 or ISO7816 mode

 drivers/tty/serial/atmel_serial.c | 179 +++++++++++++++++++++++++++++++++++---
 drivers/tty/serial/atmel_serial.h |   3 +-
 drivers/tty/serial/serial_core.c  |  49 +++++++++++
 include/linux/serial_core.h       |   3 +
 include/uapi/asm-generic/ioctls.h |   2 +
 include/uapi/linux/serial.h       |  17 ++++
 6 files changed, 241 insertions(+), 12 deletions(-)

-- 
2.12.2
