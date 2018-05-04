From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 4 May 2018 15:46:51 +0200
Subject: [GIT PULL] STM32 DT changes for v4.18 #1
Message-ID: <28c73dd0-fa87-83c1-5a93-217124e0f484@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof and Kevin,

Please consider this first round of STM32 DT updates for v4.18. As you 
will see, main part of patches concerns support for STM32MP157 platform.
I didn't squash DT patches (as I like the way there are split) but let 
me know if for next time you prefer I do it.

Regards
Alex


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-dt-for-v4.18-1

for you to fetch changes up to 0a84a00094eea4080288f5c62aff8a90e510a252:

   ARM: dts: stm32: update pwm-cells for LPTimer on stm32h743 
(2018-05-04 09:45:54 +0200)

----------------------------------------------------------------
STM32 DT updates for v4.18, round 1

Highlights:
-----------
-MCU platforms updates:
  -Update pwm-cells for stm32h743
  -Add I2C support on stm32f7xx-disco boards and
   on stm32h743i-eval board
  -Add new stm32f469 dtsi file
  -Add display support on stm32f469-disco (LTDC/DSI)
   + pannel orisetech (otm8009a)

-MPU STM32MP157 platform updates:
  -Fix DTC (W=12) warnings
  -Fix IRQ type definition for usart
  -Add QSPI & NOR flash support on EV1 board
  -Add CEC support
  -Add USB host
  -Add USBPHYC support and enable it on EV1 board
  -Add LTDC and DSI support
  -Add I2C support and enable it on ED1 and EV1 boards
  -Add CRC support
  -Add RNG support
  -Add CRYP support
  -Add DAC support
  -Add LPTIMER support
  -Add VREFBUFF support
  -Add timers supports and enable timer trigger 6 on ED1 board
  -Add MDMA, DMA and DMAMUX support and enable it
  -Enable clock driver

----------------------------------------------------------------
Alexandre Torgue (2):
       ARM: dts: stm32: Fix DTC warnings for stm32mp157
       ARM: dts: stm32: Fix IRQ_TYPE_NONE warnings on stm32mp157c

Amelie Delaunay (4):
       ARM: dts: stm32: add USBPHYC support to stm32mp157c
       ARM: dts: stm32: add supplies to usbphyc ports on stm32mp157c-ed1
       ARM: dts: stm32: enable USBPHYC on stm32mp157c-ev1
       ARM: dts: stm32: add USB Host (USBH) support to stm32mp157c

Fabrice Gasnier (8):
       ARM: dts: stm32: add timers support to stm32mp157c
       ARM: dts: stm32: add PWM pins used on stm32mp157c-ev1 board
       ARM: dts: stm32: add PWM and triggers on stm32mp157c-ev1 board
       ARM: dts: stm32: enable timer trigger 6 on stm32mp157c-ed1
       ARM: dts: stm32: Add vrefbuf support to stm32mp157c
       ARM: dts: stm32: Add LPtimer support to stm32mp157c
       ARM: dts: stm32: Add DAC support to stm32mp157c
       ARM: dts: stm32: update pwm-cells for LPTimer on stm32h743

Gabriel Fernandez (2):
       ARM: dts: stm32: Enable stm32mp1 clock driver on stm32mp157c
       ARM: dts: stm32: add reset binding on stm32mp157c

Lionel Debieve (4):
       ARM: dts: stm32: Add RNG support on stm32mp157c
       ARM: dts: stm32: Enable RNG for stm32mp157c-ed1
       ARM: dts: stm32: Add CRYP support on stm32mp157c
       ARM: dts: stm32: Add CRC support on stm32mp157c

Ludovic Barre (2):
       ARM: dts: stm32: add qspi support for stm32mp157c
       ARM: dts: stm32: add flash nor support on stm32mp157c eval board

Philippe CORNU (1):
       ARM: dts: stm32: Add display support on stm32f469-disco

Philippe Cornu (2):
       ARM: dts: stm32: Use gpio bindings in stm32f469-disco
       ARM: dts: stm32: Add new stm32f469 dtsi file with mipi dsi

Pierre-Yves MORDRET (12):
       ARM: dts: stm32: Add DMAv2 support on STM32MP157C
       ARM: dts: stm32: Add DMAMUX support on STM32MP157C
       ARM: dts: stm32: Add MDMA support on STM32MP157C
       ARM: dts: stm32: Add STM32F7 I2C support for STM32MP157C SoC
       ARM: dts: stm32: Add I2Cs pins used on STM32MP157C
       ARM: dts: stm32: Add I2C4 support for STM32MP157C-ED1
       ARM: dts: stm32: Add I2C2/5 support for STM32MP157C-EV1
       ARM: dts: stm32: Append additional I2Cs for STM32F746 SoC
       ARM: dts: stm32: Add I2C1 support for stm32f769-disco Board
       ARM: dts: stm32: Add I2C1 support for stm32f746-disco Board
       ARM: dts: stm32: Add I2C support for STM32H743 SoC
       ARM: dts: stm32: Add I2C1 support for stm32h743i-eval Board

yannick fertre (5):
       ARM: dts: stm32: add ltdc support on stm32mp157c
       ARM: dts: stm32: add dsi support on stm32mp157c
       ARM: dts: stm32: add cec support on stm32mp157c
       ARM: dts: stm32: add cec pins to stm32mp157c
       ARM: dts: stm32: add cec support on stm32mp157c-ev1

  arch/arm/boot/dts/stm32f469-disco.dts     |  53 ++-
  arch/arm/boot/dts/stm32f469.dtsi          |  19 +
  arch/arm/boot/dts/stm32f746-disco.dts     |   8 +
  arch/arm/boot/dts/stm32f746.dtsi          |  36 ++
  arch/arm/boot/dts/stm32f769-disco.dts     |   8 +
  arch/arm/boot/dts/stm32h743-pinctrl.dtsi  |  10 +
  arch/arm/boot/dts/stm32h743.dtsi          |  53 +++
  arch/arm/boot/dts/stm32h743i-eval.dts     |   8 +
  arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 151 ++++++-
  arch/arm/boot/dts/stm32mp157c-ed1.dts     |  57 ++-
  arch/arm/boot/dts/stm32mp157c-ev1.dts     |  87 ++++
  arch/arm/boot/dts/stm32mp157c.dtsi        | 720 
++++++++++++++++++++++++++++--
  12 files changed, 1152 insertions(+), 58 deletions(-)
  create mode 100644 arch/arm/boot/dts/stm32f469.dtsi
