From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 13 Jul 2018 15:57:40 +0200
Subject: [GIT PULL] STM32 DT changes for v4.19 #1
Message-ID: <2560c5e6-d749-244c-4ae3-4b04a3d62c36@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof and Kevin,

Please consider this first round of STM32 DT updates for v4.19:

Thanks.
Alex

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-dt-for-v4.19-1

for you to fetch changes up to c2888cc2e2b8fc16164de0cca806763831a36f6f:

   ARM: dts: stm32: update iwdg with lsi clock name for stm32f429 
(2018-07-13 13:57:05 +0200)

----------------------------------------------------------------
STM32 DT updates for v4.19, round 1

Highlights:
----------

-MCU platforms update:
  -Update RTC syscfg bindings on stm32f746 and stm32f429
  -Update IWDG node with LSI clock name on stm32f429

-MPU STM32MP157 platform update:
  -Add HASH support
  -Add m_can support and enable it on EV1 board
  -Add RTC suppoort and enable it on ED1 board
  -Add USB OTG HS support and enable it on EV1 board
  -Enable USB Host EHCI on EV1 board
  -Add DFSDM support
  -Add SPI support
  -Add ETH support and enable it on EV1 board
  -Add IWDG support and enable it on ED1 board
  -Fix useless GPIO aliases and reorder nodes

----------------------------------------------------------------
Alexandre Torgue (2):
       ARM: dts: stm32: remove gpio aliases for stm32mp157c
       ARM: dts: stm32: Reorder nodes in stm32mp157c-ed1

Amelie Delaunay (9):
       ARM: dts: stm32: update rtc st,syscfg property on stm32f429
       ARM: dts: stm32: update rtc st,syscfg property on stm32f746
       ARM: dts: stm32: add RTC support to stm32mp157c
       ARM: dts: stm32: enable RTC on stm32mp157c-ed1
       ARM: dts: stm32: enable USB Host (USBH) EHCI controller on 
stm32mp157c-ev1
       ARM: dts: stm32: add USB OTG HS support for stm32mp157c SoC
       ARM: dts: stm32: enable USB OTG HS on stm32mp157c-ev1
       ARM: dts: stm32: add SPI support on stm32mp157c
       ARM: dts: stm32: add SPI1 support on stm32mp157c-ev1

Christophe Roullier (3):
       ARM: dts: stm32: Add syscfg on stm32mp1
       ARM: dts: stm32: Add ethernet dwmac on stm32mp1
       ARM: dts: stm32: add support of ethernet on stm32mp157c-ev1

Erwan Le Ray (2):
       ARM: dts: stm32: m_can support to stm32mp157c
       ARM: dts: stm32: m_can activation on stm32mp157c-ev1

Fabrice Gasnier (2):
       ARM: dts: stm32: Add ADC support to stm32mp157c
       ARM: dts: stm32: Add DFSDM support to stm32mp157c

Lionel Debieve (1):
       ARM: dts: stm32: Add HASH support on stm32mp157c

Ludovic Barre (3):
       ARM: dts: stm32: add iwdg2 support for stm32mp157c
       ARM: dts: stm32: add iwdg2 support for stm32mp157c-ed1
       ARM: dts: stm32: update iwdg with lsi clock name for stm32f429

  arch/arm/boot/dts/stm32f429.dtsi          |   3 +-
  arch/arm/boot/dts/stm32f746.dtsi          |   2 +-
  arch/arm/boot/dts/stm32mp157-pinctrl.dtsi |  75 +++++++-
  arch/arm/boot/dts/stm32mp157c-ed1.dts     |  25 ++-
  arch/arm/boot/dts/stm32mp157c-ev1.dts     |  45 +++++
  arch/arm/boot/dts/stm32mp157c.dtsi        | 309 
++++++++++++++++++++++++++++--
  6 files changed, 434 insertions(+), 25 deletions(-)
