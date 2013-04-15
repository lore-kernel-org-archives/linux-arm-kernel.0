From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 15 Apr 2013 14:50:18 -0400
Subject: [GIT PULL 4/4] mvebu dt for v3.10
Message-ID: <20130415185018.GR28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit c3117edec5f92cce39f2d220c62f76675397af8d:

  Dove: Thermal: Add DT node and enable in defconfig (2013-03-12 11:33:22 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/dt-3.10-3

for you to fetch changes up to 513a7917b13370d9fbc41331413428dd713cb3fc:

  arm: mvebu: PCIe Device Tree informations for Armada XP GP (2013-04-15 14:53:53 +0000)

----------------------------------------------------------------
mvebu dt for v3.10 round 3

 - mvebu PCIe DT support

from round 2 (no pr was sent):
 - 64bit dts skeleton
 - mvebu devicebus additions
 - mvebu thermal nodes
 - mirabox gpio leds
 - orion5x xor and ehci
 - use mvsdio on guruplug dt

----------------------------------------------------------------
Alexander Clouter (2):
      arm: orion5x: add ehci bindings to dtsi
      arm: orion5x: enable xor for orion5x platform

Ezequiel Garcia (8):
      ARM: mvebu: Add button on Armada 370 Reference Design board
      ARM: mvebu: Add thermal support to Armada XP device tree
      ARM: mvebu: Add thermal support to Armada 370 device tree
      ARM: configs: Update mvebu defconfig for thermal
      ARM: mvebu: Add Device Bus support for Armada 370/XP SoC
      ARM: mvebu: Add support for NOR flash device on Armada XP-GP board
      ARM: mvebu: Add support for NOR flash device on Openblocks AX3 board
      ARM: mvebu: Add Device Bus and CFI flash memory support to defconfig

Lior Amsalem (1):
      ARM: dts: Add a 64 bits version of the skeleton device tree

Ryan Press (1):
      arm: mvebu: Add GPIO LEDs to Mirabox board

Sebastian Hesselbarth (1):
      ARM: kirkwood: make use of DT mvsdio on guruplug board

Thomas Petazzoni (7):
      arm: mvebu: add PCIe Device Tree informations for Armada 370
      arm: mvebu: add PCIe Device Tree informations for Armada XP
      arm: mvebu: PCIe Device Tree informations for OpenBlocks AX3-4
      arm: mvebu: PCIe Device Tree informations for Armada XP DB
      arm: mvebu: PCIe Device Tree informations for Armada 370 Mirabox
      arm: mvebu: PCIe Device Tree informations for Armada 370 DB
      arm: mvebu: PCIe Device Tree informations for Armada XP GP

 arch/arm/boot/dts/armada-370-db.dts                |  17 ++
 arch/arm/boot/dts/armada-370-mirabox.dts           |  53 ++++++
 arch/arm/boot/dts/armada-370-rd.dts                |  11 ++
 arch/arm/boot/dts/armada-370-xp.dtsi               |  45 +++++
 arch/arm/boot/dts/armada-370.dtsi                  |  58 +++++++
 arch/arm/boot/dts/armada-xp-db.dts                 |  33 ++++
 arch/arm/boot/dts/armada-xp-gp.dts                 |  50 ++++++
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           | 104 ++++++++++++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           | 122 +++++++++++++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           | 188 +++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  38 +++++
 arch/arm/boot/dts/armada-xp.dtsi                   |   6 +
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |   4 +
 arch/arm/boot/dts/orion5x.dtsi                     |  33 ++++
 arch/arm/boot/dts/skeleton64.dtsi                  |  13 ++
 arch/arm/configs/mvebu_defconfig                   |   9 +
 arch/arm/mach-kirkwood/board-guruplug.c            |   6 -
 17 files changed, 784 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/skeleton64.dtsi
