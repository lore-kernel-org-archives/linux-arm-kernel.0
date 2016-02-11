From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 11 Feb 2016 14:21:27 +0100
Subject: [GIT PULL] STM32 DT updates for v4.6 #1
Message-ID: <56BC8AD7.30607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Anrd and Kevin,

Please consider this first round of STM32 DT updates for v4.6:

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/stm32.git 
tags/stm32-dt-for-v4.6-1

for you to fetch changes up to b2aa7f7741f511c6a1ea266d62d203662f121ea7:

   ARM: dts: stm32f429: Boost perfs by remapping SDRAM Bank 1 to 0x0 
(2016-02-11 12:02:59 +0100)

----------------------------------------------------------------
Highlights:
-----------
  - Add DMA controller node to stm32f429 MCU
  - Add pinctrl & gpio nodes to stm32f429 MCU
  - Remap stm32429-eval board SD-Ram to 0x0 for performance boost

----------------------------------------------------------------
M'boumba Cedric Madianga (1):
       ARM: dts: Add STM32 DMA support for STM32F429 MCU

Maxime Coquelin (5):
       includes: dt-bindings: Add STM32F429 pinctrl DT bindings
       ARM: dts: Add pinctrl node to STM32F429
       ARM: dts: Add USART1 pin config to STM32F429 boards
       ARM: dts: Add leds support to STM32F429 boards
       ARM: dts: stm32f429: Boost perfs by remapping SDRAM Bank 1 to 0x0

  arch/arm/boot/dts/stm32429i-eval.dts            |   21 +-
  arch/arm/boot/dts/stm32f429-disco.dts           |   13 +
  arch/arm/boot/dts/stm32f429.dtsi                |  143 +++
  include/dt-bindings/pinctrl/stm32f429-pinfunc.h | 1239 
+++++++++++++++++++++++
  4 files changed, 1415 insertions(+), 1 deletion(-)
  create mode 100644 include/dt-bindings/pinctrl/stm32f429-pinfunc.h
