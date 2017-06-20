From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Tue, 20 Jun 2017 13:41:25 +0200
Subject: [PATCH v2 0/5] Add support for the STM32F7 I2C
Message-ID: <1497958890-5530-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the I2C controller embedded in STM32F7xx SoC.
It enables I2C transfer in interrupt mode with Standard-mode, Fast-mode and
Fast-mode+ bus speed.
---
Changes in V2
  * Implement an I2C timings computation algorithm instead of static
    values(bindings). Algorithm uses generic I2C SCL Falling/Rising
    bindings and System clock to compute its timings.
  * I2C Device Tree Update
---
Pierre-Yves MORDRET (5):
  dt-bindings: i2c-stm32: Document the STM32F7 I2C bindings
  i2c: i2c-stm32f4: use generic definition of speed enum
  i2c: i2c-stm32f7: add driver
  ARM: dts: stm32: Add I2C1 support for STM32F746 SoC
  ARM: dts: stm32: Add I2C1 support for STM32F746 eval board

 .../devicetree/bindings/i2c/i2c-stm32.txt          |  29 +-
 arch/arm/boot/dts/stm32746g-eval.dts               |   8 +
 arch/arm/boot/dts/stm32f746.dtsi                   |  22 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-stm32.h                     |  20 +
 drivers/i2c/busses/i2c-stm32f4.c                   |  18 +-
 drivers/i2c/busses/i2c-stm32f7.c                   | 968 +++++++++++++++++++++
 8 files changed, 1062 insertions(+), 14 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-stm32.h
 create mode 100644 drivers/i2c/busses/i2c-stm32f7.c

-- 
1.9.1
