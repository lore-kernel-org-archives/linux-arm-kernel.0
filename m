From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu, 12 May 2016 14:35:34 +0000
Subject: [PATCH 0/4] bcm2835: add thermal driver
Message-ID: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add thermal driver for the bcm2835 SOC.

Right now this driver does not set up the thermal device
itself, but relies on the fact that the firmware is setting
the device up correctly.

Also it is currently only reading from the register-set.

The driver also exposes the registers via debugfs.

Martin Sperl (4):
  dt: bindings: add thermal device driver for bcm2835
  thermal: bcm2835: add thermal driver for bcm2835 soc
  ARM: bcm2835: add thermal node to device-tree of bcm283x
  ARM: bcm2835: add thermal driver to default_config

 .../bindings/thermal/bcm2835-thermal.txt           |  16 ++
 arch/arm/boot/dts/bcm283x.dtsi                     |   6 +
 arch/arm/configs/bcm2835_defconfig                 |   2 +
 drivers/thermal/Kconfig                            |   5 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/bcm/Kconfig                        |   4 +
 drivers/thermal/bcm/Makefile                       |   1 +
 drivers/thermal/bcm/bcm2835_thermal.c              | 205 +++++++++++++++++++++
 8 files changed, 240 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/bcm2835-thermal.txt
 create mode 100644 drivers/thermal/bcm/Kconfig
 create mode 100644 drivers/thermal/bcm/Makefile
 create mode 100644 drivers/thermal/bcm/bcm2835_thermal.c

--
2.1.4
