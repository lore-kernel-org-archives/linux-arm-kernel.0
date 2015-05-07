From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 7 May 2015 14:40:09 +0200
Subject: [GIT PULL] STi DT changes for v4.2
Message-ID: <554B5D29.8070202@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STi DT updates for v4.2:

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/sti.git 
tags/sti-dt-for-v4.2-1

for you to fetch changes up to b3d37f92a79a329c392712da5e71fdd6c0258c3a:

   ARM: DT: STi: STiH407: Add sata DT nodes. (2015-04-30 15:49:26 +0200)

----------------------------------------------------------------
STi DT updates for v4.2, round 1.

Highlights:
-----------
  - Add DT nodes for SSC on STiH407 family
  - Add DT nodes for SD/MMC on STiH407 & STiH418
  - Add DT node for LPC on STiH407
  - Add Sata DT nodes for STiH407
  - Fix PIO3 & PIO35 pins retiming on STiH407

----------------------------------------------------------------
Karim BEN BELGACEM (1):
       ARM: STi: DT: STiH407: Fix retime pin mask for PIO5 and PIO35

Lee Jones (4):
       ARM: sti: Provide DT nodes for SSC[0..4]
       ARM: sti: Provide DT nodes for SBC SSC[0..2]
       mfd: dt-bindings: Provide human readable defines for LPC mode 
choosing
       ARM: STi: DT: STiH407: Add Device Tree node for the LPC

Maxime Coquelin (1):
       Merge tag 'ib-mfd-arm-4.2' of git://git.kernel.org/.../lee/mfd.git

Peter Griffin (3):
       ARM: STi: DT: STiH407: Add dt nodes for sdhci and emmc.
       ARM: STi: DT: STiH418: Add dt nodes for sdhci and emmc.
       ARM: DT: STi: STiH407: Add sata DT nodes.

  arch/arm/boot/dts/stih407-family.dtsi  | 180 
+++++++++++++++++++++++++++++++++
  arch/arm/boot/dts/stih407-pinctrl.dtsi |   2 +
  arch/arm/boot/dts/stih410-b2120.dts    |  10 ++
  arch/arm/boot/dts/stih418-b2199.dts    |  12 +++
  arch/arm/boot/dts/stihxxx-b2120.dtsi   |   8 ++
  include/dt-bindings/mfd/st-lpc.h       |  15 +++
  6 files changed, 227 insertions(+)
  create mode 100644 include/dt-bindings/mfd/st-lpc.h
