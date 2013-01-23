From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 02:48:11 +0000
Subject: [GIT PULL V2 4/4] ARM: mvebu: dt for v3.9
In-Reply-To: <1358909281.35276e0.21555@triton>
Message-ID: <1358909291.7b6fc46d4.21555@triton>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6c00ce51dd26ffcd978c657533a71af32dbf2793:

  arm: mvebu: enable btmrvl driver in mvebu_defconfig (2013-01-23 01:57:37 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/dt_for_v3.9

for you to fetch changes up to 68f4d9ecc4512aa5680f897187d607be91a3f95b:

  ARM: Dove: add fixed regulator for CuBox USB power (2013-01-23 02:07:09 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.9
 - mvebu
   - add rtc support
   - add sdio support
 - kirkwood
   - add sdio support
   - add twsi1 and nand to 88f6282
   - convert openblocks A6 to pinctrl
 - dove
   - move led pinctrl to gpio-leds node
   - use fixed regulator for usb power

depends on:
 - mvebu/fixes
 - mvebu/drivers
 - mvebu/boards

----------------------------------------------------------------
Gregory CLEMENT (1):
      arm: mvebu: Add RTC support for Armada 370 and Armada XP

Nobuhiro Iwamatsu (3):
      ARM: Kirkwood: Add pinctrl of TWSI1 to 88f6282
      ARM: Kirkwood: Add pinctrl of NAND to 88f6282
      ARM: Kirkwood: Convert openblocks A6 board to pinctrl

Sebastian Hesselbarth (2):
      ARM: Dove: move CuBox led pinctrl to gpio-leds node
      ARM: Dove: add fixed regulator for CuBox USB power

Thomas Petazzoni (10):
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

 arch/arm/boot/dts/armada-370-db.dts          |  15 ++++
 arch/arm/boot/dts/armada-370-mirabox.dts     |  10 +++
 arch/arm/boot/dts/armada-370-xp.dtsi         |  14 ++++
 arch/arm/boot/dts/armada-370.dtsi            |  12 +++
 arch/arm/boot/dts/armada-xp-db.dts           |   7 ++
 arch/arm/boot/dts/armada-xp-mv78230.dtsi     |   6 ++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi     |   6 ++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi     |   6 ++
 arch/arm/boot/dts/dove-cubox.dts             |  28 ++++++-
 arch/arm/boot/dts/kirkwood-6282.dtsi         |  17 ++++
 arch/arm/boot/dts/kirkwood-dreamplug.dts     |   7 ++
 arch/arm/boot/dts/kirkwood-mplcec4.dts       |  11 ++-
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts | 116 +++++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi              |   8 ++
 arch/arm/mach-dove/Kconfig                   |   2 +
 arch/arm/mach-kirkwood/board-dreamplug.c     |   6 --
 arch/arm/mach-kirkwood/board-mplcec4.c       |   7 --
 arch/arm/mach-kirkwood/board-openblocks_a6.c |  44 ----------
 18 files changed, 262 insertions(+), 60 deletions(-)
