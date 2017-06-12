From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 12 Jun 2017 14:08:21 +0200
Subject: [GIT PULL] STM32 DT changes for v4.13 #1
Message-ID: <2b77deee-6816-d58f-bc75-07cfd10e011e@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STM32 DT updates for v4.13:

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-dt-for-v4.13-1

for you to fetch changes up to 437074645873d77e8958be4f7eeec66a69cf0077:

   ARM: dts: stm32: Add stm32h743i-disco board (2017-06-09 16:38:42 +0200)

----------------------------------------------------------------
STM32 DT updates for v4.13, round 1

Highlights:
----------
  - Add stm32h743-disco board support
  - Add stm32f746-disco board support
  - Add stm32f769-disco board support
  - Enable LTDC & simple pannel on stm32f429-eval
  - Enable Watchdog on stm32f429-eval
  - Enable DCMI on stm32f429-eval
  - Enable STMPE1600 io expander on stm32f429-eval
  - Enable OV2640 camera on stm32f429-eval
  - Enable CRC on stm32f429-eval & stm32f429-disco

----------------------------------------------------------------
Alexandre TORGUE (1):
       ARM: dts: stm32: Set gpio controller as interrupt controller on 
F4 and F7

Cosar Dindar (3):
       ARM: dts: stm32: Add CRC support to stm32f429
       ARM: dts: stm32: enable CRC32 on stm32429-disco board
       ARM: dts: stm32: enable CRC32 on stm32429i-eval board

Hugues Fruchet (4):
       ARM: dts: stm32: Enable DCMI support on STM32F429 MCU
       ARM: dts: stm32: Enable DCMI camera interface on STM32F429-EVAL board
       ARM: dts: stm32: Enable STMPE1600 gpio expander of STM32F429-EVAL 
board
       ARM: dts: stm32: Enable OV2640 camera support of STM32F429-EVAL board

Lionel Debieve (1):
       ARM: dts: stm32: Add missing reset-cells node in stm32f746

Patrice Chotard (3):
       ARM: dts: stm32: Add usart2_pins on stm32h743
       ARM: dts: stm32: Add usart2 support on stm32h743
       ARM: dts: stm32: Add stm32h743i-disco board

Vikas Manocha (1):
       ARM: dts: stm32: add stm32f769I & stm32f746 discovery board support

Yannick Fertre (4):
       ARM: dts: stm32: Add ltdc support on stm32f429 MCU
       ARM: dts: stm32: Enable ltdc & simple panel on stm32f429-Eval board
       ARM: dts: stm32: Add watchdog support for STM32F429 SoC
       ARM: dts: stm32: Add watchdog support for STM32F429 eval board

  arch/arm/boot/dts/Makefile               |   5 +-
  arch/arm/boot/dts/stm32429i-eval.dts     |  88 ++++++++++++++++++++++
  arch/arm/boot/dts/stm32f429-disco.dts    |   4 +
  arch/arm/boot/dts/stm32f429.dtsi         | 121 
++++++++++++++++++++++++++++++-
  arch/arm/boot/dts/stm32f746-disco.dts    |  74 +++++++++++++++++++
  arch/arm/boot/dts/stm32f746.dtsi         |  36 +++++++++
  arch/arm/boot/dts/stm32f769-disco.dts    |  74 +++++++++++++++++++
  arch/arm/boot/dts/stm32h743-pinctrl.dtsi |  13 ++++
  arch/arm/boot/dts/stm32h743.dtsi         |   8 ++
  arch/arm/boot/dts/stm32h743i-disco.dts   |  73 +++++++++++++++++++
  10 files changed, 493 insertions(+), 3 deletions(-)
  create mode 100644 arch/arm/boot/dts/stm32f746-disco.dts
  create mode 100644 arch/arm/boot/dts/stm32f769-disco.dts
  create mode 100644 arch/arm/boot/dts/stm32h743i-disco.dts
