From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 1 Dec 2013 16:13:41 -0500
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.14
Message-ID: <20131201211341.GX2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Another round of small changes that have been in -next for a week or so.

thx,

Jason.


The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.14

for you to fetch changes up to bd22bb23919e6727967e90eb89bb41ab790bcd2d:

  ARM: Dove: Add RTC interrupt via PMU interrupt controller. (2013-11-26 16:10:49 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.14

 - mvebu:
    - remove unneeded OS-specific properties from led nodes
    - add NAND controller to Armada boards
    - add sata leds to readynas 104
    - add gpio-poweroff to readynas duo v2

 - kirkwood:
    - comment cleanup in sheevaplug files
    - default pinctrl for sdio
    - sdio in guruplug is non-removable

 - orion5x:
    - typo fix

 - dove:
    - typo fix
    - add PMU interrupt controller and RTC interrupt via same

----------------------------------------------------------------
Andrew Lunn (2):
      ARM: Dove: Add DT node for PMU interrupt controller.
      ARM: Dove: Add RTC interrupt via PMU interrupt controller.

Arnaud Ebalard (2):
      ARM: mvebu: Add RN104 SATA LEDs driven via NXP PCA9554 I2C to GPIO muxer
      ARM: mvebu: Add DT entry for ReadyNAS Duo v2 to use gpio-poweroff driver

Ezequiel Garcia (3):
      ARM: mvebu: Add support for NAND controller in Armada 370/XP
      ARM: mvebu: Enable NAND controller in Armada XP GP board
      ARM: mvebu: Enable NAND controller in Armada 370 Mirabox

Jason Cooper (1):
      ARM: mvebu: dts: remove unneeded linux,default-state from led nodes

Sebastian Hesselbarth (2):
      ARM: kirkwood: provide pinctrl default to sdio nodes
      ARM: kirkwood: mark guruplug sdio as non-removable

Simon Baatz (1):
      ARM: kirkwood: Cleanup comments in Sheevaplug dts files

Srinivas Kandagatla (2):
      ARM: orion5x: Fix typo in device_type property of phy node
      ARM: dove: Fix typo in device_type property of phy node

 arch/arm/boot/dts/armada-370-mirabox.dts           | 25 +++++++++++++++--
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |  2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     | 32 ++++++++++++++++++++++
 arch/arm/boot/dts/armada-370-xp.dtsi               |  9 ++++++
 arch/arm/boot/dts/armada-xp-gp.dts                 |  8 ++++++
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  3 +-
 arch/arm/boot/dts/dove-cubox.dts                   |  2 +-
 arch/arm/boot/dts/dove.dtsi                        | 13 ++++++++-
 arch/arm/boot/dts/kirkwood-6281.dtsi               |  2 ++
 arch/arm/boot/dts/kirkwood-6282.dtsi               |  2 ++
 arch/arm/boot/dts/kirkwood-dns320.dts              |  2 +-
 arch/arm/boot/dts/kirkwood-dns325.dts              |  2 +-
 arch/arm/boot/dts/kirkwood-dockstar.dts            |  2 +-
 arch/arm/boot/dts/kirkwood-goflexnet.dts           |  2 +-
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |  4 +--
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |  2 +-
 arch/arm/boot/dts/kirkwood-iconnect.dts            |  4 +--
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |  2 +-
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               |  2 +-
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  | 14 +++++++++-
 arch/arm/boot/dts/kirkwood-ns2lite.dts             |  2 +-
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi  |  2 +-
 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts    |  2 +-
 arch/arm/boot/dts/kirkwood-sheevaplug.dts          |  4 +--
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |  2 +-
 25 files changed, 121 insertions(+), 25 deletions(-)
