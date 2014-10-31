From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 31 Oct 2014 13:25:03 +0100
Subject: [GIT PULL] ARM: STi: DT changes for v3.19, round 1
Message-ID: <54537F9F.4070500@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STi DT updates for v3.19:

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

   git://git.stlinux.com/devel/kernel/linux-sti.git tags/sti-dt-for-v3.19-1

for you to fetch changes up to 43ca480c4e42f536fcf18118afcffad685e1292c:

   ARM: STi: DT: STiH407: Fix: clk-tmds-hdmi clock is missing 
(2014-10-31 12:07:44 +0100)

----------------------------------------------------------------
STi DT updates for v3.19, round 1.

Highlights:
-----------
  - Add SDHCI support for STiH41x B2020 boards
  - Add reset controllers to STiH407 SoC
  - Add MiPHY & SATA support to STiH416
  - Add Thermal supportto STiH416
  - Add Clock support to STiH407 SoC

This tag also includes STiH407 bindings definitions for reset controller.

----------------------------------------------------------------
Gabriel FERNANDEZ (6):
       ARM: STi: DT: STiH407: 407 DT Entry for clockgen A0
       ARM: STi: DT: STiH407: 407 DT Entry for clockgen C0
       ARM: STi: DT: STiH407: 407 DT Entry for clockgen D0/D2/D3
       ARM: STi: DT: STiH407: 407 DT Entry for clockgenA9
       ARM: STi: DT: STiH407: Add all defines for STiH407 DT clocks
       ARM: STi: DT: STiH407: Fix: clk-tmds-hdmi clock is missing

Lee Jones (4):
       ARM: STi: DT: STiH41x: Convert all uppercase non-defines to lowercase
       ARM: STi: DT: STiH416: Supply Thermal Controller Device Tree nodes
       ARM: DT: STi: STiH416: Add DT node for MiPHY365x
       ARM: DT: STi: STiH416: Add DT node for ST's SATA device

Maxime Coquelin (1):
       reset: stih407: Add reset controllers DT bindings

Peter Griffin (8):
       ARM: sti: Add STiH407 Kconfig entry to select STIH407_RESET
       ARM: sti: Add STiH407 reset controller support.
       ARM: STi: DT: Add sdhci pins for stih416
       ARM: STi: DT: Add sdhci controller for stih416
       ARM: STi: DT: Add sdhci pin configuration for stih415
       ARM: STi: DT: Add sdhci controller for stih415
       ARM: STi: DT: Enable mmc0 for both stih415 and stih416 SoCs
       ARM: STi: DT: Enable second sdhci controller for stih416 b2020 
boards.

  arch/arm/boot/dts/stih407-clock.dtsi               | 293 +++++++++++++++-
  arch/arm/boot/dts/stih407.dtsi                     |  34 +-
  arch/arm/boot/dts/stih415-pinctrl.dtsi             | 361 
++++++++++---------
  arch/arm/boot/dts/stih415.dtsi                     |  12 +
  arch/arm/boot/dts/stih416-b2020.dts                |  22 ++
  arch/arm/boot/dts/stih416-b2020e.dts               |  26 +-
  arch/arm/boot/dts/stih416-pinctrl.dtsi             | 381 
++++++++++++---------
  arch/arm/boot/dts/stih416.dtsi                     |  80 +++++
  arch/arm/boot/dts/stih41x-b2000.dtsi               |   6 +-
  arch/arm/boot/dts/stih41x-b2020.dtsi               |  10 +-
  arch/arm/boot/dts/stih41x-b2020x.dtsi              |   4 +
  arch/arm/mach-sti/Kconfig                          |  10 +
  include/dt-bindings/clock/stih407-clks.h           |  86 +++++
  .../dt-bindings/reset-controller/stih407-resets.h  |  61 ++++
  14 files changed, 1024 insertions(+), 362 deletions(-)
  create mode 100644 include/dt-bindings/clock/stih407-clks.h
  create mode 100644 include/dt-bindings/reset-controller/stih407-resets.h
