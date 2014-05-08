From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 8 May 2014 11:54:19 -0400
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.16
Message-ID: <20140508155419.GF12708@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

guys,

this is a rather large one for us.  Lots of stuff going on with the new
Armada SoCs, cleanup in kirkwood to better support barebox, etc.  These
have been in -next for a while.

Please pull.

thx,

Jason.


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.16

for you to fetch changes up to 191825c38eafeda033a73338f5a710fa6fd5b3d6:

  ARM: Kirkwood: t5325: Use simple card to instantiate audio (2014-05-05 01:18:45 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.16

 - kirkwood
    - rework nsa3x0 board to add nsa320
    - large cleanup to facilitate use in barebox
    - guruplug phy updates
    - audio updates for t5325

 - mvebu
    - use clocks vice clock-frequency for uart nodes

    - armada 375/380/385
       - add watchdog node
       - add coherency fabric
       - add smp support
       - add sdhci
       - add ahci
       - add thermal sensor

    - armada 370/XP
       - and pmsu

----------------------------------------------------------------
Adam Baker (3):
      ARM: kirkwood: Move NSA310 common parts to include file
      ARM: kirkwood: Add DTS file for NSA320
      ARM: kirkwood: rename kirwood-nsa310-common to 3x0-common

Andrew Lunn (3):
      ARM: Kirkwood: Add node for audio codec
      ARM: Kirkwood: DT: Add missing #sound-dai-cells property
      ARM: Kirkwood: t5325: Use simple card to instantiate audio

Ezequiel Garcia (4):
      ARM: mvebu: Enable Armada 375 watchdog in the devicetree
      ARM: mvebu: Enable Armada 380/385 watchdog in the devicetree
      ARM: mvebu: Enable the thermal sensor in Armada 375 SoC
      ARM: mvebu: Enable the thermal sensor in Armada 380/385 SoC

Gregory CLEMENT (2):
      ARM: mvebu: switch to the new PMSU binding in Armada 370/XP Device Tree
      ARM: mvebu: add SMP support in the Armada 375 device tree

Sebastian Hesselbarth (14):
      ARM: dts: kirkwood: add node labels
      ARM: dts: kirkwood: add stdout-path property to all boards
      ARM: dts: kirkwood: remove clock-frequency properties from UART nodes
      ARM: dts: kirkwood: rename pin-controller nodes
      ARM: dts: kirkwood: add pinctrl node to common SoC include
      ARM: dts: kirkwood: consolidate common pinctrl settings
      ARM: dts: kirkwood: set default pinctrl for GBE1
      ARM: dts: kirkwood: set default pinctrl for UART0/1
      ARM: dts: kirkwood: set default pinctrl for SPI0
      ARM: dts: kirkwood: set default pinctrl for NAND
      ARM: dts: kirkwood: set default pinctrl for I2C0
      ARM: dts: kirkwood: set default pinctrl for I2C1 on 6282
      ARM: dts: kirkwood: set Guruplug ethernet PHY compatible
      ARM: dts: kirkwood: set Guruplug phy-connection-type to rgmii-id

Thomas Petazzoni (9):
      ARM: mvebu: enable the coherency fabric on Armada 375
      ARM: mvebu: enable the coherency fabric on Armada 38x
      ARM: mvebu: add enable-method property for CPUs
      ARM: mvebu: add SMP support in the Armada 38x device tree
      ARM: mvebu: enable the SDHCI interface on Armada 385
      ARM: mvebu: add Device Tree description of AHCI interfaces on Armada 38x
      ARM: mvebu: use clocks property for serial ports
      ARM: mvebu: remove clock-frequency of serial port Device Tree nodes
      ARM: mvebu: don't use clocks property in UART node for Netgear RN2120

 arch/arm/boot/dts/armada-370-db.dts                |   1 -
 arch/arm/boot/dts/armada-370-mirabox.dts           |   1 -
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |   1 -
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |   1 -
 arch/arm/boot/dts/armada-370-rd.dts                |   1 -
 arch/arm/boot/dts/armada-370-xp.dtsi               |   7 +
 arch/arm/boot/dts/armada-370.dtsi                  |   5 +
 arch/arm/boot/dts/armada-375-db.dts                |   1 -
 arch/arm/boot/dts/armada-375.dtsi                  |  31 +++
 arch/arm/boot/dts/armada-380.dtsi                  |   2 +
 arch/arm/boot/dts/armada-385-db.dts                |  17 +-
 arch/arm/boot/dts/armada-385-rd.dts                |   1 -
 arch/arm/boot/dts/armada-385.dtsi                  |   2 +
 arch/arm/boot/dts/armada-38x.dtsi                  |  60 ++++++
 arch/arm/boot/dts/armada-xp-axpwifiap.dts          |   2 -
 arch/arm/boot/dts/armada-xp-db.dts                 |   4 -
 arch/arm/boot/dts/armada-xp-gp.dts                 |   4 -
 arch/arm/boot/dts/armada-xp-matrix.dts             |   4 -
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   1 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   1 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   1 +
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |   1 -
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |   2 -
 arch/arm/boot/dts/armada-xp.dtsi                   |   8 +-
 arch/arm/boot/dts/kirkwood-6192.dtsi               |  35 +---
 arch/arm/boot/dts/kirkwood-6281.dtsi               |  35 +---
 arch/arm/boot/dts/kirkwood-6282.dtsi               |  48 ++---
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi           |  25 +--
 arch/arm/boot/dts/kirkwood-b3.dts                  |   7 +-
 arch/arm/boot/dts/kirkwood-cloudbox.dts            |   8 +-
 arch/arm/boot/dts/kirkwood-db.dtsi                 |  10 +-
 arch/arm/boot/dts/kirkwood-dns320.dts              |   3 +-
 arch/arm/boot/dts/kirkwood-dns325.dts              |   1 +
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   4 +-
 arch/arm/boot/dts/kirkwood-dockstar.dts            |   3 +-
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |   5 +-
 arch/arm/boot/dts/kirkwood-ds109.dts               |   1 +
 arch/arm/boot/dts/kirkwood-ds110jv10.dts           |   1 +
 arch/arm/boot/dts/kirkwood-ds111.dts               |   1 +
 arch/arm/boot/dts/kirkwood-ds112.dts               |   1 +
 arch/arm/boot/dts/kirkwood-ds209.dts               |   1 +
 arch/arm/boot/dts/kirkwood-ds210.dts               |   1 +
 arch/arm/boot/dts/kirkwood-ds212.dts               |   1 +
 arch/arm/boot/dts/kirkwood-ds212j.dts              |   1 +
 arch/arm/boot/dts/kirkwood-ds409.dts               |   1 +
 arch/arm/boot/dts/kirkwood-ds409slim.dts           |   1 +
 arch/arm/boot/dts/kirkwood-ds411.dts               |   1 +
 arch/arm/boot/dts/kirkwood-ds411j.dts              |   1 +
 arch/arm/boot/dts/kirkwood-ds411slim.dts           |   1 +
 arch/arm/boot/dts/kirkwood-goflexnet.dts           |   3 +-
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |  14 +-
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |   5 +-
 arch/arm/boot/dts/kirkwood-iconnect.dts            |   3 +-
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |   3 +-
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |   7 +-
 arch/arm/boot/dts/kirkwood-laplug.dts              |   8 +-
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               |   3 +-
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |  19 +-
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     |  10 +-
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |   5 +-
 .../boot/dts/kirkwood-netgear_readynas_nv+_v2.dts  |   5 +-
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |   9 +-
 arch/arm/boot/dts/kirkwood-nsa310.dts              |  53 +----
 arch/arm/boot/dts/kirkwood-nsa310a.dts             |  57 +-----
 arch/arm/boot/dts/kirkwood-nsa320.dts              | 215 +++++++++++++++++++++
 ...310-common.dtsi => kirkwood-nsa3x0-common.dtsi} |  60 +++++-
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |  15 +-
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts       |  24 +--
 arch/arm/boot/dts/kirkwood-rd88f6192.dts           |   5 +-
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi          |   3 +-
 arch/arm/boot/dts/kirkwood-rs212.dts               |   1 +
 arch/arm/boot/dts/kirkwood-rs409.dts               |   1 +
 arch/arm/boot/dts/kirkwood-rs411.dts               |   1 +
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi  |   7 +-
 arch/arm/boot/dts/kirkwood-synology.dtsi           |  10 +-
 arch/arm/boot/dts/kirkwood-t5325.dts               |  37 +++-
 arch/arm/boot/dts/kirkwood-topkick.dts             |  13 +-
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |   2 +-
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |   2 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |  11 +-
 arch/arm/boot/dts/kirkwood-ts419.dtsi              |   2 +-
 arch/arm/boot/dts/kirkwood.dtsi                    |  75 ++++++-
 82 files changed, 627 insertions(+), 417 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-nsa320.dts
 rename arch/arm/boot/dts/{kirkwood-nsa310-common.dtsi => kirkwood-nsa3x0-common.dtsi} (58%)
