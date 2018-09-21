From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 21 Sep 2018 16:15:33 +0200
Subject: [GIT PULL] STM32 DT changes for v4.20 #1
Message-ID: <fd4ee9a6-8195-084c-c60e-6c6e11649a4a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof and Kevin,

Please consider this first round of STM32 DT updates for v4.20.

Thanks.
Alex

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
stm32-dt-for-v4.20-1

for you to fetch changes up to 1ba23b1df0bb6eec430408614c3a11280941e112:

   ARM: dts: stm32: Fix SPI controller node names (2018-09-21 16:09:52 
+0200)

----------------------------------------------------------------
STM32 DT updates for v4.20, round 1

Highlights:
----------

-MCU platforms update:
  -Add missing clock node's lobel on stm32f429
  -Remove cd-inverted property for sdio nodes for
   all mcus
  -Fix stm32h7 rtc binding

-MPU STM32MP157 platform update:
  -Enable display: CEC and DSI
  -Fix SPI node name to match with the new DTC

----------------------------------------------------------------
Amelie Delaunay (1):
       ARM: dts: stm32: update rtc st,syscfg property on stm32h743

Patrice Chotard (5):
       ARM: dts: stm32: Add clk-lse node's label on stm32f429
       ARM: dts: stm32: Remove cd-inverted property for stm32429i-eval
       ARM: dts: stm32: Remove cd-inverted property for stm32f469-disco
       ARM: dts: stm32: Remove cd-inverted property for stm32f769-disco
       ARM: dts: stm32: Remove cd-inverted property for stm32f746-disco

Rob Herring (1):
       ARM: dts: stm32: Fix SPI controller node names

Yannick Fertr? (1):
       ARM: dts: stm32: enable display on stm32mp157c-ev1 board

  arch/arm/boot/dts/stm32429i-eval.dts  |  3 +-
  arch/arm/boot/dts/stm32f429.dtsi      |  2 +-
  arch/arm/boot/dts/stm32f469-disco.dts |  3 +-
  arch/arm/boot/dts/stm32f746-disco.dts |  3 +-
  arch/arm/boot/dts/stm32f769-disco.dts |  3 +-
  arch/arm/boot/dts/stm32h743.dtsi      |  2 +-
  arch/arm/boot/dts/stm32mp157c-ev1.dts | 73 
++++++++++++++++++++++++++++++++---
  arch/arm/boot/dts/stm32mp157c.dtsi    |  2 +-
  8 files changed, 74 insertions(+), 17 deletions(-)
