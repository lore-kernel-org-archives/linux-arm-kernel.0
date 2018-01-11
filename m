From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 11 Jan 2018 21:44:23 +0200
Subject: [PATCH v2 0/4] gpio: driver for the RPi3 GPIO expander
Message-ID: <cover.1515698418.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Raspberry Pi 3 has a GPIO expander that controls, among others, the 
activity LED, and the camera connector GPIOs. The GPIO expander on an I2C bus 
that is not directly controlled from the ARM core. The VC4 firmware controls 
the I2C bus, and allows the ARM core to set/get GPIO settings over its mailbox 
interface.

This series adds support for the RPi3 expander.

The driver is ported from the downstream kernel at 
https://github.com/raspberrypi/linux/, branch rpi-4.9.y.

Changes in v2:

  * Driver renamed to gpio-raspberrypi-exp
  * Compatible string renamed to "raspberrypi,firmware-gpio"
  * Firmware error check
  * Smaller tweaks listed in individual patches

Baruch Siach (3):
  ARM: bcm2835: sync firmware properties with downstream
  dt-bindings: gpio: add raspberry pi GPIO expander binding
  ARM: dts: bcm2837-rpi-3-b: add GPIO expander

Dave Stevenson (1):
  gpio: raspberrypi-exp: Driver for RPi3 GPIO expander via mailbox
    service

 .../bindings/gpio/raspberrypi,firmware-gpio.txt    |  24 ++
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  10 +
 drivers/gpio/Kconfig                               |   9 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-raspberrypi-exp.c                | 258 +++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h         |  18 ++
 6 files changed, 320 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/raspberrypi,firmware-gpio.txt
 create mode 100644 drivers/gpio/gpio-raspberrypi-exp.c

-- 
2.15.1
