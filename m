From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 5 Mar 2018 12:21:05 +0100
Subject: [GIT PULL] STM32 DT changes for v4.17 #1
Message-ID: <ce2aab85-1b5c-6fa0-3f5d-0e2ecea61906@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STM32 DT updates for v4.17:

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-dt-for-v4.17-1

for you to fetch changes up to 193ca00b820c9d95955ba36e3882f4a060e2559e:

   ARM: dts: stm32: Fix sdio2 rcc hard coded value (2018-03-05 09:04:25 
+0100)

----------------------------------------------------------------
STM32 DT updates for v4.17, round 1

Highlights:
-----------
  -Add support of STM32MP157 MPU and stm32mp157c eval board
  -Add SD supports on F4 and F7 boards
  -Add leds support on stm32f469 and stm32f769 disco boards
  -Add push button support on stm32f469 and stm32f769 disco boards
  -Add EXTI, SPI, RTC, USB HS/FS support on STM32H743 MCU
  -Add RTC and USB OTG HS on stm32f769-disco
  -Use dedicated files for F7 pinctrl

----------------------------------------------------------------
Alexandre Torgue (2):
       dt-bindings: pinctrl: Add st,stm32f769-pinctrl compatible to 
stm32-pinctrl
       ARM: dts: stm32: use dedicated files for pinctrl on stm32f7 family

Amelie Delaunay (9):
       ARM: dts: stm32: add gadget fifo sizes to usbotg_hs on stm32f746
       ARM: dts: stm32: select otg mode for usbotg_hs on stm32746g_eval
       ARM: dts: stm32: enable USB HS on stm32f769-disco
       ARM: dts: stm32: enable RTC on stm32f769-disco
       ARM: dts: stm32: add USB OTG HS and FS support for STM32H743 SoC
       ARM: dts: stm32: enable USB OTG HS on stm32h743i-eval
       ARM: dts: stm32: add RTC support on STM32H743
       ARM: dts: stm32: enable RTC on stm32h743i-eval
       ARM: dts: stm32: add SPI support on STM32H743 SoC

Andrea Merello (1):
       ARM: dts: stm32: Add pin map for SDIO controller on stm32f4

Benjamin Gaignard (4):
       ARM: dts: stm32: Add leds support to stm32f469 Discovery board
       ARM: dts: stm32: Add leds support to stm32f769 Discovery board
       ARM: dts: stm32: Add push button to stm32f469 Discovery board
       ARM: dts: stm32: Add push button to stm32f769 Discovery board

Ludovic Barre (6):
       ARM: dts: stm32: add exti support for stm32h743
       ARM: dts: stm32: add system config bank node for stm32h743
       ARM: dts: stm32: add support of exti on stm32h743 pinctrl
       ARM: dts: stm32: add stm32mp157c initial support
       ARM: dts: stm32: add initial support of stm32mp157c eval board
       dt-bindings: stm32: add support of STM32MP157

Mathieu Malaterre (1):
       ARM: dts: stm32: dts: Remove leading 0x and 0s from bindings notation

Patrice Chotard (11):
       ARM: dts: stm32: Add SDIO controller for stm32f746
       ARM: dts: stm32: Add SDIO controller for stm32f429
       ARM: dts: stm32: Enable SDIO controller on stm32f469 disco board
       ARM: dts: stm32: Enable SDIO controller on stm32429i-eval board
       ARM: dts: stm32: Fix HSE clock frequency for stm32h743i-disco board
       ARM: dts: stm32: Add sdio pins definition for stm32f7
       ARM: dts: stm32: Enable sdio1 for stm32f746-disco
       ARM: dts: stm32: Enable sdio1 for stm32f746-eval
       ARM: dts: stm32: Enable sdio1 for stm32f769-disco
       dt-bindings: mfd: Add STM32F7 SDMMC2 rcc entry
       ARM: dts: stm32: Fix sdio2 rcc hard coded value

  Documentation/devicetree/bindings/arm/stm32.txt    |   1 +
  .../bindings/pinctrl/st,stm32-pinctrl.txt          |   1 +
  arch/arm/boot/dts/Makefile                         |   6 +-
  arch/arm/boot/dts/stm32429i-eval.dts               |  19 ++
  arch/arm/boot/dts/stm32746g-eval.dts               |  20 +-
  arch/arm/boot/dts/stm32f4-pinctrl.dtsi             |  31 +++
  arch/arm/boot/dts/stm32f429.dtsi                   |  11 +
  arch/arm/boot/dts/stm32f469-disco.dts              |  50 ++++
  arch/arm/boot/dts/stm32f7-pinctrl.dtsi             | 289 
+++++++++++++++++++++
  arch/arm/boot/dts/stm32f746-disco.dts              |  20 ++
  arch/arm/boot/dts/stm32f746-pinctrl.dtsi           |  11 +
  arch/arm/boot/dts/stm32f746.dtsi                   | 242 ++---------------
  arch/arm/boot/dts/stm32f769-disco.dts              |  65 ++++-
  arch/arm/boot/dts/stm32f769-pinctrl.dtsi           |  11 +
  arch/arm/boot/dts/stm32h743-pinctrl.dtsi           |  44 ++++
  arch/arm/boot/dts/stm32h743.dtsi                   | 112 +++++++-
  arch/arm/boot/dts/stm32h743i-disco.dts             |   2 +-
  arch/arm/boot/dts/stm32h743i-eval.dts              |  20 ++
  arch/arm/boot/dts/stm32mp157-pinctrl.dtsi          | 185 +++++++++++++
  arch/arm/boot/dts/stm32mp157c-ed1.dts              |  32 +++
  arch/arm/boot/dts/stm32mp157c-ev1.dts              |  21 ++
  arch/arm/boot/dts/stm32mp157c.dtsi                 | 194 ++++++++++++++
  include/dt-bindings/mfd/stm32f7-rcc.h              |   1 +
  23 files changed, 1165 insertions(+), 223 deletions(-)
  create mode 100644 arch/arm/boot/dts/stm32f7-pinctrl.dtsi
  create mode 100644 arch/arm/boot/dts/stm32f746-pinctrl.dtsi
  create mode 100644 arch/arm/boot/dts/stm32f769-pinctrl.dtsi
  create mode 100644 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
  create mode 100644 arch/arm/boot/dts/stm32mp157c-ed1.dts
  create mode 100644 arch/arm/boot/dts/stm32mp157c-ev1.dts
  create mode 100644 arch/arm/boot/dts/stm32mp157c.dtsi
