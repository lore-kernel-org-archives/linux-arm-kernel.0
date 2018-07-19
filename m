From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 19 Jul 2018 10:47:35 +0200
Subject: [PATCH v2 0/2] add ISO7816 support
Message-ID: <20180719084737.1490-1-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds support for the ISO7816 standard. The USART devices in
Microchip SoCs have an ISO7816 mode. It allows to let the USART managing
the CLK and I/O signals of a smart card.

Changes:
- v2
  - uart_get_iso7816_config: check there is an iso7816_config function
  - use IOCTL macros to generate the IOCTL number
  - check that reserved field is not used
  - remove debug logs
  - check that the iso7816_config is right before doing any action
  - change the error from nack and max iteration status to a debug message
  - remove patch 3 as it concerns both rs485 and iso7816 to think more
  about the need of adding a lock or not

Nicolas Ferre (2):
  tty/serial_core: add ISO7816 infrastructure
  tty/serial: atmel: add ISO7816 support

 arch/alpha/include/uapi/asm/ioctls.h   |   2 +
 arch/mips/include/uapi/asm/ioctls.h    |   2 +
 arch/powerpc/include/uapi/asm/ioctls.h |   2 +
 arch/sh/include/uapi/asm/ioctls.h      |   2 +
 arch/sparc/include/uapi/asm/ioctls.h   |   2 +
 arch/xtensa/include/uapi/asm/ioctls.h  |   2 +
 drivers/tty/serial/atmel_serial.c      | 170 +++++++++++++++++++++++++++++++--
 drivers/tty/serial/atmel_serial.h      |   3 +-
 drivers/tty/serial/serial_core.c       |  60 ++++++++++++
 include/linux/serial_core.h            |   3 +
 include/uapi/asm-generic/ioctls.h      |   2 +
 include/uapi/linux/serial.h            |  17 ++++
 12 files changed, 256 insertions(+), 11 deletions(-)

-- 
2.12.2
