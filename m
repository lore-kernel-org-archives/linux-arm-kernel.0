From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 14 Oct 2015 22:07:20 +0200
Subject: [PATCH 0/7] Add STM32 pinctrl/GPIO driver
Message-ID: <1444853247-31114-1-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus, all,

As you suggested during the submission of the STM32 machine support,
I reworked the STM32 pinctrl driver to use the standardized pin config
bindings.

The STM32 family has 16 pins per GPIO bank, and the number of bank varies
depending on the model.

Pins can be multiplexed either in GPIO mode, alternate function (up to 15
functions per pin) or analog (for ADC/DAC).

Kind regards,
Maxime

Maxime Coquelin (7):
  ARM: Kconfig: Introduce MACH_STM32F429 flag
  includes: dt-bindings: Add STM32F429 pinctrl DT bindings
  Documentation: dt-bindings: Document STM32 pinctrl driver DT bindings
  pinctrl: Add support STM32 MCUs
  ARM: mach-stm32: Select pinctrl
  ARM: dts: Add pinctrl node to STM32F429
  ARM: dts: Add USART1 pin config to STM32F429 boards

 .../bindings/pinctrl/st,stm32-pinctrl.txt          |  113 ++
 arch/arm/Kconfig                                   |    6 +
 arch/arm/boot/dts/stm32429i-eval.dts               |    2 +
 arch/arm/boot/dts/stm32f429-disco.dts              |    2 +
 arch/arm/boot/dts/stm32f429.dtsi                   |  110 ++
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    4 +-
 drivers/pinctrl/stm32/Kconfig                      |   16 +
 drivers/pinctrl/stm32/Makefile                     |    5 +
 drivers/pinctrl/stm32/pinctrl-stm32.c              |  856 +++++++++++
 drivers/pinctrl/stm32/pinctrl-stm32.h              |   43 +
 drivers/pinctrl/stm32/pinctrl-stm32f429.c          | 1598 ++++++++++++++++++++
 include/dt-bindings/pinctrl/pinctrl-stm32.h        |   12 +
 include/dt-bindings/pinctrl/stm32f429-pinfunc.h    | 1241 +++++++++++++++
 14 files changed, 4008 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
 create mode 100644 drivers/pinctrl/stm32/Kconfig
 create mode 100644 drivers/pinctrl/stm32/Makefile
 create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32.c
 create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32.h
 create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32f429.c
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-stm32.h
 create mode 100644 include/dt-bindings/pinctrl/stm32f429-pinfunc.h

-- 
1.9.1
