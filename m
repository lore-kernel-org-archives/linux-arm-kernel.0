From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 18 Nov 2014 15:16:04 +0100
Subject: [GIT PULL] ARM: STi: DT changes for v3.19, round 2
Message-ID: <546B54A4.4050908@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this second round of STi DT updates for v3.19.
It is based on tag sti-dt-for-v3.19-1, already merged in arm-soc's next/dt.

The following changes since commit 43ca480c4e42f536fcf18118afcffad685e1292c:

   ARM: STi: DT: STiH407: Fix: clk-tmds-hdmi clock is missing 
(2014-10-31 12:07:44 +0100)

are available in the git repository at:

   git://git.stlinux.com/devel/kernel/linux-sti.git tags/sti-dt-for-v3.19-2

for you to fetch changes up to 3ece2c2be34f2fe6254b49dffa5815e2fc7f1b71:

   ARM: STi: DT: STiH416: Change miphy356 node name to phy at fe382000 
(2014-11-18 12:54:56 +0100)

----------------------------------------------------------------
STi DT updates for v3.19, round 2.

Highlights:
-----------
  - Refactor STiH407 SoC and board to add STiH410 SoC support
  - Add USB support to STiH416 SoC

----------------------------------------------------------------
Peter Griffin (9):
       ARM: STi: DT: STiH416: Add pinctl setup for usb controllers.
       ARM: STi: DT: STiH416: Add DT node for the stih415/6 usb2 phy
       ARM: STi: DT: STiH416: Add DT nodes for the ehci and ohci usb 
controllers.
       ARM: STi: DT: STiH410: Add defines for STiH410 DT clocks
       ARM: STi: DT: STiH410: Add pinctl config for usb controllers.
       ARM: STi: DT: STih407: Abstract common dt nodes into shared files.
       ARM: STi: DT: STiH410: Add STiH410 SoC and b2120 board support.
       ARM: STi: DT: STih407: STih410: Add clk_ignore_unused to kernel 
bootargs
       ARM: STi: DT: STiH416: Change miphy356 node name to phy at fe382000

  arch/arm/boot/dts/Makefile                         |   1 +
  arch/arm/boot/dts/stih407-b2120.dts                |  55 +---
  .../boot/dts/{stih407.dtsi => stih407-family.dtsi} |   1 -
  arch/arm/boot/dts/stih410-b2120.dts                |  29 ++
  arch/arm/boot/dts/stih410-clock.dtsi               | 338 
+++++++++++++++++++++
  arch/arm/boot/dts/stih410-pinctrl.dtsi             |  34 +++
  arch/arm/boot/dts/stih410.dtsi                     |  14 +
  arch/arm/boot/dts/stih416-b2020.dts                |   2 +-
  arch/arm/boot/dts/stih416-b2020e.dts               |   2 +-
  arch/arm/boot/dts/stih416-pinctrl.dtsi             |  34 +++
  arch/arm/boot/dts/stih416.dtsi                     | 131 +++++++-
  arch/arm/boot/dts/stihxxx-b2120.dtsi               |  59 ++++
  include/dt-bindings/clock/stih410-clks.h           |  25 ++
  13 files changed, 670 insertions(+), 55 deletions(-)
  rename arch/arm/boot/dts/{stih407.dtsi => stih407-family.dtsi} (99%)
  create mode 100644 arch/arm/boot/dts/stih410-b2120.dts
  create mode 100644 arch/arm/boot/dts/stih410-clock.dtsi
  create mode 100644 arch/arm/boot/dts/stih410-pinctrl.dtsi
  create mode 100644 arch/arm/boot/dts/stih410.dtsi
  create mode 100644 arch/arm/boot/dts/stihxxx-b2120.dtsi
  create mode 100644 include/dt-bindings/clock/stih410-clks.h
