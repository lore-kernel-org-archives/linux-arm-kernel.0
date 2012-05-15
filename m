From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 14 May 2012 23:26:05 -0400
Subject: [GIT PULL] ARM: Kirkwood: new boards for v3.5
Message-ID: <20120515032605.GV16338@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 36be50515fe2aef61533b516fa2576a2c7fe7664:

  Linux 3.4-rc7 (2012-05-12 18:37:47 -0700)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git kirkwood_boards_for_v3.5

Arnaud Patard (3):
      kirkwood/orion: fix orion_gpio_set_blink
      orion/kirkwood: create a generic function for gpio led blinking
      kirkwood: Add iconnect support

Jamie Lentin (4):
      ARM: kirkwood: Basic support for DNS-320 and DNS-325
      mtd: Add orion_nand devicetree bindings
      kirkwood: Allow nand to be configured via. devicetree
      ARM: kirkwood: Define DNS-320/DNS-325 NAND in fdt

Simon Baatz (1):
      ARM: kirkwood: Add support for RaidSonic IB-NAS6210/6220 using devicetree

 .../devicetree/bindings/mtd/orion-nand.txt         |   50 ++++
 arch/arm/boot/dts/kirkwood-dns320.dts              |   64 +++++
 arch/arm/boot/dts/kirkwood-dns325.dts              |   59 +++++
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |   44 +++
 arch/arm/boot/dts/kirkwood-iconnect.dts            |   26 ++
 arch/arm/boot/dts/kirkwood.dtsi                    |   15 +-
 arch/arm/mach-kirkwood/Kconfig                     |   22 ++
 arch/arm/mach-kirkwood/Makefile                    |    3 +
 arch/arm/mach-kirkwood/Makefile.boot               |    4 +
 arch/arm/mach-kirkwood/board-dnskw.c               |  275 ++++++++++++++++++++
 arch/arm/mach-kirkwood/board-dt.c                  |   13 +
 arch/arm/mach-kirkwood/board-ib62x0.c              |  143 ++++++++++
 arch/arm/mach-kirkwood/board-iconnect.c            |  165 ++++++++++++
 arch/arm/mach-kirkwood/common.c                    |   12 +
 arch/arm/mach-kirkwood/common.h                    |   18 ++
 arch/arm/mach-orion5x/dns323-setup.c               |   25 +--
 arch/arm/plat-orion/gpio.c                         |   27 ++-
 arch/arm/plat-orion/include/plat/gpio.h            |    2 +
 drivers/mtd/nand/orion_nand.c                      |   47 +++-
 19 files changed, 985 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/orion-nand.txt
 create mode 100644 arch/arm/boot/dts/kirkwood-dns320.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-dns325.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ib62x0.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-iconnect.dts
 create mode 100644 arch/arm/mach-kirkwood/board-dnskw.c
 create mode 100644 arch/arm/mach-kirkwood/board-ib62x0.c
 create mode 100644 arch/arm/mach-kirkwood/board-iconnect.c
