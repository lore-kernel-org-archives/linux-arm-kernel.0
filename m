From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 28 Jul 2017 15:57:28 +0200
Subject: [GIT PULL] STM32 defconfig changes for v4.14 #1
Message-ID: <5a0f6e72-bb00-7945-af7a-a3b380372597@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STM32 DT updates for v4.14:

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-dt-for-v4.14-1

for you to fetch changes up to 01d281b6e4a2d196357d9ae0189bd53cbea160ad:

   ARM: dts: stm32: Add DMA support for STM32H743 SoC (2017-07-28 
09:51:23 +0200)

----------------------------------------------------------------
STM32 DT updates for v4.14, round 1

Highlights:
----------
  -Add DMA support on STM32F746
  -Add DMA support on STM32H743
  -Add DAC support on STM32H743
  -Add DAC support on STM32F429
  -Add ADC support on STM32H743
  -Enable ADC on stm32h743i-eval board
  -Add CEC support on STM32F7xx MCUs
  -Enable CEC on stm32f769-disco board
  -Remove rdinit from stm32f4 boards

----------------------------------------------------------------
Alexandre TORGUE (3):
       ARM: dts: stm32: Remove rdinit from bootargs on stm32f469-disco
       ARM: dts: stm32: Remove rdinit from bootargs on stm32f429i-eval
       ARM: dts: stm32: Remove rdinit from bootargs on stm32f429-disco

Alexandre Torgue (1):
       ARM: dts: stm32: reorder stm32h743 nodes

Benjamin Gaignard (2):
       ARM: dts: stm32: add CEC for stm32f7 family
       ARM: dts: stm32: enable CEC for stm32f769 discovery

Fabrice Gasnier (4):
       ARM: dts: stm32: Add DAC support on stm32f429
       ARM: dts: stm32: Add DAC support on stm32h743
       ARM: dts: stm32: add ADC support on stm32h743
       ARM: dts: stm32: enable ADC on stm32h743i-eval board

Pierre-Yves MORDRET (2):
       ARM: dts: stm32: Add DMA support for STM32F746 SoC
       ARM: dts: stm32: Add DMA support for STM32H743 SoC

  arch/arm/boot/dts/stm32429i-eval.dts  |   2 +-
  arch/arm/boot/dts/stm32f429-disco.dts |   2 +-
  arch/arm/boot/dts/stm32f429.dtsi      |  25 +++++++
  arch/arm/boot/dts/stm32f469-disco.dts |   2 +-
  arch/arm/boot/dts/stm32f746.dtsi      |  51 ++++++++++++++
  arch/arm/boot/dts/stm32f769-disco.dts |   6 ++
  arch/arm/boot/dts/stm32h743.dtsi      | 127 
+++++++++++++++++++++++++++++++---
  arch/arm/boot/dts/stm32h743i-eval.dts |  18 +++++
  8 files changed, 222 insertions(+), 11 deletions(-)
