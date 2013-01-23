From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 02:48:01 +0000
Subject: [GIT PULL V2 0/4] ARM: mvebu: changes for v3.9
In-Reply-To: <pull-1358033364-983365>
Message-ID: <1358909281.35276e0.21555@triton>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4b53ab9cb853e446f628e561ce6fcc527df30a76:

  Merge branch 'mvebu/fixes' into mvebu/drivers (2013-01-23 01:42:14 +0000)

are available in the git repository at:


  git://git.infradead.org/users/jcooper/linux.git mvebu/for-next

for you to fetch changes up to bf70a4aed75cdcfc765f896916cec73d3f94f3ec:

  Merge branch 'mvebu/dt' into mvebu/for-next (2013-01-23 02:42:39 +0000)

----------------------------------------------------------------

Andrew Lunn (1):
      ARM: Kirkwood: Cleanup unneeded include files

Gregory CLEMENT (2):
      arm: mvebu: Update defconfig with Marvell RTC support
      arm: mvebu: Add RTC support for Armada 370 and Armada XP

Jason Cooper (4):
      Merge branch 'mvebu/cleanup' into mvebu/for-next
      Merge branch 'mvebu/drivers' into mvebu/for-next
      Merge branch 'mvebu/boards' into mvebu/for-next
      Merge branch 'mvebu/dt' into mvebu/for-next

Nobuhiro Iwamatsu (3):
      ARM: Kirkwood: Add pinctrl of TWSI1 to 88f6282
      ARM: Kirkwood: Add pinctrl of NAND to 88f6282
      ARM: Kirkwood: Convert openblocks A6 board to pinctrl

Sebastian Hesselbarth (2):
      ARM: Dove: move CuBox led pinctrl to gpio-leds node
      ARM: Dove: add fixed regulator for CuBox USB power

Thomas Petazzoni (18):
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

 .../devicetree/bindings/mmc/orion-sdio.txt         |  17 +++
 arch/arm/boot/dts/armada-370-db.dts                |  15 +++
 arch/arm/boot/dts/armada-370-mirabox.dts           |  10 ++
 arch/arm/boot/dts/armada-370-xp.dtsi               |  14 +++
 arch/arm/boot/dts/armada-370.dtsi                  |  12 ++
 arch/arm/boot/dts/armada-xp-db.dts                 |   7 ++
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   6 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   6 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   6 +
 arch/arm/boot/dts/dove-cubox.dts                   |  28 ++++-
 arch/arm/boot/dts/kirkwood-6282.dtsi               |  17 +++
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |   7 ++
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |  11 +-
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       | 116 ++++++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi                    |   8 ++
 arch/arm/configs/mvebu_defconfig                   |   9 ++
 arch/arm/mach-dove/Kconfig                         |   2 +
 arch/arm/mach-kirkwood/board-dreamplug.c           |   6 -
 arch/arm/mach-kirkwood/board-ib62x0.c              |   1 -
 arch/arm/mach-kirkwood/board-mplcec4.c             |   8 --
 arch/arm/mach-kirkwood/board-openblocks_a6.c       |  44 -------
 arch/arm/mach-kirkwood/dockstar-setup.c            |   1 -
 drivers/mmc/host/mvsdio.c                          | 129 ++++++++++-----------
 23 files changed, 351 insertions(+), 129 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt
