From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 4 Nov 2016 15:31:55 +0100
Subject: [GIT PULL] STM32 DT changes for v4.10 #1
Message-ID: <3e65d3ae-6509-6057-64e1-dfc256e535b5@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STM32 DT updates for v4.10:

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-dt-for-v4.10-1

for you to fetch changes up to f6dbbff4f0af1a5c0d6eaf414572b5eff7a73a8b:

   ARM: dts: stm32f429: add LSI and LSE clocks (2016-11-04 15:08:08 +0100)

----------------------------------------------------------------
STM32 DT updates for v4.10, round 1.

Highlights:
----------
  - Add LSI and LSE clocks support for STM32F429
  - Add GPIO IRQ support for STM32F429
  - Declare push button as GPIO keys on STM32F429 boards
  - Add DMA supports on USART1 & USART3 on STM32F429
  - Add Ethernet fixes

----------------------------------------------------------------
Alexandre TORGUE (5):
       ARM: DT: STM32: add dma for usart3 on F429
       ARM: DT: stm32: move dma translation to board files
       ARM: dts: stm32f429: Align Ethernet node with new bindings properties
       ARM: dts: stm32f429: Fix Ethernet node on Eval Board
       ARM: dts: stm32f429: remove Ethernet wake on Lan support

Gabriel Fernandez (1):
       ARM: dts: stm32f429: add LSI and LSE clocks

Gerald Baeza (1):
       ARM: DT: STM32: add dma for usart1 on F429

Maxime Coquelin (2):
       ARM: dts: Add GPIO irq support to STM32F429
       ARM: dts: Declare push button as GPIO key on stm32f429 boards

  arch/arm/boot/dts/stm32429i-eval.dts  | 29 ++++++++++++++++++++++---
  arch/arm/boot/dts/stm32f429-disco.dts | 13 ++++++++++++
  arch/arm/boot/dts/stm32f429.dtsi      | 40 
+++++++++++++++++++++++++++--------
  arch/arm/boot/dts/stm32f469-disco.dts |  4 ++++
  4 files changed, 74 insertions(+), 12 deletions(-)
