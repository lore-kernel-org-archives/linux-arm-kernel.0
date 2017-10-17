From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 17 Oct 2017 12:21:47 +0200
Subject: [GIT PULL] STM32 DT changes for v4.15 #1
Message-ID: <9a7b3184-0bc0-3f81-78ef-057fa4541530@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STM32 DT updates for v4.15. This 
pull request is based on "stm32-dt-fixes-for-v4.14" tag.

The following changes since commit 2aaae13a9db7897a007c5d7bb46cacfb37dffacd:

   ARM: dts: stm32: use right pinctrl compatible for stm32f469 
(2017-10-04 15:34:48 +0200)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-dt-for-v4.15-1

for you to fetch changes up to 4bd93eb39d98e38a260abe955e20636f97b96aba:

   ARM: dts: stm32: Add MDMA support for STM32H743 SoC (2017-10-16 
18:22:17 +0200)

----------------------------------------------------------------
STM32 DT updates for v4.15, round 1

Highlights:
----------
  -Add I2C1 support on STM32F746 SoC
  -Enable I2C1 on STM32F746 eval board
  -Add Timers support on STM32F746 SoC
  -Add USB HS and FS supports on STM32F746 Soc
  -Enable USB HS on STM32F746 disco and eval boards
  -Enable USB FS en STM32F746 disco board
  -Add Vrefbuf to STM32H743 SoC
  -Add LPTIMERS support on STM32H743 SoC
  -Add DMAMUX support on STM32H743 SoC
  -Enable STM32H743 clock driver
  -Add MDMA support on STM32H743 SoC
  -Change pinctrl pinmux entries for all SoC.

----------------------------------------------------------------
Alexandre Torgue (1):
       ARM: dts: stm32: change pinctrl bindings definition

Amelie Delaunay (5):
       ARM: dts: stm32: Add USB HS support for STM32F746 MCU
       ARM: dts: stm32: Enable USB HS on stm32746g-eval
       ARM: dts: stm32: Enable USB HS on stm32f746-disco
       ARM: dts: stm32: Add USB FS support for STM32F746 MCU
       ARM: dts: stm32: Enable USB FS on stm32f746-disco

Benjamin Gaignard (1):
       ARM: dts: stm32: add Timers driver for stm32f746 MCU

Fabrice Gasnier (2):
       ARM: dts: stm32: add vrefbuf to stm32h743
       ARM: dts: stm32: Add lptimer definitions to stm32h743

Gabriel Fernandez (2):
       ARM: dts: stm32: fix hse clock frequency on STM32H743 Eval board
       ARM: dts: stm32: Enable STM32H743 clock driver

Pierre-Yves MORDRET (4):
       ARM: dts: stm32: Add I2C1 support for STM32F746 SoC
       ARM: dts: stm32: Add I2C1 support for STM32F746 eval board
       ARM: dts: stm32: Add DMAMUX support for STM32H743 SoC
       ARM: dts: stm32: Add MDMA support for STM32H743 SoC

  .../bindings/pinctrl/st,stm32-pinctrl.txt          |   22 +-
  arch/arm/boot/dts/stm32746g-eval.dts               |   24 +
  arch/arm/boot/dts/stm32f4-pinctrl.dtsi             |  176 +--
  arch/arm/boot/dts/stm32f746-disco.dts              |   30 +
  arch/arm/boot/dts/stm32f746.dtsi                   |  363 ++++-
  arch/arm/boot/dts/stm32h743-pinctrl.dtsi           |   32 +-
  arch/arm/boot/dts/stm32h743.dtsi                   |  177 ++-
  arch/arm/boot/dts/stm32h743i-eval.dts              |    2 +-
  include/dt-bindings/pinctrl/stm32-pinfunc.h        |   30 +
  include/dt-bindings/pinctrl/stm32f429-pinfunc.h    | 1239 ---------------
  include/dt-bindings/pinctrl/stm32f746-pinfunc.h    | 1324 ----------------
  include/dt-bindings/pinctrl/stm32h7-pinfunc.h      | 1612 
--------------------
  12 files changed, 732 insertions(+), 4299 deletions(-)
  create mode 100644 include/dt-bindings/pinctrl/stm32-pinfunc.h
  delete mode 100644 include/dt-bindings/pinctrl/stm32f429-pinfunc.h
  delete mode 100644 include/dt-bindings/pinctrl/stm32f746-pinfunc.h
  delete mode 100644 include/dt-bindings/pinctrl/stm32h7-pinfunc.h
