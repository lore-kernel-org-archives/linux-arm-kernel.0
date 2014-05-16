From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 16 May 2014 10:51:48 +0200
Subject: [GIT PULL] ARM: STi: DT changes for v3.16
Message-ID: <5375D1A4.2040205@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kevin and Arnd,

Please consider these STi DT updates for v3.16.

Note that two reset patches are part of this pull request, in order to 
avoid compilation breakage.
Adding these two patches in this pull request has been accepted by 
Philipp Zabel.

The following changes since commit 2542f928b2131a0367e50a4390afc12084cc4cc4:

   Merge tag 'renesas-dt2-for-v3.16' of 
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into next/dt 
(2014-05-05 18:44:12 -0700)

are available in the git repository at:


   git://git.stlinux.com/devel/kernel/linux-sti.git tags/sti-dt-for-v3.16

for you to fetch changes up to 633cb1924c0ef3ceeaaa7d4c94c8c4816a6f9840:

   ARM: STi: DT: STiH41x Add clk_ignore_unused to bootargs (2014-05-15 
17:11:58 +0200)

----------------------------------------------------------------
Gabriel FERNANDEZ (15):
       driver: reset: sti: add keyscan for stih415
       driver: reset: sti: add keyscan for stih416
       ARM: STi: DT: add keyscan for stih415
       ARM: STi: DT: add keyscan for stih416
       ARM: STi: DT: add keyscan for stih41x-b2000
       ARM: STi: DT: STiH416: 416 DT Entry for clockgen A0/1/10/11/12
       ARM: STi: DT: STiH416: Remove unused CLK_S_ICN_REG_0 fixed clock
       ARM: STi: DT: STiH416: Remove unused CLK_S_GMAC0_PHY & 
CLK_S_ETH1_PHY fixed clocks
       ARM: STi: DT: STiH416: 416 DT Entry for clockgen B/C/D/E/F
       ARM: STi: DT: STiH416: 416 DT Entry for clockgen A9/DDR/GPU
       ARM: STi: DT: STiH415: 415 DT Entry for clockgen A0/1/10/11/12
       ARM: STi: DT: STiH415: Remove unused CLK_S_ICN_REG_0 fixed clock
       ARM: STi: DT: STiH415: Remove unused CLK_S_GMAC0_PHY & 
CLK_S_ETH1_PHY fixed clocks
       ARM: STi: DT: STiH415: 415 DT Entry for clockgen A9
       ARM: STi: DT: STiH41x Add clk_ignore_unused to bootargs

Maxime Coquelin (2):
       ARM: dts: Add STiH407 SoC support
       ARM: dts: STiH407: Add B2120 board support

  arch/arm/boot/dts/Makefile                         |   3 +-
  arch/arm/boot/dts/stih407-b2120.dts                |  78 +++
  arch/arm/boot/dts/stih407-clock.dtsi               |  40 ++
  arch/arm/boot/dts/stih407-pinctrl.dtsi             | 615 +++++++++++++++++
  arch/arm/boot/dts/stih407.dtsi                     | 263 ++++++++
  arch/arm/boot/dts/stih415-clock.dtsi               | 517 ++++++++++++++-
  arch/arm/boot/dts/stih415-pinctrl.dtsi             |  16 +
  arch/arm/boot/dts/stih415.dtsi                     |  22 +-
  arch/arm/boot/dts/stih416-clock.dtsi               | 732 
++++++++++++++++++++-
  arch/arm/boot/dts/stih416-pinctrl.dtsi             |  16 +
  arch/arm/boot/dts/stih416.dtsi                     |  22 +-
  arch/arm/boot/dts/stih41x-b2000.dtsi               |  25 +-
  arch/arm/boot/dts/stih41x-b2020.dtsi               |   2 +-
  drivers/reset/sti/reset-stih415.c                  |   1 +
  drivers/reset/sti/reset-stih416.c                  |   1 +
  include/dt-bindings/clock/stih415-clks.h           |  15 +
  include/dt-bindings/clock/stih416-clks.h           |  15 +
  .../dt-bindings/reset-controller/stih415-resets.h  |   1 +
  .../dt-bindings/reset-controller/stih416-resets.h  |   1 +
  19 files changed, 2339 insertions(+), 46 deletions(-)
  create mode 100644 arch/arm/boot/dts/stih407-b2120.dts
  create mode 100644 arch/arm/boot/dts/stih407-clock.dtsi
  create mode 100644 arch/arm/boot/dts/stih407-pinctrl.dtsi
  create mode 100644 arch/arm/boot/dts/stih407.dtsi
  create mode 100644 include/dt-bindings/clock/stih415-clks.h
  create mode 100644 include/dt-bindings/clock/stih416-clks.h
