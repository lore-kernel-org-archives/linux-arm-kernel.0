From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Mon, 26 Feb 2018 08:32:25 +0000
Subject: [GIT PULL] STi DT update for v4.17 round 1
Message-ID: <e30ac9b4-253c-106d-4ea5-604ec3eeb953@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof

PLease consider this first round of STi dts update for v4.17 :

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git

for you to fetch changes up to 0e04ce02e6a2ac30d21294d8bb2aeceb8489e52b:

   ARM: dts: STi: Remove unused clk_ext2f_a9 clock (2018-02-13 13:31:38 
+0100)

----------------------------------------------------------------
warn: You locally have sti-dt-for-v4.17-round1 but it does not (yet)
warn: appear to be at 
git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
warn: Do you want to push it there, perhaps?
warning: refname 'sti-dt-for-v4.17-round1' is ambiguous.
STi dts update:

Fix all DT dtc warnings when building with W=1
For most of implicated node, the addition of a fake reg property
fixes these warnings.
For others nodes, their location in device tree
have been updated.

----------------------------------------------------------------
Patrice Chotard (11):
       ARM: dts: STi: Fix bindings notation
       ARM: dts: STi: Move leds node outside soc node
       ARM: dts: STi: Add fake reg property for sti-display-subsystem
       ARM: dts: STi: Add fake reg property for miphy28lp_phy
       ARM: dts: STi: Add fake reg property for irq-syscfg
       ARM: dts: STi: Add fake reg property for remote processors
       ARM: dts: STi: Add fake reg for restart, powerdown and 
picophy/softreset
       ARM: dts: STi: Add fake reg property for usb2_picophyX nodes
       ARM: dts: STi: Update sound related nodes location
       ARM: dts: STi: Update clocks node location
       ARM: dts: STi: Remove unused clk_ext2f_a9 clock

  arch/arm/boot/dts/stih407-b2120.dts    |   2 +-
  arch/arm/boot/dts/stih407-clock.dtsi   |  92 +++++++++++-------------
  arch/arm/boot/dts/stih407-family.dtsi  |  42 ++++++-----
  arch/arm/boot/dts/stih407-pinctrl.dtsi |  10 +--
  arch/arm/boot/dts/stih407.dtsi         |   4 +-
  arch/arm/boot/dts/stih410-b2120.dts    |   8 +--
  arch/arm/boot/dts/stih410-b2260.dts    |  89 ++++++++++++-----------
  arch/arm/boot/dts/stih410-clock.dtsi   |  96 +++++++++++--------------
  arch/arm/boot/dts/stih410-pinctrl.dtsi |   2 +-
  arch/arm/boot/dts/stih410.dtsi         |  13 ++--
  arch/arm/boot/dts/stih418-b2199.dts    |  30 ++++----
  arch/arm/boot/dts/stih418-clock.dtsi   |  95 +++++++++++--------------
  arch/arm/boot/dts/stih418.dtsi         |   6 +-
  arch/arm/boot/dts/stihxxx-b2120.dtsi   | 126 
+++++++++++++++++----------------
  14 files changed, 300 insertions(+), 315 deletions(-)
