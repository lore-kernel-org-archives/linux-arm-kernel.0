From: b.galvani@gmail.com (Beniamino Galvani)
Date: Thu, 13 Nov 2014 20:32:00 +0100
Subject: [PATCH v3 0/3]  i2c: add driver for Amlogic Meson I2C controller
Message-ID: <1415907123-4318-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patchset adds a driver for the I2C controller available in
Amlogic Meson SoCs. It has been tested on a Meson8 based board with
the following devices:
 - Ricoh RN5T618 PMIC
 - NXP PCF8564 RTC

Changes since v2:
 - fixed token generation for split reads
 - simplified meson_i2c_prepare_xfer()
 - added DTS patch

Changes since v1:
 - factored common code for token list setup

Beniamino Galvani (3):
  i2c: meson: add device tree bindings documentation
  i2c: add support for Amlogic Meson I2C controller
  ARM: dts: meson: add I2C controller nodes

 .../devicetree/bindings/i2c/i2c-meson.txt          |  24 +
 arch/arm/boot/dts/meson.dtsi                       |  30 ++
 drivers/i2c/busses/Kconfig                         |   7 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-meson.c                     | 492 +++++++++++++++++++++
 5 files changed, 554 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-meson.txt
 create mode 100644 drivers/i2c/busses/i2c-meson.c

-- 
1.9.1
