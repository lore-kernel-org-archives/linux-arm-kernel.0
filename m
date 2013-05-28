From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 May 2013 14:42:18 -0400
Subject: [GIT PULL] ARM: mvebu: dt changes for v3.11 (round 3 cumulative)
Message-ID: <20130528184218.GE31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/dt-3.11-3

for you to fetch changes up to 9196024a989ace933d6b17e0a56c847d02d81240:

  arm: kirkwood: openblocks-a6: add support for Init button (2013-05-27 15:35:04 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.11 (round 3)

 - mvebu
    - enable two usb interfaces on Armada XP-GP

 - kirkwood
    - move pinmux configs to their individual devices
    - group the pinmux configs on OpenBlocks A6
    - add the Init button for the OpenBlocks A6

----------------------------------------------------------------
Ezequiel Garcia (1):
      ARM: mvebu: Add support for NOR flash device on Armada XP-DB board

Sebastian Hesselbarth (1):
      ARM: dove: add si5351 clock driver to CuBox DT

Simon Baatz (2):
      ARM: mvebu: Use standard MMC binding for all users of mvsdio
      ARM: Kirkwood: Add dts files for Sheevaplug and eSATA Sheevaplug

Thomas Petazzoni (23):
      arm: mvebu: enable the third USB interface on OpenBlocks AX3
      arm: mvebu: enable two USB interfaces on the Armada XP GP board
      arm: kirkwood: cloudbox: move pinmux configs to the right devices
      arm: kirkwood: dlink dns: move pinmux configs to the right devices
      arm: kirkwood: dockstar: move pinmux configs to the right devices
      arm: kirkwood: dreamplug: move pinmux configs to the right devices
      arm: kirkwood: goflexnet: move pinmux configs to the right devices
      arm: kirkwood: guruplug: move pinmux configs to the right devices
      arm: kirkwood: ib62x0: move pinmux configs to the right devices
      arm: kirkwood: iconnect: give meaningful names to pinmux configs
      arm: kirkwood: iconnect: move pinmux configs to the right devices
      arm: kirkwood: iomega ix2-200: move pinmux configs to the right devices
      arm: kirkwood: ns2: move pinmux configs to the right devices
      arm: kirkwood: keymile: move pinmux configs to the right devices
      arm: kirkwood: buffalo linkstation: move pinmux configs to the right devices
      arm: kirkwood: mplcec4: move pinmux configs to the right devices
      arm: kirkwood: readynas: move pinmux configs to the right devices
      arm: kirkwood: nsa310: move pinmux configs to the right devices
      arm: kirkwood: openblocks_a6: move pinmux configs to the right devices
      arm: kirkwood: topkick: move pinmux configs to the right devices
      arm: kirkwood: ts219: move pinmux configs to the right devices
      arm: kirkwood: openblocks-a6: group pinmux configurations
      arm: kirkwood: openblocks-a6: add support for Init button

 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/armada-370-db.dts                |   1 +
 arch/arm/boot/dts/armada-370-mirabox.dts           |   1 +
 arch/arm/boot/dts/armada-370-rd.dts                |   1 +
 arch/arm/boot/dts/armada-370-xp.dtsi               |   4 +
 arch/arm/boot/dts/armada-xp-db.dts                 |  33 +++++++
 arch/arm/boot/dts/armada-xp-gp.dts                 |  10 ++
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |   9 ++
 arch/arm/boot/dts/dove-cubox.dts                   |  51 +++++++++-
 arch/arm/boot/dts/kirkwood-cloudbox.dts            |  10 +-
 arch/arm/boot/dts/kirkwood-dns320.dts              |   7 ++
 arch/arm/boot/dts/kirkwood-dns325.dts              |   5 +
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |  32 +++---
 arch/arm/boot/dts/kirkwood-dockstar.dts            |   9 +-
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |  12 +--
 arch/arm/boot/dts/kirkwood-goflexnet.dts           |  18 ++--
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |  10 +-
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |  17 ++--
 arch/arm/boot/dts/kirkwood-iconnect.dts            |  36 +++----
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |  15 +--
 arch/arm/boot/dts/kirkwood-is2.dts                 |   2 +
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |   6 +-
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               |  22 +++--
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |  25 ++---
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |  22 ++---
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |  10 +-
 arch/arm/boot/dts/kirkwood-ns2.dts                 |   2 +
 arch/arm/boot/dts/kirkwood-ns2lite.dts             |   2 +
 arch/arm/boot/dts/kirkwood-ns2max.dts              |   2 +
 arch/arm/boot/dts/kirkwood-ns2mini.dts             |   2 +
 arch/arm/boot/dts/kirkwood-nsa310.dts              |  29 +++---
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       | 108 ++++++---------------
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi  |  97 ++++++++++++++++++
 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts    |  40 ++++++++
 arch/arm/boot/dts/kirkwood-sheevaplug.dts          |  45 +++++++++
 arch/arm/boot/dts/kirkwood-topkick.dts             |  52 +++++-----
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |   8 +-
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |   8 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |  10 ++
 arch/arm/boot/dts/kirkwood.dtsi                    |   4 +
 40 files changed, 537 insertions(+), 242 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-sheevaplug.dts
