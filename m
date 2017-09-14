From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Thu, 14 Sep 2017 16:28:34 +0200
Subject: [PATCH v4 0/5] Add support for the STM32F7 I2C
Message-ID: <1505399319-14782-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the I2C controller embedded in STM32F7xx SoC.
It enables I2C transfer in interrupt mode with Standard-mode, Fast-mode and
Fast-mode+ bus speed.
---
 Version history:
     v4:
        * Fix max I2C Bus clock to 100%
        * Solve typo issue
        * Add retries value
    v3:
        * Move stm32f7_i2c_match above stm32f7_i2c_driver
        * of_device_get_match_data instead of of_match_device
        * Improve I2C Speed DT gathering
        * dev_err into dev_dbg for Arbitration loss
        * Remove useless space aligned

    v2:
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
 drivers/i2c/busses/i2c-stm32f7.c                   | 972 +++++++++++++++++++++
 8 files changed, 1066 insertions(+), 14 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-stm32.h
 create mode 100644 drivers/i2c/busses/i2c-stm32f7.c

-- 
2.7.4
