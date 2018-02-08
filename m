From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 8 Feb 2018 15:27:31 +0100
Subject: [PATCH 0/6] Introduce STMicroelectronics MultiFunction eXpander
Message-ID: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for STMicroelectronics MultiFunction eXpander
(ST MFX), used on some STM32 discovery and evaluation boards.

ST MFX is an STM32L152 slave controller whose firmware embeds the following
features:
- I/O expander (16 GPIOs + 8 extra if the other features are not enabled),
- resistive touchscreen controller,
- IDD measurement.
Using an I2C bus, the main MCU can control the MFX. MFX internal/external
events are sent to the main MCU by the MFX_IRQ_OUT_PIN.
  
Amelie Delaunay (6):
  dt-bindings: mfd: Add ST Multi-Function eXpander driver
  mfd: Add ST Multi-Function eXpander core driver
  gpio: Add GPIO support for the ST Multi-Function eXpander
  ARM: dts: stm32: add MFX support on I2C1 on stm32746g-eval
  ARM: dts: stm32: add joystick support on stm32746g-eval
  ARM: configs: stm32: enable ST MFX and its GPIO expander feature

 Documentation/devicetree/bindings/mfd/st-mfx.txt |  51 ++
 arch/arm/boot/dts/stm32746g-eval.dts             |  48 ++
 arch/arm/configs/stm32_defconfig                 |   2 +
 drivers/gpio/Kconfig                             |  10 +
 drivers/gpio/Makefile                            |   1 +
 drivers/gpio/gpio-st-mfx.c                       | 589 +++++++++++++++++++++++
 drivers/mfd/Kconfig                              |  15 +
 drivers/mfd/Makefile                             |   1 +
 drivers/mfd/st-mfx.c                             | 526 ++++++++++++++++++++
 include/dt-bindings/gpio/st-mfx-gpio.h           |  24 +
 include/linux/mfd/st-mfx.h                       | 116 +++++
 11 files changed, 1383 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/st-mfx.txt
 create mode 100644 drivers/gpio/gpio-st-mfx.c
 create mode 100644 drivers/mfd/st-mfx.c
 create mode 100644 include/dt-bindings/gpio/st-mfx-gpio.h
 create mode 100644 include/linux/mfd/st-mfx.h

-- 
2.7.4
