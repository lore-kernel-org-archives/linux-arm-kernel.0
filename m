From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 12 Jan 2013 23:29:07 +0000
Subject: [GIT PULL 0/4] ARM: mvebu: changes for v3.9
Message-ID: <pull-1358033364-983365>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 417f2732930e5c5544ef3a3a0141d44b2639e8e8:

  Merge branch 'next/drivers' into for-next (2013-01-08 15:09:33 -0800)

are available in the git repository at:


  git://git.infradead.org/users/jcooper/linux.git mvebu/for-next

for you to fetch changes up to 9e896ba256a01808f2804944f258b0ac578d9c2e:

  Merge branch 'mvebu/dt' into mvebu/for-next (2013-01-12 22:39:17 +0000)

----------------------------------------------------------------

Andrew Lunn (1):
      ARM: Kirkwood: Cleanup unneeded include files

Gregory CLEMENT (6):
      arm: mvebu: Improve the SMP support of the interrupt controller
      ARM: mvebu: Fix interrupt handling in SMP mode
      rtc: Add support of rtc-mv for MVEBU SoCs
      arm: mvebu: Update defconfig with Marvell RTC support
      arm: mvebu: Add RTC support for Armada 370 and Armada XP
      arm: mvebu: Fix memory size for Armada 370 DB

Jason Cooper (9):
      Merge branch 'mvebu/drivers' into mvebu/boards
      Merge branch 'mvebu/drivers' into mvebu/boards
      Merge branch 'mvebu/boards' into mvebu/dt
      Merge branch 'mvebu/fixes' into mvebu/dt
      Merge branch 'mvebu/fixes' into mvebu/for-next
      Merge branch 'mvebu/cleanup' into mvebu/for-next
      Merge branch 'mvebu/drivers' into mvebu/for-next
      Merge branch 'mvebu/boards' into mvebu/for-next
      Merge branch 'mvebu/dt' into mvebu/for-next

Jason Gunthorpe (1):
      ARM: Kirkwood: Support basic hotplug for PCI-E

Nobuhiro Iwamatsu (3):
      ARM: Kirkwood: Add pinctrl of TWSI1 to 88f6282
      ARM: Kirkwood: Add pinctrl of NAND to 88f6282
      ARM: Kirkwood: Convert openblocks A6 board to pinctrl

Sebastian Hesselbarth (3):
      ARM: Dove: add Cubox sdhci card detect gpio
      ARM: Dove: move CuBox led pinctrl to gpio-leds node
      ARM: Dove: add fixed regulator for CuBox USB power

Simon Guinot (1):
      ARM: Kirkwood: fix ns2 gpios by converting to pinctrl

Thomas Petazzoni (19):
      arm: mvebu: use global interrupts for GPIOs on Armada XP
      arm: kirkwood: dockstar: remove useless include of SDIO header
      mmc: mvsdio: use slot-gpio infrastructure for write protect gpio
      mmc: mvsdio: use slot-gpio for card detect gpio
      mmc: mvsdio: implement a Device Tree binding
      mmc: mvsdio: add pinctrl integration
      arm: mvebu: enable SDIO support in mvebu_defconfig
      arm: mvebu: enable mwifiex driver in mvebu_defconfig
      arm: mvebu: enable btmrvl driver in mvebu_defconfig
      arm: mvebu: add DT information for the SDIO interface of Armada 370/XP
      arm: mvebu: add pin muxing options for the SDIO interface on Armada 370
      arm: mvebu: add pin muxing options for the SDIO interface on Armada XP
      arm: mvebu: enable the SD card slot on Armada XP DB board
      arm: mvebu: enable the SD card slot on Armada 370 DB board
      arm: mvebu: enable the SDIO interface on the Globalscale Mirabox
      arm: kirkwood: add Device Tree informations for the SDIO controller
      arm: kirkwood: dreamplug: use Device Tree to probe SDIO
      arm: kirkwood: mplcec4: use Device Tree to probe SDIO
      arm: kirkwood: add pinmux option for the SDIO interface on 88F6282

Willy Tarreau (1):
      ARM: kirkwood: convert Guruplug Server Plus to use the device tree

 .../devicetree/bindings/mmc/orion-sdio.txt         |  17 +++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/armada-370-db.dts                |  17 ++-
 arch/arm/boot/dts/armada-370-mirabox.dts           |  10 ++
 arch/arm/boot/dts/armada-370-xp.dtsi               |  14 +++
 arch/arm/boot/dts/armada-370.dtsi                  |  12 ++
 arch/arm/boot/dts/armada-xp-db.dts                 |   7 ++
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  20 +--
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  27 ++--
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  27 ++--
 arch/arm/boot/dts/armada-xp.dtsi                   |   2 +-
 arch/arm/boot/dts/dove-cubox.dts                   |  40 +++++-
 arch/arm/boot/dts/kirkwood-6282.dtsi               |  17 +++
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |   7 ++
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |  94 ++++++++++++++
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |  11 +-
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |  16 +++
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       | 116 ++++++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi                    |   8 ++
 arch/arm/configs/mvebu_defconfig                   |   9 ++
 arch/arm/mach-dove/Kconfig                         |   2 +
 arch/arm/mach-kirkwood/Kconfig                     |   7 ++
 arch/arm/mach-kirkwood/Makefile                    |   1 +
 arch/arm/mach-kirkwood/board-dreamplug.c           |   6 -
 arch/arm/mach-kirkwood/board-dt.c                  |   4 +
 arch/arm/mach-kirkwood/board-guruplug.c            |  39 ++++++
 arch/arm/mach-kirkwood/board-ib62x0.c              |   1 -
 arch/arm/mach-kirkwood/board-mplcec4.c             |   8 --
 arch/arm/mach-kirkwood/board-ns2.c                 |  38 ------
 arch/arm/mach-kirkwood/board-openblocks_a6.c       |  44 -------
 arch/arm/mach-kirkwood/common.h                    |   5 +
 arch/arm/mach-kirkwood/dockstar-setup.c            |   1 -
 arch/arm/mach-kirkwood/pcie.c                      |  10 +-
 arch/arm/mach-mvebu/irq-armada-370-xp.c            |  72 +++++++++++
 drivers/mmc/host/mvsdio.c                          | 136 +++++++++------------
 drivers/rtc/Kconfig                                |   2 +-
 36 files changed, 629 insertions(+), 219 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt
 create mode 100644 arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
 create mode 100644 arch/arm/mach-kirkwood/board-guruplug.c
