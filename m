From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 3 Apr 2017 19:21:07 +0200
Subject: [GIT PULL] STM32 DT changes for v4.12 #1
Message-ID: <4673f77a-d9e8-d8e1-8a1c-54837daeeca4@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STM32 DT updates for v4.12:

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-dt-for-v4.12-1

for you to fetch changes up to 21b825e404f0bb1b09d2c67edc019a43eee291cd:

   dt-bindings: Document the STM32 USB OTG DWC2 core binding (2017-04-03 
10:28:25 +0200)

----------------------------------------------------------------
STM32 DT updates for v4.12, round 1

Highlights:
----------

  - ADD RTC support on STM32F746 MCU
  - Enable RTC on STM32F746 Eval board
  - Enable clocks on STM32F746 MCU
  - Enable DMA, pwm1 and pwm3 on STM32F429I Eval
  - Add support of STM32H743 MCU and his Eval board
  - Enable USB HS and FS on STM32F469 Disco board

----------------------------------------------------------------
Alexandre TORGUE (1):
       ARM: dts: stm32: Add STM32H743 MCU and STM32H743i-EVAL board

Amelie Delaunay (3):
       ARM: dts: stm32: set HSE_RTC clock frequency to 1 MHz on stm32f746
       ARM: dts: stm32: Add RTC support for STM32F746 MCU
       ARM: dts: stm32: enable RTC on stm32746g-eval

Bruno Herrera (4):
       ARM: dts: stm32: Add USB FS support for STM32F429 MCU
       ARM: dts: stm32: Enable USB FS on stm32f469-disco
       ARM: dts: stm32: Enable USB HS in FS mode (embedded phy) on 
stm32f429-disco
       dt-bindings: Document the STM32 USB OTG DWC2 core binding

Fabrice Gasnier (2):
       ARM: dts: stm32: Enable dma by default on stm32f4 adc
       ARM: dts: stm32: Enable pwm1 and pwm3 on stm32f429i-eval

Gabriel Fernandez (2):
       ARM: dts: stm32: Enable clocks for STM32F746 MCU
       dt-bindings: mfd: Add STM32F7 RCC numeric constants into DT 
include file

  Documentation/devicetree/bindings/usb/dwc2.txt |   4 +
  arch/arm/boot/dts/Makefile                     |   3 +-
  arch/arm/boot/dts/stm32429i-eval.dts           |  28 +++++
  arch/arm/boot/dts/stm32746g-eval.dts           |   4 +
  arch/arm/boot/dts/stm32f429-disco.dts          |  16 +++
  arch/arm/boot/dts/stm32f429.dtsi               |  37 ++++++
  arch/arm/boot/dts/stm32f469-disco.dts          |  16 +++
  arch/arm/boot/dts/stm32f746.dtsi               |  96 ++++++++++-----
  arch/arm/boot/dts/stm32h743-pinctrl.dtsi       | 156 
+++++++++++++++++++++++++
  arch/arm/boot/dts/stm32h743.dtsi               |  83 +++++++++++++
  arch/arm/boot/dts/stm32h743i-eval.dts          |  74 ++++++++++++
  include/dt-bindings/mfd/stm32f7-rcc.h          | 112 ++++++++++++++++++
  12 files changed, 601 insertions(+), 28 deletions(-)
  create mode 100644 arch/arm/boot/dts/stm32h743-pinctrl.dtsi
  create mode 100644 arch/arm/boot/dts/stm32h743.dtsi
  create mode 100644 arch/arm/boot/dts/stm32h743i-eval.dts
  create mode 100644 include/dt-bindings/mfd/stm32f7-rcc.h
