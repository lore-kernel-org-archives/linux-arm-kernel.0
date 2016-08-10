From: patrice.chotard@st.com (Patrice Chotard)
Date: Wed, 10 Aug 2016 18:49:25 +0200
Subject: [GIT PULL] STi defconfig updates for v4.9
Message-ID: <e0cf33d1-0d96-9eed-1155-c9dc7f4de1b8@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STi DT updates for v4.9:


The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git tags/sti-dt-for-v4.9-1

for you to fetch changes up to 7aff2168d65e84c4a5178a32ae4e8d474eff2090:

  ARM: dts: STi: Introduce B2260 board (2016-08-10 18:23:29 +0200)

----------------------------------------------------------------

STi dts fixes and new STi 96board support:

Add thermal node for STiH407 family boards
Add specific nodes for STMicroelectronics 96Board
Add new B2260 STi board file = 96Board
Fix ahci issue on STiH407 family
Fix debugfs/pinctrl kernel warning

----------------------------------------------------------------
Patrice Chotard (7):
      ARM: dts: STiH407: Move pio20 node to fix kernel warning
      ARM: dts: STiH410: Add thermal node
      ARM: dts: STiH407-pinctrl: Add i2c2_alt2_1 node
      ARM: dts: STiH407: Move non-removable property to board file
      ARM: dts: STiH407-pinctrl: Add pinctrl_rgmii1_mdio_1 node
      ARM: dts: STiH407-family: Add ports-implemented property in sata nodes
      ARM: dts: STi: Introduce B2260 board

 arch/arm/boot/dts/Makefile             |   1 +
 arch/arm/boot/dts/stih407-family.dtsi  |   5 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi |  31 ++++--
 arch/arm/boot/dts/stih410-b2260.dts    | 190 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stih410.dtsi         |   8 ++
 arch/arm/boot/dts/stih418-b2199.dts    |   1 +
 arch/arm/boot/dts/stihxxx-b2120.dtsi   |   1 +
 7 files changed, 227 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/stih410-b2260.dts
