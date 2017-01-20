From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 20 Jan 2017 15:40:41 +0100
Subject: [GIT PULL] STM32 DT changes for v4.11 #1 V2
Message-ID: <a8f6b0aa-412e-65b7-5d88-e4b17097c3a8@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this second version of first round of STM32 DT updates 
for v4.11:

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-dt-for-v4.11-1-v2

for you to fetch changes up to a4e6964a78946bf3ce969d9fef5f201e0236f0ea:

   ARM: dts: stm32: enable RTC on stm32429i-eval (2017-01-20 14:59:58 +0100)

----------------------------------------------------------------
STM32 DT updates for v4.11, round 1 Version 2.

Highlights:
----------

  - ADD RTC support on STM32F429 MCU
  - Enable RTC on STM32F469and STM32F429 boards
  - ADD ADC support on STM32F429 MCU
  - Enable ADC on STM32F429 Eval board
  - Add I2S external clock
  - Fix memory size for STM32F429 Disco

Note:
-----
First patch "clk: stm32f4: Update DT bindings documentation")
has already been merged in clock tree. Compare to version 1
git merge has been used to take this patch.

----------------------------------------------------------------
Alexandre TORGUE (1):
       Merge commit 'f8b5036361412a27c07a4ac9c3a4b80678cbd1e1' into 
stm32-dt-for-v4.11

Amelie Delaunay (5):
       ARM: dts: stm32: set HSE_RTC clock frequency to 1 MHz on stm32f429
       ARM: dts: stm32: Add RTC support for STM32F429 MCU
       ARM: dts: stm32: enable RTC on stm32f429-disco
       ARM: dts: stm32: enable RTC on stm32f469-disco
       ARM: dts: stm32: enable RTC on stm32429i-eval

Bruno Herrera (1):
       ARM: dts: stm32: Fix memory size from 8MB to 16MB on 
stm32f469-disco board

Bruno Meirelles Herrera (1):
       ARM: dts: stm32: Add missing USART3 pin config to stm32f469-disco 
board

Fabrice GASNIER (2):
       ARM: dts: stm32: Add ADC support to stm32f429
       ARM: dts: stm32: enable ADC on stm32f429i-eval board

Gabriel Fernandez (3):
       clk: stm32f4: Update DT bindings documentation
       ARM: dts: stm32: Add external I2S clock on stm32f429 MCU
       ARM: dts: stm32: Include auxiliary stm32fx clock definition

  .../devicetree/bindings/clock/st,stm32-rcc.txt     | 17 +++++
  arch/arm/boot/dts/stm32429i-eval.dts               | 29 ++++++++
  arch/arm/boot/dts/stm32f429-disco.dts              |  6 ++
  arch/arm/boot/dts/stm32f429.dtsi                   | 87 
+++++++++++++++++++++-
  arch/arm/boot/dts/stm32f469-disco.dts              |  8 +-
  include/dt-bindings/clock/stm32fx-clock.h          | 39 ++++++++++
  6 files changed, 184 insertions(+), 2 deletions(-)
  create mode 100644 include/dt-bindings/clock/stm32fx-clock.h
