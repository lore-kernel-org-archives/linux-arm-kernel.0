From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 24 Nov 2012 05:11:09 +0000
Subject: [GIT PULL 3/5] ARM: orion: boards for v3.8
In-Reply-To: <pull-1353733874-990435>
Message-ID: <mailman.9.1353733904.1035.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:

  Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/orion_boards_for_3.8

for you to fetch changes up to f17073a3aec601cb9aba6d8c1c6dbc8c6a919c07:

  ARM: kirkwood: Add Plat'Home OpenBlocks A6 support (2012-11-22 07:01:51 +0000)

----------------------------------------------------------------
orion boards for v3.8

 - mach-orion5x/ joins the dark side! (devicetree)
 - Lacie Network Space family
 - Lacie Ethernet Disk mini v2
 - USI TopKick
 - ZyXEL NSA310
 - MPL CEC4
 - Plat'Home OpenBlocks A6 (kirkwood, AX3-4 is armada xp)

----------------------------------------------------------------
Jason Cooper (3):
      ARM: Kirkwood: add Netspace boards to defconfig
      ARM: Kirkwood: new board USI Topkick
      ARM: Kirkwood: update defconfig for new boards

Jason Gunthorpe (1):
      ARM: Kirkwood: Enable the second I2C bus

Michael Walle (1):
      ARM: kirkwood: use gpio-fan DT binding on lsxl

Nobuhiro Iwamatsu (1):
      ARM: kirkwood: Add Plat'Home OpenBlocks A6 support

Sebastian Hesselbarth (1):
      ARM: Dove: update defconfig

Simon Guinot (4):
      leds: leds-ns2: add device tree binding
      ARM: kirkwood: DT board setup for Network Space v2 and parents
      ARM: kirkwood: DT board setup for Network Space Lite v2
      ARM: kirkwood: DT board setup for Network Space Mini v2

Stefan Peter (1):
      ARM: kirkwood: Add support for the MPL CEC4

Tero Jaasko (1):
      arm: kirkwood: add support for ZyXEL NSA310

Thomas Petazzoni (4):
      arm: orion5x: mechanical defconfig update
      arm: orion5x: basic Device Tree support
      arm: orion5x: convert 'LaCie Ethernet Disk mini v2' to Device Tree
      arm: orion5x: add DT related options in defconfig

 .../devicetree/bindings/gpio/leds-ns2.txt          |  26 ++++
 arch/arm/boot/dts/Makefile                         |  12 +-
 arch/arm/boot/dts/kirkwood-is2.dts                 |  30 +++++
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               |  11 ++
 arch/arm/boot/dts/kirkwood-mplcec4.dts             | 119 +++++++++++++++++
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |  63 +++++++++
 arch/arm/boot/dts/kirkwood-ns2.dts                 |  30 +++++
 arch/arm/boot/dts/kirkwood-ns2lite.dts             |  30 +++++
 arch/arm/boot/dts/kirkwood-ns2max.dts              |  49 +++++++
 arch/arm/boot/dts/kirkwood-ns2mini.dts             |  49 +++++++
 arch/arm/boot/dts/kirkwood-nsa310.dts              | 144 +++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |  39 ++++++
 arch/arm/boot/dts/kirkwood-topkick.dts             |  85 ++++++++++++
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |  55 ++++++++
 arch/arm/boot/dts/orion5x.dtsi                     |  98 ++++++++++++++
 arch/arm/configs/dove_defconfig                    |  24 ++++
 arch/arm/configs/kirkwood_defconfig                |   9 ++
 arch/arm/configs/orion5x_defconfig                 |  36 ++----
 arch/arm/mach-kirkwood/Kconfig                     |  65 ++++++++++
 arch/arm/mach-kirkwood/Makefile                    |   9 ++
 arch/arm/mach-kirkwood/board-dt.c                  |  30 +++++
 arch/arm/mach-kirkwood/board-lsxl.c                |  51 --------
 arch/arm/mach-kirkwood/board-mplcec4.c             |  80 ++++++++++++
 arch/arm/mach-kirkwood/board-ns2.c                 |  87 +++++++++++++
 arch/arm/mach-kirkwood/board-nsa310.c              | 105 +++++++++++++++
 arch/arm/mach-kirkwood/board-openblocks_a6.c       |  71 ++++++++++
 arch/arm/mach-kirkwood/board-usi_topkick.c         |  82 ++++++++++++
 arch/arm/mach-kirkwood/common.c                    |   1 +
 arch/arm/mach-kirkwood/common.h                    |  34 +++++
 arch/arm/mach-orion5x/Kconfig                      |  14 +-
 arch/arm/mach-orion5x/Makefile                     |   4 +-
 arch/arm/mach-orion5x/board-dt.c                   |  79 +++++++++++
 arch/arm/mach-orion5x/common.c                     |   4 +-
 arch/arm/mach-orion5x/common.h                     |   9 ++
 arch/arm/mach-orion5x/edmini_v2-setup.c            |  88 +------------
 drivers/leds/Kconfig                               |   4 +-
 drivers/leds/leds-ns2.c                            |  78 ++++++++++-
 37 files changed, 1630 insertions(+), 174 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/leds-ns2.txt
 create mode 100644 arch/arm/boot/dts/kirkwood-is2.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-mplcec4.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ns2-common.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-ns2.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ns2lite.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ns2max.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ns2mini.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-nsa310.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-openblocks_a6.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-topkick.dts
 create mode 100644 arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
 create mode 100644 arch/arm/boot/dts/orion5x.dtsi
 create mode 100644 arch/arm/mach-kirkwood/board-mplcec4.c
 create mode 100644 arch/arm/mach-kirkwood/board-ns2.c
 create mode 100644 arch/arm/mach-kirkwood/board-nsa310.c
 create mode 100644 arch/arm/mach-kirkwood/board-openblocks_a6.c
 create mode 100644 arch/arm/mach-kirkwood/board-usi_topkick.c
 create mode 100644 arch/arm/mach-orion5x/board-dt.c
