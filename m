From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 24 Nov 2012 05:11:11 +0000
Subject: [GIT PULL 4/5] ARM: orion: dt for v3.8
In-Reply-To: <pull-1353733874-990435>
Message-ID: <mailman.10.1353733916.1035.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:

  Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/orion_dt_for_3.8

for you to fetch changes up to 2a18588c0ce336933be3c99c91e74e21db56a0fe:

  ARM: Kirkwood: remove kirkwood_ehci_init() from new boards (2012-11-24 03:58:12 +0000)

----------------------------------------------------------------
orion dt for v3.8

 - ehci-orion dt binding
 - gpio-poweroff
 - use dt regulators
 - move mpp to DT/pinctrl

Depends on:

 - orion/boards

    - merge conflicts
       - keep all 'select's in Kconfig
       - remove all #includes in board-*.c

 - pinctrl/devel up to:

    - 06763c7 pinctrl: mvebu: move to its own directory

----------------------------------------------------------------
Andrew Lunn (21):
      ARM: Kirkwood: ehci-orion: Add device tree binding
      ARM: Kirkwood: Convert all DT boards to EHCI via DT.
      ARM: Kirkwood: Convert DNSKW to use gpio-poweroff.
      ARM: Kirkwood: Convert IB62x0 to use gpio-poweroff.
      ARM: Kirkwood: Enable regulator and fixed regulators.
      ARM: Kirkwood: Convert DNSKW to use regulators
      ARM: Kirkwood: Convert Dockstar to use regulators
      ARM: Kirkwood: Convert GoFlexNet to use regulators
      ARM: Kirkwood: Convert LSXL to use regulators
      GPIO: mvebu: Allow all plat-orion platforms.
      ARM: Kirkwood: Make use of mvebu pincltl and gpio drivers
      ARM: Kirkwood: Add DTSI files for pinctrl
      ARM: Kirkwood: Convert TS219 to pinctrl.
      ARM: Kirkwood: Convert iConnect to pinctrl.
      ARM: Kirkwood: Convert dnskw to pinctrl
      ARM: Kirkwood: Convert dockstar to pinctrl.
      ARM: Kirkwood: Convert dreamplug to pinctrl.
      ARM: Kirkwood: Convert GoFlex Net to pinctrl.
      ARM: Kirkwood: Convert ib62x0 to pinctrl.
      ARM: Kirkwood: Convert lsxl boards to pinctrl.
      ARM: Kirkwood: Convert IX2-200 to pinctrl.

Axel Lin (1):
      pinctrl: mvebu: Fix dove_audio1_ctrl_set function

Jamie Lentin (2):
      ARM: kirkwood: Increase NAND chip-delay for DNS-32[05]
      power: Add simple poweroff-gpio driver

Jason Cooper (5):
      ARM: Kirkwood: add Netspace boards to defconfig
      ARM: Kirkwood: new board USI Topkick
      ARM: Kirkwood: update defconfig for new boards
      Merge commit '06763c7' into orion/dt2
      ARM: Kirkwood: remove kirkwood_ehci_init() from new boards

Jason Gunthorpe (1):
      ARM: Kirkwood: Enable the second I2C bus

Linus Walleij (1):
      pinctrl: reserve pins when states are activated

Michael Walle (1):
      ARM: kirkwood: use gpio-fan DT binding on lsxl

Nobuhiro Iwamatsu (6):
      ARM: kirkwood: Add Plat'Home OpenBlocks A6 support
      ARM: kirkwood: Add support DT of second I2C bus
      ARM: kirkwood: Add support second I2C bus and RTC on OpenBlocks A6
      ARM: kirkwood: Add NAND partiton map for OpenBlocks A6
      ARM: Kirkwood: Convert to EHCI via DT for OpenBlocks A6
      ARM: Kirkwood: Add support LED of OpenBlocks A6

Sebastian Hesselbarth (4):
      ARM: Dove: update defconfig
      pinctrl: mvebu: fix iomem pointer for dove pinctrl
      ARM: Dove: Convert to DT GPIO and pinctrl
      ARM: Dove: Add CuBox pinhog for led

