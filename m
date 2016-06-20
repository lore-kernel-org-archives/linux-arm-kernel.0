From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Mon, 20 Jun 2016 18:20:04 +0200
Subject: [PATCH v3 0/5] Add support for the STM32F4 I2C
Message-ID: <1466439609-1814-1-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the I2C controller embedded in STM32F4xx SoC.
It enables I2C transfer in interrupt mode with Standard-mode and Fast-mode bus
speed.

Changes since v2:
- Group I2C pins definitions in the device tree (Maxime)
- Suffix I2C phandle with part number (Maxime)
- Remov busy variable as not used (Rajeev)
- Rename STM32F4_I2C_TRISE_TRISE macro (Rajeev)
- Remove magic number during rise time computation (Rajeev)
- Simplify speed mode function computation

M'boumba Cedric Madianga (5):
  dt-bindings: Document the STM32 I2C bindings
  i2c: Add STM32F4 I2C driver
  ARM: dts: Add I2C1 support for STM32F429 SoC
  ARM: dts: Add I2C1 support for STM32429 eval board
  ARM: configs: Add I2C support for STM32 defconfig

 .../devicetree/bindings/i2c/i2c-stm32.txt          |  33 +
 arch/arm/boot/dts/stm32429i-eval.dts               |   6 +
 arch/arm/boot/dts/stm32f429.dtsi                   |  22 +
 arch/arm/configs/stm32_defconfig                   |   3 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-stm32f4.c                   | 863 +++++++++++++++++++++
 7 files changed, 938 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-stm32.txt
 create mode 100644 drivers/i2c/busses/i2c-stm32f4.c

-- 
1.9.1
