From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 12 Jan 2013 23:29:20 +0000
Subject: [GIT PULL 3/4] ARM: mvebu: boards for v3.9
In-Reply-To: <pull-1358033364-983365>
Message-ID: <mailman.24.1358033373.1035.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:

  Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/boards_for_v3.9

for you to fetch changes up to 3db7063cd2f8284190ef81e9dd0e9b902c73c5e9:

  arm: mvebu: enable btmrvl driver in mvebu_defconfig (2013-01-10 02:49:23 +0000)

----------------------------------------------------------------
mvebu boards for v3.9
 - Guruplug Server Plus DT board
 - mvebu improved SMP support in interrupt controller
 - update mvebu_defconfig

----------------------------------------------------------------
Gregory CLEMENT (4):
      arm: mvebu: Improve the SMP support of the interrupt controller
      ARM: mvebu: Fix interrupt handling in SMP mode
      rtc: Add support of rtc-mv for MVEBU SoCs
      arm: mvebu: Update defconfig with Marvell RTC support

Jason Cooper (2):
      Merge branch 'mvebu/drivers' into mvebu/boards
      Merge branch 'mvebu/drivers' into mvebu/boards

Jason Gunthorpe (1):
      ARM: Kirkwood: Support basic hotplug for PCI-E

Thomas Petazzoni (7):
      mmc: mvsdio: use slot-gpio infrastructure for write protect gpio
      mmc: mvsdio: use slot-gpio for card detect gpio
      mmc: mvsdio: implement a Device Tree binding
      mmc: mvsdio: add pinctrl integration
      arm: mvebu: enable SDIO support in mvebu_defconfig
      arm: mvebu: enable mwifiex driver in mvebu_defconfig
      arm: mvebu: enable btmrvl driver in mvebu_defconfig

Willy Tarreau (1):
      ARM: kirkwood: convert Guruplug Server Plus to use the device tree

 .../devicetree/bindings/mmc/orion-sdio.txt         |  17 +++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/armada-xp.dtsi                   |   2 +-
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |  94 ++++++++++++++
 arch/arm/configs/mvebu_defconfig                   |   9 ++
 arch/arm/mach-kirkwood/Kconfig                     |   7 ++
 arch/arm/mach-kirkwood/Makefile                    |   1 +
 arch/arm/mach-kirkwood/board-dt.c                  |   4 +
 arch/arm/mach-kirkwood/board-guruplug.c            |  39 ++++++
 arch/arm/mach-kirkwood/common.h                    |   5 +
 arch/arm/mach-kirkwood/pcie.c                      |  10 +-
 arch/arm/mach-mvebu/irq-armada-370-xp.c            |  72 +++++++++++
 drivers/mmc/host/mvsdio.c                          | 136 +++++++++------------
 drivers/rtc/Kconfig                                |   2 +-
 14 files changed, 315 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt
 create mode 100644 arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
 create mode 100644 arch/arm/mach-kirkwood/board-guruplug.c
