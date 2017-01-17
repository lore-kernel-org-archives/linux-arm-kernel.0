From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Tue, 17 Jan 2017 16:26:56 +0100
Subject: [PATCH v9 0/5] Add support for the STM32F4 I2C
Message-ID: <1484666821-20551-1-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the I2C controller embedded in STM32F4xx SoC.
It enables I2C transfer in interrupt mode with Standard-mode and Fast-mode bus
speed.

Changes since v8:
- Rework I2C Clock Control Register computation (Uwe)
- Save register accesses as often as possible (Uwe)
- Don't use mask before saving rx buffer (Uwe)
- Add more comments to explain hardware way of working (Uwe)
- Rename stm32f4_i2c_handle_rx_btf function by stm32f4_i2c_handle_rx_done (Uwe)
- Set/Clear Ack position bit during address match phase

M'boumba Cedric Madianga (5):
  dt-bindings: Document the STM32 I2C bindings
  i2c: Add STM32F4 I2C driver
  ARM: dts: stm32: Add I2C1 support for STM32F429 SoC
  ARM: dts: stm32: Add I2C1 support for STM32429 eval board
  ARM: configs: stm32: Add I2C support for STM32 defconfig

 .../devicetree/bindings/i2c/i2c-stm32.txt          |  33 +
 arch/arm/boot/dts/stm32429i-eval.dts               |   6 +
 arch/arm/boot/dts/stm32f429.dtsi                   |  23 +
 arch/arm/configs/stm32_defconfig                   |   3 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-stm32f4.c                   | 883 +++++++++++++++++++++
 7 files changed, 959 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-stm32.txt
 create mode 100644 drivers/i2c/busses/i2c-stm32f4.c

-- 
1.9.1
