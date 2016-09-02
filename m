From: patrice.chotard@st.com (Patrice Chotard)
Date: Fri, 2 Sep 2016 15:58:00 +0200
Subject: [GIT PULL] STi DT updates for v4.9
Message-ID: <c83fda3c-5120-a55b-dfb0-f550cbaf777a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STi DT updates for v4.9:


The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git

for you to fetch changes up to ba5ba11906d5462993f5fd4e3da4d234505427a0:

  ARM: dts: STiH41x-b2020: Update gpio specifier (2016-09-02 15:15:14 +0200)

----------------------------------------------------------------

STi dts fixes and new STi 96board support:

Add thermal node for STiH407 family boards
Add specific nodes for STMicroelectronics 96Board
Add new B2260 STi board file = 96Board
Fix ahci issue on STiH407 family
Fix debugfs/pinctrl kernel warning
Update gpio-cells and gpio specifier

----------------------------------------------------------------
Patrice Chotard (10):
      ARM: dts: STiH407: Move pio20 node to fix kernel warning
      ARM: dts: STiH410: Add thermal node
      ARM: dts: STiH407-pinctrl: Add i2c2_alt2_1 node
      ARM: dts: STiH407: Move non-removable property to board file
      ARM: dts: STiH407-pinctrl: Add pinctrl_rgmii1_mdio_1 node
      ARM: dts: STiH407-family: Add ports-implemented property in sata nodes
      ARM: dts: STi: Introduce B2260 board
      ARM: dts: STiH407-pinctrl: Update gpio-cells to 2
      ARM: dts: STiH418-B2199: Update gpio specifier
      ARM: dts: STiH41x-b2020: Update gpio specifier

 arch/arm/boot/dts/Makefile             |   1 +
 arch/arm/boot/dts/stih407-family.dtsi  |   5 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi |  82 ++++++++------
 arch/arm/boot/dts/stih410-b2260.dts    | 190 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stih410.dtsi         |   8 ++
 arch/arm/boot/dts/stih418-b2199.dts    |   8 +-
 arch/arm/boot/dts/stih41x-b2020.dtsi   |   6 +-
 arch/arm/boot/dts/stihxxx-b2120.dtsi   |   1 +
 8 files changed, 259 insertions(+), 42 deletions(-)
 create mode 100644 arch/arm/boot/dts/stih410-b2260.dts
