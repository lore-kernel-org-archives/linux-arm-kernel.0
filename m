From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 22 May 2014 11:09:26 +0200
Subject: ARM: STi: DT changes for v3.16, v3
Message-ID: <537DBEC6.7020909@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kevin and Arnd,

Please consider these STi DT updates for v3.16.

This 3rd version takes into account Olof's comments on the v2:
	- Fix upper-cases in labels and node names
 	- Sort compatibles order from specific to generic
	- Sort dts entries in Makefile

It also adds support for the B2020 revision E board for STiH416 SoC.

Note that two reset patches are part of this pull request, in order to avoid
compilation breakage.
Adding these two patches in this pull request has been accepted by Philipp Zabel.

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.stlinux.com/devel/kernel/linux-sti.git tags/sti-dt-for-v3.16-1

for you to fetch changes up to ca766449a8116f8174e9928d1f4889a858c07610:

  ARM: sti: stih41x: Provide a proper header for this DTSI file (2014-05-21 14:27:16 +0200)

----------------------------------------------------------------
Gabriel FERNANDEZ (16):
      driver: reset: sti: add keyscan for stih415
      driver: reset: sti: add keyscan for stih416
      ARM: STi: DT: add keyscan for stih415
      ARM: STi: DT: add keyscan for stih416
      ARM: STi: DT: add keyscan for stih41x-b2000
      ARM: STi: DT: STiH41x: Rename CLK_SYSIN into clk_sysin
      ARM: STi: DT: STiH416: 416 DT Entry for clockgen A0/1/10/11/12
      ARM: STi: DT: STiH416: Remove unused CLK_S_ICN_REG_0 fixed clock
      ARM: STi: DT: STiH416: Remove unused CLK_S_GMAC0_PHY & CLK_S_ETH1_PHY fixed clocks
      ARM: STi: DT: STiH416: 416 DT Entry for clockgen B/C/D/E/F
      ARM: STi: DT: STiH416: 416 DT Entry for clockgen A9/DDR/GPU
      ARM: STi: DT: STiH415: 415 DT Entry for clockgen A0/1/10/11/12
      ARM: STi: DT: STiH415: Remove unused CLK_S_ICN_REG_0 fixed clock
      ARM: STi: DT: STiH415: Remove unused CLK_S_GMAC0_PHY & CLK_S_ETH1_PHY fixed clocks
      ARM: STi: DT: STiH415: 415 DT Entry for clockgen A9
      ARM: STi: DT: STiH41x Add clk_ignore_unused to bootargs

Lee Jones (3):
      ARM: sti: stih416: Add support for B2020 RevE
      ARM: sti: stih416: Enable board LED support for B2020 RevE
      ARM: sti: stih41x: Provide a proper header for this DTSI file

Maxime Coquelin (4):
      ARM: dts: Sort STi boards in Makefile
      ARM: dts: Fix STi boards compatibles
      ARM: dts: Add STiH407 SoC support
      ARM: dts: STiH407: Add B2120 board support

 arch/arm/boot/dts/Makefile                         |   8 +-
 arch/arm/boot/dts/stih407-b2120.dts                |  78 +++
 arch/arm/boot/dts/stih407-clock.dtsi               |  39 ++
 arch/arm/boot/dts/stih407-pinctrl.dtsi             | 615 +++++++++++++++++
 arch/arm/boot/dts/stih407.dtsi                     | 263 ++++++++
 arch/arm/boot/dts/stih415-b2000.dts                |   2 +-
 arch/arm/boot/dts/stih415-b2020.dts                |   2 +-
 arch/arm/boot/dts/stih415-clock.dtsi               | 519 ++++++++++++++-
 arch/arm/boot/dts/stih415-pinctrl.dtsi             |  16 +
 arch/arm/boot/dts/stih415.dtsi                     |  30 +-
 arch/arm/boot/dts/stih416-b2000.dts                |   3 +-
 arch/arm/boot/dts/stih416-b2020-revE.dts           |  35 +
 arch/arm/boot/dts/stih416-b2020.dts                |   3 +-
 arch/arm/boot/dts/stih416-clock.dtsi               | 735 ++++++++++++++++++++-
 arch/arm/boot/dts/stih416-pinctrl.dtsi             |  16 +
 arch/arm/boot/dts/stih416.dtsi                     |  30 +-
 arch/arm/boot/dts/stih41x-b2000.dtsi               |  25 +-
 arch/arm/boot/dts/stih41x-b2020.dtsi               |   2 +-
 arch/arm/boot/dts/stih41x.dtsi                     |   7 +
 drivers/reset/sti/reset-stih415.c                  |   1 +
 drivers/reset/sti/reset-stih416.c                  |   1 +
 include/dt-bindings/clock/stih415-clks.h           |  15 +
 include/dt-bindings/clock/stih416-clks.h           |  15 +
 .../dt-bindings/reset-controller/stih415-resets.h  |   1 +
 .../dt-bindings/reset-controller/stih416-resets.h  |   1 +
 25 files changed, 2397 insertions(+), 65 deletions(-)
 create mode 100644 arch/arm/boot/dts/stih407-b2120.dts
 create mode 100644 arch/arm/boot/dts/stih407-clock.dtsi
 create mode 100644 arch/arm/boot/dts/stih407-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stih407.dtsi
 create mode 100644 arch/arm/boot/dts/stih416-b2020-revE.dts
 create mode 100644 include/dt-bindings/clock/stih415-clks.h
 create mode 100644 include/dt-bindings/clock/stih416-clks.h
