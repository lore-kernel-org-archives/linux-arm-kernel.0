From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 16 Feb 2013 15:04:10 -0500
Subject: [GIT PULL 3/4] ARM: mvebu: dt changes for v3.9
Message-ID: <20130216200410.GJ23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1bead82fa5a52cd21c30c0c28615157d5c3dac9f:

  arm: mvebu: add button for OpenBlocks AX3-4 (2013-01-31 20:44:08 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/dt_for_v3.9_round2

for you to fetch changes up to d892d02956c3cbe6835480a20ba553fbb0699666:

  arm: mvebu: enable the SD card slot on Armada 370 Reference Design board (2013-02-16 16:27:13 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.9 round2

 - mvebu
    - USB support
    - local timers
    - SPI controller and flash
    - SD slot on the Reference Design board

 - kirkwood
    - topkick pinctrl, i2c and mvsdio
    - nsa310 pinctrl

 - dove
    - USB support
    - use clocks instead of clock-frequency for serial

I included patches depending on the mvsdio changes Chris Ball took,
since tags/boards_for_v3.9 has been pulled with that dependency.

All other patches with external dependencies are going into a separate
branch, mvebu/dt_deps.  If necessary, they can wait for v3.10.

new depends:
 - mvebu/boards  

new conflicts:   
 - arch/arm/mach-kirkwood/board-nsa310.c
    - remove the gpio.h include line.

** below is from previous tag dt_for_v3.9 **
depends on:
 - tags/boards_for_v3.9, which pulls in:
    - tags/mvebu_fixes_for_v3.8-rc6
    - tags/cleanup_for_v3.9_round2
    - tags/drivers_for_v3.9
    - mmc/mmc-next up to:
       d293875 mmc: mvsdio: add pinctrl integration

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Kirkwood: topkick: Enable i2c bus.

Ezequiel Garcia (7):
      arm: mvebu: Update defconfig to select USB support
      arm: mvebu: Add support for USB host controllers in Armada 370/XP
      arm: mvebu: Enable USB controllers on Armada 370/XP boards
      ARM: mvebu: Update defconfig to select SPI support
      ARM: mvebu: Update defconfig to select SPI flash and MTD support
      arm: mvebu: Add support for SPI controller in Armada 370/XP
      arm: mvebu: Add SPI flash on Armada XP-GP board

Florian Fainelli (1):
      arm: mvebu: enable the SD card slot on Armada 370 Reference Design board

Gregory CLEMENT (8):
      arm: mvebu: Add support for local interrupt
      clocksource: time-armada-370-xp: add local timer support
      arm: mvebu: update defconfig with local timer support
      arm: mvebu: update DT to support local timers
      clocksource: update and move armada-370-xp-timer documentation to timer directory
      arm: mvebu: support for the new Armada XP development board(DB-MV784MP-GP)
      arm: mvebu: Add SPI flash on Armada XP-DB board
      arm: mvebu: Add SPI flash on Armada 370 DB board

Jason Cooper (5):
      Merge branch 'mvebu/boards' into mvebu/dt
      Merge branch 'mvebu/boards' into mvebu/dt
      ARM: kirkwood: topkick: convert to pinctrl
      ARM: kirkwood: nsa310: convert to pinctrl
      ARM: kirkwood: topkick: init mvsdio via DT

Sebastian Hesselbarth (2):
      ARM: Dove: convert usb host controller to DT
      ARM: dove: convert serial DT nodes to clocks property

 .../marvell,armada-370-xp-timer.txt}               |  11 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/armada-370-db.dts                |  20 +++
 arch/arm/boot/dts/armada-370-mirabox.dts           |   8 ++
 arch/arm/boot/dts/armada-370-rd.dts                |   7 +
 arch/arm/boot/dts/armada-370-xp.dtsi               |  41 +++++-
 arch/arm/boot/dts/armada-370.dtsi                  |   9 ++
 arch/arm/boot/dts/armada-xp-db.dts                 |  24 ++++
 arch/arm/boot/dts/armada-xp-gp.dts                 | 113 ++++++++++++++++
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |   6 +
 arch/arm/boot/dts/armada-xp.dtsi                   |  17 +++
 arch/arm/boot/dts/dove.dtsi                        |  24 +++-
 arch/arm/boot/dts/kirkwood-nsa310.dts              |  99 ++++++++++++++
 arch/arm/boot/dts/kirkwood-topkick.dts             | 102 ++++++++++++++
 arch/arm/configs/mvebu_defconfig                   |  11 +-
 arch/arm/mach-dove/board-dt.c                      |  10 --
 arch/arm/mach-kirkwood/board-dt.c                  |   3 -
 arch/arm/mach-kirkwood/board-nsa310.c              |  26 ----
 arch/arm/mach-kirkwood/board-usi_topkick.c         |  48 -------
 arch/arm/mach-kirkwood/common.h                    |   6 -
 arch/arm/mach-mvebu/irq-armada-370-xp.c            |  15 ++-
 drivers/clocksource/time-armada-370-xp.c           | 150 +++++++++++++++------
 22 files changed, 604 insertions(+), 147 deletions(-)
 rename Documentation/devicetree/bindings/{arm/armada-370-xp-timer.txt => timer/marvell,armada-370-xp-timer.txt} (55%)
 create mode 100644 arch/arm/boot/dts/armada-xp-gp.dts
