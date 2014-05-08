From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 8 May 2014 14:02:49 -0400
Subject: [GIT PULL] ARM: mvebu: SoC orion5x DT conversion for v3.16
Message-ID: <20140508180249.GL12708@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

guys,

This is a great series by Thomas that gets orion5x well on it's way to
happy devicetree land. :)

This series crosses quite a few subdirectories, but the changes are
isolated to orion5x-specific files and legacy platform code.  iow, any
conflicts are going to be internal to mvebu.  This branch has been up in
-next for over a week without problems.

I chose to keep the series together to keep orion5x bootable during
bisection.  If you have any trouble with this branch, please let me
know.

Please pull.

thx,

Jason.


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-orion5x-3.16

for you to fetch changes up to 19e00f20e90e349cdeef3d7b63e6179215c9ff9d:

  ARM: orion: remove no longer needed gpio DT code (2014-04-26 19:45:28 +0000)

----------------------------------------------------------------
mvebu SoC orion5x DT conversion for v3.16

 - orion5x
    - convert to DT

----------------------------------------------------------------
Thomas Petazzoni (29):
      ARM: orion5x: move interrupt controller node into ocp
      ARM: orion5x: switch to preprocessor includes in DT
      ARM: orion5x: use existing dt-bindings include for Device Tree files
      ARM: orion5x: convert DT to use the mvebu-mbus driver
      ARM: orion5x: add node labels in Orion5x SoC Device Tree file
      ARM: orion5x: use gpio-keys and gpio-leds instead of gpio_keys/gpio_leds in edmini_v2
      ARM: orion5x: add linux,stdout-path to edmini_v2
      ARM: orion5x: use node labels for UART and SATA on edmini_v2
      ARM: orion5x: rename XOR node to dma-controller@<address>
      ARM: orion5x: add interrupt for Ethernet in Device Tree
      ARM: orion5x: switch to use the clock driver for DT platforms
      ARM: orion5x: convert to use 'clocks' property for UART controllers
      ARM: orion: switch to a per-platform handle_irq() function
      ARM: orion5x: switch to DT interrupts and timer
      ARM: orion5x: enable pinctrl driver at SoC level
      ARM: orion5x: update I2C description at SoC level
      ARM: orion5x: add Device Bus description at SoC level
      ARM: orion5x: add standard pinctrl configs for sata0 and sata1
      ARM: orion5x: convert edmini_v2 to DT pinctrl
      ARM: orion5x: use DT to describe I2C devices on edmini_v2
      ARM: orion5x: use DT to describe EHCI on edmini_v2
      ARM: orion5x: use DT to describe NOR on edmini_v2
      ARM: orion5x: keep TODO list in edmini_v2 DT
      ARM: orion5x: remove unneeded code for edmini_v2
      ARM: orion5x: convert RD-88F5182 to Device Tree
      ARM: orion5x: convert d2net to Device Tree
      ARM: orion5x: convert Maxtor Shared Storage II to the Device Tree
      ARM: orion: remove no longer needed DT IRQ code
      ARM: orion: remove no longer needed gpio DT code

 arch/arm/boot/dts/Makefile                         |   5 +-
 arch/arm/boot/dts/orion5x-lacie-d2-network.dts     | 236 +++++++++++++
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    | 141 ++++++--
 .../boot/dts/orion5x-maxtor-shared-storage-2.dts   | 178 ++++++++++
 arch/arm/boot/dts/orion5x-mv88f5182.dtsi           |  45 +++
 arch/arm/boot/dts/orion5x-rd88f5182-nas.dts        | 177 ++++++++++
 arch/arm/boot/dts/orion5x.dtsi                     | 289 +++++++++-------
 arch/arm/mach-dove/irq.c                           |  36 ++
 arch/arm/mach-kirkwood/irq.c                       |  37 +++
 arch/arm/mach-orion5x/Kconfig                      |  37 +--
 arch/arm/mach-orion5x/Makefile                     |   7 +-
 arch/arm/mach-orion5x/board-d2net.c                | 109 ++++++
 arch/arm/mach-orion5x/board-dt.c                   |  18 +-
 arch/arm/mach-orion5x/board-mss2.c                 |  90 +++++
 arch/arm/mach-orion5x/board-rd88f5182.c            | 116 +++++++
 arch/arm/mach-orion5x/common.h                     |  13 +-
 arch/arm/mach-orion5x/d2net-setup.c                | 365 ---------------------
 arch/arm/mach-orion5x/edmini_v2-setup.c            | 169 ----------
 arch/arm/mach-orion5x/irq.c                        |  28 ++
 arch/arm/mach-orion5x/mss2-setup.c                 | 274 ----------------
 arch/arm/plat-orion/gpio.c                         |  48 ---
 arch/arm/plat-orion/include/plat/irq.h             |   1 -
 arch/arm/plat-orion/include/plat/orion-gpio.h      |   1 -
 arch/arm/plat-orion/irq.c                          |  77 -----
 24 files changed, 1393 insertions(+), 1104 deletions(-)
 create mode 100644 arch/arm/boot/dts/orion5x-lacie-d2-network.dts
 create mode 100644 arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
 create mode 100644 arch/arm/boot/dts/orion5x-mv88f5182.dtsi
 create mode 100644 arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
 create mode 100644 arch/arm/mach-orion5x/board-d2net.c
 create mode 100644 arch/arm/mach-orion5x/board-mss2.c
 create mode 100644 arch/arm/mach-orion5x/board-rd88f5182.c
 delete mode 100644 arch/arm/mach-orion5x/d2net-setup.c
 delete mode 100644 arch/arm/mach-orion5x/edmini_v2-setup.c
 delete mode 100644 arch/arm/mach-orion5x/mss2-setup.c
