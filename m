From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue,  8 Dec 2015 13:45:02 +0100
Subject: [PATCH v3 0/9] Add STM32 pinctrl/GPIO driver
Message-ID: <1449578711-6141-1-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus, all,

This is the second round of STM32 pinctrl series, which improves DT
bindings declaration and documentation, and also fixes some commit fixup
issues. The series also contains two more patches, adding GPIO LEDs
support as a user of this driver.

The STM32 family has 16 pins per GPIO bank, and the number of bank varies
depending on the model.

Pins can be multiplexed either in GPIO mode, alternate function (up to 15
functions per pin) or analog (for ADC/DAC).

Changes since v2:
-----------------
 - Rebase on v4.4-rc1
 - Declare leds also for Eval board
 - Set green led as heartbeat
 - Collect some acks

Changes since v1:
-----------------
 - Add GPIO LEDs support in DT and defconfig
 - Changes pinmux DT bindings from macros to raw values (Daniel)
 - Improve DT bindings documentation (Daniel)
 - Fix some commit fixup and rebase issues.

Kind regards,
Maxime

Maxime Coquelin (9):
  ARM: Kconfig: Introduce MACH_STM32F429 flag
  Documentation: dt-bindings: Document STM32 pinctrl driver DT bindings
  includes: dt-bindings: Add STM32F429 pinctrl DT bindings
  pinctrl: Add STM32 MCUs support
  ARM: mach-stm32: Select pinctrl
  ARM: dts: Add pinctrl node to STM32F429
  ARM: dts: Add USART1 pin config to STM32F429 boards
  ARM: dts: Add leds support to STM32F429 boards
  ARM: config: Enable GPIO Led driver in stm32_defconfig

 .../bindings/pinctrl/st,stm32-pinctrl.txt          |  126 ++
 arch/arm/Kconfig                                   |    6 +
 arch/arm/boot/dts/stm32429i-eval.dts               |   19 +
 arch/arm/boot/dts/stm32f429-disco.dts              |   13 +
 arch/arm/boot/dts/stm32f429.dtsi                   |  110 ++
 arch/arm/configs/stm32_defconfig                   |    1 +
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/stm32/Kconfig                      |   16 +
 drivers/pinctrl/stm32/Makefile                     |    5 +
 drivers/pinctrl/stm32/pinctrl-stm32.c              |  856 +++++++++++
 drivers/pinctrl/stm32/pinctrl-stm32.h              |   43 +
 drivers/pinctrl/stm32/pinctrl-stm32f429.c          | 1598 ++++++++++++++++++++
 include/dt-bindings/pinctrl/pinctrl-stm32.h        |   12 +
 include/dt-bindings/pinctrl/stm32f429-pinfunc.h    | 1241 +++++++++++++++
 15 files changed, 4048 insertions(+)
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
