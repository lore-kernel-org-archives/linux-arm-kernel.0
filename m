From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 12 Jan 2013 23:29:24 +0000
Subject: [GIT PULL 4/4] ARM: mvebu: dt for v3.9
In-Reply-To: <pull-1358033364-983365>
Message-ID: <mailman.26.1358033389.1035.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:

  Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/dt_for_v3.9

for you to fetch changes up to 877ddfac50bfeabc4729d0b8ac41989d226148b9:

  ARM: Dove: add fixed regulator for CuBox USB power (2013-01-12 22:35:56 +0000)

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

----------------------------------------------------------------
Andrew Lunn (5):
      ARM: Kirkwood: Fix missing clk for USB device.
      Power: gpio-poweroff: Fix documentation and gpio_is_valid
      ARM: Kirkwood: Fix missing sdio clock
      ARM: Kirkwood: Use fixed-regulator instead of board gpio call
      arm: mvebu: Add missing ; for cpu node.

Gregory CLEMENT (7):
      arm: mvebu: Use dw-apb-uart instead of ns16650 as UART driver
      arm: mvebu: Improve the SMP support of the interrupt controller
      ARM: mvebu: Fix interrupt handling in SMP mode
      rtc: Add support of rtc-mv for MVEBU SoCs
      arm: mvebu: Update defconfig with Marvell RTC support
      arm: mvebu: Add RTC support for Armada 370 and Armada XP
      arm: mvebu: Fix memory size for Armada 370 DB

Jason Cooper (4):
      Merge branch 'mvebu/drivers' into mvebu/boards
      Merge branch 'mvebu/drivers' into mvebu/boards
      Merge branch 'mvebu/boards' into mvebu/dt
      Merge branch 'mvebu/fixes' into mvebu/dt

Jason Gunthorpe (1):
      ARM: Kirkwood: Support basic hotplug for PCI-E

Joshua Coombs (1):
      clk: mvebu: Remove inappropriate __init tagging

Nobuhiro Iwamatsu (4):
      ARM: Kirkwood: Switch TWSI1 of 88f6282 to DT clock providers
      ARM: Kirkwood: Add pinctrl of TWSI1 to 88f6282
      ARM: Kirkwood: Add pinctrl of NAND to 88f6282
      ARM: Kirkwood: Convert openblocks A6 board to pinctrl

Sebastian Hesselbarth (5):
      ARM: Dove: Add pinctrl clock to DT
      pinctrl: mvebu: make pdma clock on dove mandatory
      ARM: Dove: add Cubox sdhci card detect gpio
      ARM: Dove: move CuBox led pinctrl to gpio-leds node
      ARM: Dove: add fixed regulator for CuBox USB power

Simon Guinot (1):
      ARM: Kirkwood: fix ns2 gpios by converting to pinctrl

Thomas Petazzoni (22):
      arm: mvebu: Armada XP MV78230 has two cores, not one
      arm: mvebu: Armada XP MV78230 has only three Ethernet interfaces
      dma: mv_xor: fix error handling of mv_xor_channel_add()
      dma: mv_xor: fix error handling for clocks
      arm: mvebu: use global interrupts for GPIOs on Armada XP
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

 .../devicetree/bindings/gpio/gpio-poweroff.txt     |  20 ++-
 .../devicetree/bindings/mmc/orion-sdio.txt         |  17 +++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/armada-370-db.dts                |  17 ++-
 arch/arm/boot/dts/armada-370-mirabox.dts           |  10 ++
 arch/arm/boot/dts/armada-370-xp.dtsi               |  20 ++-
 arch/arm/boot/dts/armada-370.dtsi                  |  12 ++
 arch/arm/boot/dts/armada-xp-db.dts                 |   7 ++
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  29 +++--
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  35 ++++--
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  35 ++++--
 arch/arm/boot/dts/armada-xp.dtsi                   |  16 +--
 arch/arm/boot/dts/dove-cubox.dts                   |  40 +++++-
 arch/arm/boot/dts/dove.dtsi                        |   1 +
 arch/arm/boot/dts/kirkwood-6282.dtsi               |  18 +++
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |   7 ++
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |  94 ++++++++++++++
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |  11 +-
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |  16 +++
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       | 116 ++++++++++++++++++
 arch/arm/boot/dts/kirkwood-topkick.dts             |  17 +++
 arch/arm/boot/dts/kirkwood.dtsi                    |   9 ++
 arch/arm/configs/mvebu_defconfig                   |  13 +-
 arch/arm/mach-dove/Kconfig                         |   2 +
 arch/arm/mach-kirkwood/Kconfig                     |   7 ++
 arch/arm/mach-kirkwood/Makefile                    |   1 +
 arch/arm/mach-kirkwood/board-dreamplug.c           |   6 -
 arch/arm/mach-kirkwood/board-dt.c                  |   8 ++
 arch/arm/mach-kirkwood/board-guruplug.c            |  39 ++++++
 arch/arm/mach-kirkwood/board-mplcec4.c             |   7 --
 arch/arm/mach-kirkwood/board-ns2.c                 |  38 ------
 arch/arm/mach-kirkwood/board-openblocks_a6.c       |  44 -------
 arch/arm/mach-kirkwood/board-usi_topkick.c         |   4 -
 arch/arm/mach-kirkwood/common.h                    |   5 +
 arch/arm/mach-kirkwood/pcie.c                      |  10 +-
 arch/arm/mach-mvebu/irq-armada-370-xp.c            |  72 +++++++++++
 drivers/clk/mvebu/clk-gating-ctrl.c                |   2 +-
 drivers/dma/mv_xor.c                               |   9 +-
 drivers/mmc/host/mvsdio.c                          | 136 +++++++++------------
 drivers/pinctrl/mvebu/pinctrl-dove.c               |   7 +-
 drivers/power/reset/gpio-poweroff.c                |  33 +++--
 drivers/rtc/Kconfig                                |   2 +-
 42 files changed, 730 insertions(+), 263 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt
 create mode 100644 arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
 create mode 100644 arch/arm/mach-kirkwood/board-guruplug.c
