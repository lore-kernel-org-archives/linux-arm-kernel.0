From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 27 Sep 2018 13:39:57 +0200
Subject: [PATCH v3 0/7] Introduce STMFX I2C Multi-Function eXpander
Message-ID: <1538048404-9041-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for STMicroelectronics Multi-Function eXpander
(STMFX), used on some STM32 discovery and evaluation boards.

STMFX is an STM32L152 slave controller whose firmware embeds the following
features:
- I/O expander (16 GPIOs + 8 extra if the other features are not enabled),
- resistive touchscreen controller,
- IDD measurement.

I2C stuff and chip initialization is based on an MFD parent driver, which
registers a pinctrl MFD child.

---
Changes in v3:
- fix MFD interrupt bindings
- fix drivers/mfd/stmfx.c:103:8: warning: 'mask' may be used uninitialized
  in this function
Changes in v2:
- move to MFD parent driver for i2c stuff and chip initialization
- improve regmap configuration
- take advantage of the use of gpio-ranges


Amelie Delaunay (7):
  dt-bindings: mfd: Add ST Multi-Function eXpander (STMFX) core bindings
  mfd: Add ST Multi-Function eXpander (STMFX) core driver
  dt-bindings: pinctrl: document the STMFX pinctrl bindings
  pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver
  ARM: dts: stm32: add STMFX support on stm32746g-eval
  ARM: dts: stm32: add joystick support on stm32746g-eval
  ARM: dts: stm32: add orange and blue leds on stm32746g-eval

 Documentation/devicetree/bindings/mfd/stmfx.txt    |  28 +
 .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 116 +++
 arch/arm/boot/dts/stm32746g-eval.dts               |  66 ++
 drivers/mfd/Kconfig                                |  14 +
 drivers/mfd/Makefile                               |   2 +-
 drivers/mfd/stmfx.c                                | 626 ++++++++++++++++
 drivers/pinctrl/Kconfig                            |  12 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-stmfx.c                    | 821 +++++++++++++++++++++
 include/linux/mfd/stmfx.h                          |  27 +
 10 files changed, 1712 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
 create mode 100644 drivers/mfd/stmfx.c
 create mode 100644 drivers/pinctrl/pinctrl-stmfx.c
 create mode 100644 include/linux/mfd/stmfx.h

-- 
2.7.4
