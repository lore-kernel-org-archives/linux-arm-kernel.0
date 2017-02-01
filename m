From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 1 Feb 2017 18:38:34 +0100
Subject: [GIT PULL] STM32 DT changes for v4.11 #2
Message-ID: <81bf16c1-0534-919d-7ec6-b3e198e74428@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this second round of STM32 DT updates for v4.11:

The following changes since commit a4e6964a78946bf3ce969d9fef5f201e0236f0ea:

   ARM: dts: stm32: enable RTC on stm32429i-eval (2017-01-20 14:59:58 +0100)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-dt-for-v4.11-2

for you to fetch changes up to 390891d0baf82278a04835c8a62bb14dca98b96b:

   ARM: dts: stm32: Add I2C1 support for STM32429 eval board (2017-02-01 
18:20:50 +0100)

----------------------------------------------------------------
STM32 DT updates for v4.11, round 2.

Highlights:
----------

  - ADD Timers support on STM32F429 MCU
  - Enable PWM1 & PWM3 on STM32F469 Disco board
  - Fix STM32F4_X_CLOCK macro
  - Use STM32F4_X_CLOCK macro in STM32 device tree
  - Add I2C1 support for STM32F429 MCU
  - Enable I2C1 on STM32F429 eval board

----------------------------------------------------------------
Benjamin Gaignard (2):
       ARM: dts: stm32: add Timers driver for stm32f429 MCU
       ARM: dts: stm32: Enable pwm1 and pwm3 for stm32f469-disco

Gabriel Fernandez (3):
       dt-bindings: mfd: stm32f4: Fix STM32F4_X_CLOCK() macro
       dt-bindings: mfd: stm32f4: Add missing binding definition
       ARM: dts: stm32: Use clock DT binding definition on stm32f429 family

M'boumba Cedric Madianga (2):
       ARM: dts: stm32: Add I2C1 support for STM32F429 SoC
       ARM: dts: stm32: Add I2C1 support for STM32429 eval board

  arch/arm/boot/dts/stm32429i-eval.dts  |   8 +-
  arch/arm/boot/dts/stm32f429.dtsi      | 371 
++++++++++++++++++++++++++++++----
  arch/arm/boot/dts/stm32f469-disco.dts |  28 +++
  include/dt-bindings/mfd/stm32f4-rcc.h |  24 ++-
  4 files changed, 388 insertions(+), 43 deletions(-)
