From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Wed, 11 Apr 2018 11:47:00 +0200
Subject: [PATCH 0/5] Introduce STMFX I2C GPIO expander
Message-ID: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for STMicroelectronics Multi-Function eXpander
(STMFX) GPIO expander, used on some STM32 discovery and evaluation boards.

STMFX is an STM32L152 based I2C slave controller, whose firmware embeds an
I/O expansion feature, offering 24 GPIOs.

STMFX pinctrl/GPIO driver provides a GPIO interface supporting inputs and
outputs, and a pinctrl interface supporting push-pull and open-drain
configuration.
STMFX GPIO expander can also be used as interrupt controller.

Previous series [1], based on MFD and GPIO frameworks, is abandoned and
completely reworked.

[1] https://lkml.org/lkml/2018/2/8/300

Amelie Delaunay (5):
  dt-bindings: pinctrl: document the STMFX pinctrl bindings
  pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver
  ARM: dts: stm32: add STMFX pinctrl/gpio expander support on
    stm32746g-eval
  ARM: dts: stm32: add orange and blue leds on stm32746g-eval
  ARM: dts: stm32: add joystick support on stm32746g-eval

 .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 118 +++
 arch/arm/boot/dts/stm32746g-eval.dts               |  66 ++
 drivers/pinctrl/Kconfig                            |  13 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-stmfx.c                    | 985 +++++++++++++++++++++
 5 files changed, 1183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
 create mode 100644 drivers/pinctrl/pinctrl-stmfx.c

-- 
2.7.4
