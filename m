From: tim.kryger@linaro.org (Tim Kryger)
Date: Thu, 14 Nov 2013 13:02:11 -0800
Subject: [PATCH v2 0/5] Add-Broadcom-Kona-I2C-Support
Message-ID: <1384462936-7906-1-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the Kona I2C bus found on Broadcom mobile
SoCs like the bcm11351 (aka bcm281xx) and enables it on the bcm28155-ap
board.

It depends upon the following commit:
  http://lkml.indiana.edu/hypermail/linux/kernel/1311.1/03583.html

Tim Kryger (5):
  Documentation: dt: Add i2c-bcm-kona binding
  i2c: i2c-bcm-kona: Introduce Broadcom I2C Driver
  i2c: i2c-bcm-kona: Add support for high-speed mode
  ARM: dts: bcm281xx: Add i2c busses
  ARM: dts: bcm28155-ap: Enable all the i2c busses

 .../devicetree/bindings/i2c/i2c-bcm-kona.txt       |  35 +
 arch/arm/boot/dts/bcm11351.dtsi                    |  40 +
 arch/arm/boot/dts/bcm28155-ap.dts                  |  20 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-bcm-kona.c                  | 908 +++++++++++++++++++++
 6 files changed, 1014 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-bcm-kona.txt
 create mode 100644 drivers/i2c/busses/i2c-bcm-kona.c

-- 
1.8.0.1
