From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 14 May 2015 18:03:15 +0200
Subject: [GIT PULL] STi DT changes for v4.2, round 2
Message-ID: <5554C743.6040409@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this second round of STi DT updates for v4.2:

The following changes since commit b3d37f92a79a329c392712da5e71fdd6c0258c3a:

   ARM: DT: STi: STiH407: Add sata DT nodes. (2015-04-30 15:49:26 +0200)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/sti.git 
tags/sti-dt-for-v4.2-2

for you to fetch changes up to 2cdce7a98b1fbd3839aec5fc79a0f237c9b75dcc:

   ARM: STi: DT: STih407: Re-order #include <*.dtsi> files (2015-05-14 
17:42:34 +0200)

----------------------------------------------------------------
STi DT updates for v4.2, round 2.

Highlights:
-----------
  - Add USB3 support to STiH410 & STiH418
  - Add PWM support to STiH416 & STiH407 family
  - Add restart support to STiH416 & STiH407 family
  - Add PMU support to STiH416 & STiH407 family
  - Reorder includes in STiH407 DT files

----------------------------------------------------------------
Lee Jones (12):
       ARM: STi: STiH407: Add DT nodes for for PWM
       ARM: STi: STiH416: Add Pinctrl settings for PWM
       ARM: STi: STiH416: Add DT nodes for PWM
       ARM: STi: STiH416-b2020e: Enable PWM on the B2020 Rev-E
       ARM: STi: STiH407: Add Restart support for STiH407
       ARM: STi: STiH416: Add Restart support for STiH416
       ARM: STi: STiH416: Enable Cortex-A9 PMU support
       ARM: STi: STiH416: Enable PMU IRQs
       ARM: STi: STiH407: Enable Cortex-A9 PMU support
       ARM: STi: STiH407: Enable PMU IRQs
       ARM: STi: Ensure requested STi's SysCfg Controlled IRQs are 
enabled at boot
       ARM: STi: DT: STih407: Re-order #include <*.dtsi> files

Peter Griffin (5):
       ARM: DT: STi: STiH407: Update picophyreset for the usb3 
controllers usb2 phy
       ARM: DT: STi: STiH407: Add dwc3 usb3 DT node.
       ARM: DT: STi: stihxxx-b2120: Enable USB3 port on stih407-b2120 
and stih410-b2120
       ARM: DT: STi: STiH418: Add miphy28lp optional oscillator clock 
properties
       ARM: DT: STi: STiH418: Enable USB3 port on stih418-b2199.

  arch/arm/boot/dts/stih407-b2120.dts    |  2 +-
  arch/arm/boot/dts/stih407-family.dtsi  | 51 +++++++++++++++++++++++++-
  arch/arm/boot/dts/stih407.dtsi         | 28 +++++++++++++++
  arch/arm/boot/dts/stih416-b2020e.dts   | 10 ++++++
  arch/arm/boot/dts/stih416-pinctrl.dtsi | 50 ++++++++++++++++++++++++++
  arch/arm/boot/dts/stih416.dtsi         | 66 
+++++++++++++++++++++++++++++++++-
  arch/arm/boot/dts/stih418-b2199.dts    | 15 ++++++++
  arch/arm/boot/dts/stihxxx-b2120.dtsi   |  5 +++
  arch/arm/mach-sti/Kconfig              |  1 +
  9 files changed, 225 insertions(+), 3 deletions(-)
