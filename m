From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 25 Apr 2014 16:52:36 +0200
Subject: [PATCH 0/5] tty/serial: Add helpers to use GPIOs to control modem
 lines and implement atmel_serial.c
Message-ID: <1398437561-4289-1-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is a leftover of http://www.spinics.net/lists/arm-kernel/msg314242.html
that missed 3.15 because it caused merge conflicts.

The 1st patch may be applied as a fix for 3.15-rc, since it correct a
device tree binding documentation example.

Greg, for you to decide if it's worth it or not !

It's based on v3.15-rc2.

Richard Genoud (5):
  tty/serial: atmel_serial: Fix device tree documetation
  ARM: at91: gpio: implement get_direction
  tty/serial: Add GPIOLIB helpers for controlling modem lines
  tty/serial: at91: use mctrl_gpio helpers
  tty/serial: at91: add interrupts for modem control lines

 .../devicetree/bindings/serial/atmel-usart.txt     |  12 +-
 Documentation/serial/driver                        |  25 +++
 arch/arm/mach-at91/at91rm9200_devices.c            |  16 +-
 arch/arm/mach-at91/at91sam9260_devices.c           |   7 -
 arch/arm/mach-at91/at91sam9261_devices.c           |   4 -
 arch/arm/mach-at91/at91sam9263_devices.c           |   4 -
 arch/arm/mach-at91/at91sam9g45_devices.c           |   5 -
 arch/arm/mach-at91/at91sam9rl_devices.c            |   5 -
 arch/arm/mach-at91/gpio.c                          |  13 ++
 drivers/tty/serial/Kconfig                         |   4 +
 drivers/tty/serial/Makefile                        |   3 +
 drivers/tty/serial/atmel_serial.c                  | 230 +++++++++++++++++----
 drivers/tty/serial/serial_mctrl_gpio.c             | 143 +++++++++++++
 drivers/tty/serial/serial_mctrl_gpio.h             | 110 ++++++++++
 include/linux/platform_data/atmel.h                |   1 -
 15 files changed, 509 insertions(+), 73 deletions(-)
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.c
 create mode 100644 drivers/tty/serial/serial_mctrl_gpio.h

-- 
1.8.5.5