Simon Guinot (4):
      leds: leds-ns2: add device tree binding
      ARM: kirkwood: DT board setup for Network Space v2 and parents
      ARM: kirkwood: DT board setup for Network Space Lite v2
      ARM: kirkwood: DT board setup for Network Space Mini v2

Stefan Peter (2):
      ARM: kirkwood: Add support for the MPL CEC4
      ARM: kirkwood: Convert mplcec4 board to pinctrl

Tero Jaasko (1):
      arm: kirkwood: add support for ZyXEL NSA310

Thomas Petazzoni (7):
      pinctrl: mvebu: allow plat-orion architectures to use pinctrl-mvebu
      pinctrl: mvebu: remove useless include
      pinctrl: mvebu: move to its own directory
      arm: orion5x: mechanical defconfig update
      arm: orion5x: basic Device Tree support
      arm: orion5x: convert 'LaCie Ethernet Disk mini v2' to Device Tree
      arm: orion5x: add DT related options in defconfig

Valentin Longchamp (2):
      ARM: Kirkwood: support 98DX412x kirkwoods with pinctrl
      ARM: Kirkwood: Convert km_kirkwood to pinctrl

 .../devicetree/bindings/gpio/gpio-poweroff.txt     |  22 +
 .../devicetree/bindings/gpio/leds-ns2.txt          |  26 ++
 .../bindings/pinctrl/marvell,kirkwood-pinctrl.txt  |  39 ++
 .../devicetree/bindings/usb/ehci-orion.txt         |  15 +
 Documentation/pinctrl.txt                          |   4 +-
 arch/arm/Kconfig                                   |   4 +
 arch/arm/boot/dts/Makefile                         |  12 +-
 arch/arm/boot/dts/dove-cubox.dts                   |  10 +
 arch/arm/boot/dts/dove.dtsi                        |  19 +-
 arch/arm/boot/dts/kirkwood-6281.dtsi               |  44 ++
 arch/arm/boot/dts/kirkwood-6282.dtsi               |  45 ++
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi           |  31 ++
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              | 140 ++++++
 arch/arm/boot/dts/kirkwood-dockstar.dts            |  37 ++
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |  21 +
 arch/arm/boot/dts/kirkwood-goflexnet.dts           |  73 ++++
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |  40 ++
 arch/arm/boot/dts/kirkwood-iconnect.dts            |  51 +++
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |  89 ++++
 arch/arm/boot/dts/kirkwood-is2.dts                 |  30 ++
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |  17 +
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               | 106 +++++
 arch/arm/boot/dts/kirkwood-mplcec4.dts             | 178 ++++++++
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |  63 +++
 arch/arm/boot/dts/kirkwood-ns2.dts                 |  30 ++
 arch/arm/boot/dts/kirkwood-ns2lite.dts             |  30 ++
 arch/arm/boot/dts/kirkwood-ns2max.dts              |  49 +++
 arch/arm/boot/dts/kirkwood-ns2mini.dts             |  49 +++
 arch/arm/boot/dts/kirkwood-nsa310.dts              | 144 ++++++
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |  98 +++++
 arch/arm/boot/dts/kirkwood-topkick.dts             |  85 ++++
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |  31 ++
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |  31 ++
 arch/arm/boot/dts/kirkwood.dtsi                    |  17 +-
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |  55 +++
 arch/arm/boot/dts/orion5x.dtsi                     |  98 +++++
 arch/arm/configs/dove_defconfig                    |  24 +
 arch/arm/configs/kirkwood_defconfig                |   9 +
 arch/arm/configs/orion5x_defconfig                 |  36 +-
 arch/arm/mach-kirkwood/Kconfig                     |  70 +++
 arch/arm/mach-kirkwood/Makefile                    |   9 +
 arch/arm/mach-kirkwood/board-dnskw.c               |  54 ---
 arch/arm/mach-kirkwood/board-dockstar.c            |  16 -
 arch/arm/mach-kirkwood/board-dreamplug.c           |  15 -
 arch/arm/mach-kirkwood/board-dt.c                  |  30 ++
 arch/arm/mach-kirkwood/board-goflexnet.c           |  24 -
 arch/arm/mach-kirkwood/board-ib62x0.c              |  35 --
 arch/arm/mach-kirkwood/board-iconnect.c            |  18 -
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c      |  26 --
 arch/arm/mach-kirkwood/board-km_kirkwood.c         |  13 -
 arch/arm/mach-kirkwood/board-lsxl.c                |  79 ----
 arch/arm/mach-kirkwood/board-mplcec4.c             |  44 ++
 arch/arm/mach-kirkwood/board-ns2.c                 |  86 ++++
 arch/arm/mach-kirkwood/board-nsa310.c              | 101 +++++
 arch/arm/mach-kirkwood/board-openblocks_a6.c       |  70 +++
 arch/arm/mach-kirkwood/board-ts219.c               |  26 --
 arch/arm/mach-kirkwood/board-usi_topkick.c         |  81 ++++
 arch/arm/mach-kirkwood/common.c                    |   1 +
 arch/arm/mach-kirkwood/common.h                    |  34 ++
 arch/arm/mach-orion5x/Kconfig                      |  14 +-
 arch/arm/mach-orion5x/Makefile                     |   4 +-
 arch/arm/mach-orion5x/board-dt.c                   |  79 ++++
 arch/arm/mach-orion5x/common.c                     |   4 +-
 arch/arm/mach-orion5x/common.h                     |   9 +
 arch/arm/mach-orion5x/edmini_v2-setup.c            |  88 +---
 arch/arm/plat-orion/irq.c                          |   6 +-
 drivers/gpio/Kconfig                               |   2 +-
 drivers/leds/Kconfig                               |   4 +-
 drivers/leds/leds-ns2.c                            |  78 +++-
 drivers/pinctrl/Kconfig                            |  22 +-
 drivers/pinctrl/Makefile                           |   6 +-
 drivers/pinctrl/core.c                             |   2 +
 drivers/pinctrl/core.h                             |   2 +
 drivers/pinctrl/mvebu/Kconfig                      |  24 +
 drivers/pinctrl/mvebu/Makefile                     |   5 +
 drivers/pinctrl/{ => mvebu}/pinctrl-armada-370.c   |   0
 drivers/pinctrl/{ => mvebu}/pinctrl-armada-xp.c    |   0
 drivers/pinctrl/{ => mvebu}/pinctrl-dove.c         |  22 +-
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c           | 484 +++++++++++++++++++++
 drivers/pinctrl/{ => mvebu}/pinctrl-mvebu.c        |   1 -
 drivers/pinctrl/{ => mvebu}/pinctrl-mvebu.h        |   0
 drivers/pinctrl/pinctrl-kirkwood.c                 | 472 --------------------
 drivers/pinctrl/pinmux.c                           |  67 +--
 drivers/power/Kconfig                              |   3 +
 drivers/power/Makefile                             |   1 +
 drivers/power/reset/Kconfig                        |  15 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/gpio-poweroff.c                | 129 ++++++
 drivers/usb/host/ehci-orion.c                      |  38 +-
 89 files changed, 3321 insertions(+), 995 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/leds-ns2.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ehci-orion.txt
 create mode 100644 arch/arm/boot/dts/kirkwood-6281.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-6282.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-98dx4122.dtsi
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
 create mode 100644 drivers/pinctrl/mvebu/Kconfig
 create mode 100644 drivers/pinctrl/mvebu/Makefile
 rename drivers/pinctrl/{ => mvebu}/pinctrl-armada-370.c (100%)
 rename drivers/pinctrl/{ => mvebu}/pinctrl-armada-xp.c (100%)
 rename drivers/pinctrl/{ => mvebu}/pinctrl-dove.c (96%)
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-kirkwood.c
 rename drivers/pinctrl/{ => mvebu}/pinctrl-mvebu.c (99%)
 rename drivers/pinctrl/{ => mvebu}/pinctrl-mvebu.h (100%)
 delete mode 100644 drivers/pinctrl/pinctrl-kirkwood.c
 create mode 100644 drivers/power/reset/Kconfig
 create mode 100644 drivers/power/reset/Makefile
 create mode 100644 drivers/power/reset/gpio-poweroff.c
