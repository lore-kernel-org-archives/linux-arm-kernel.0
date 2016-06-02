From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Thu,  2 Jun 2016 16:26:03 +0200
Subject: [PATCH v2 0/5] Add support for the STM32F4 I2C
Message-ID: <1464877568-21897-1-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the I2C controller embedded in STM32F4xx SoC.
It enables I2C transfer in interrupt mode with Standard-mode and Fast-mode bus
speed.

Changes since v1:
- use compatible st,stm32f4-i2c instead of st,i2c-stm32f4 (Rob)
- fix typo s/enmpty/empty (Maxime)
- use one function to handle TX fifo empty and byte xfer finished IT (Maxime)
- set duty cycle in timing struct in Fast mode
- Rework clock management (call prepare/unprepare at probe and remove, call
  clk_enable/clk_disable for each I2C transfer)

M'boumba Cedric Madianga (5):
  dt-bindings: Document the STM32 I2C bindings
  i2c: Add STM32F4 I2C driver
  ARM: dts: Add I2C1 support for STM32F429 SoC
  ARM: dts: Add I2C1 support for STM32429 eval board
  ARM: configs: Add I2C support for STM32 defconfig

 .../devicetree/bindings/i2c/i2c-stm32.txt          |  33 +
 arch/arm/boot/dts/stm32429i-eval.dts               |   6 +
 arch/arm/boot/dts/stm32f429.dtsi                   |  24 +
 arch/arm/configs/stm32_defconfig                   |   3 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-stm32f4.c                   | 867 +++++++++++++++++++++
 7 files changed, 944 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-stm32.txt
 create mode 100644 drivers/i2c/busses/i2c-stm32f4.c

-- 
1.9.1
