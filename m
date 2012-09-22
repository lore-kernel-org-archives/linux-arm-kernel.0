From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Sep 2012 13:20:33 -0400
Subject: [GIT PULL V5 1/7] ARM: kirkwood: board changes for v3.7
In-Reply-To: <20120922171554.GE5469@titan.lakedaemon.net>
References: <20120922171554.GE5469@titan.lakedaemon.net>
Message-ID: <20120922172033.GF5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depends:
 - Based on v3.6-rc5

Add misc:
  - doc describing the Marvell family of SoCs
  - make PCI optional on dove

Adds kirkwood boards:
  - Iomega ix2-200
  - Seagate FreeAgent Dockstar
  - Keymile

Add mvebu (dove) board:
  - SolidRun CuBox

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git kirkwood/boards

Alan M Butler (1):
      ARM: Kirkwood: Iomega ix2-200 DT support

Russell King (1):
      ARM: Dove: allow PCI to be disabled

Sebastian Hesselbarth (8):
      ARM: kirkwood: DT board setup for Seagate FreeAgent Dockstar
      ARM: kirkwood: DT descriptor for Seagate FreeAgent Dockstar
      ARM: dove: unify clock setup
      ARM: dove: add clock gating control
      ARM: dove: add crypto engine
      ARM: dove: add device tree based machine descriptor
      ARM: dove: add device tree descriptors
      ARM: dove: SolidRun CuBox DT

Thomas Petazzoni (1):
      arm: add documentation describing Marvell families of SoC

Valentin Longchamp (1):
      ARM: initial DTS support for km_kirkwood

 Documentation/arm/Marvell/README              |  232 +++++++++++++++++++++++++
 arch/arm/Kconfig                              |    3 +-
 arch/arm/boot/dts/dove-cm-a510.dts            |   38 ++++
 arch/arm/boot/dts/dove-cubox.dts              |   42 +++++
 arch/arm/boot/dts/dove-dove-db.dts            |   38 ++++
 arch/arm/boot/dts/dove.dtsi                   |  143 +++++++++++++++
 arch/arm/boot/dts/kirkwood-dockstar.dts       |   57 ++++++
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts |  105 +++++++++++
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts    |   29 +++
 arch/arm/mach-dove/Kconfig                    |    7 +
 arch/arm/mach-dove/Makefile                   |    4 +-
 arch/arm/mach-dove/Makefile.boot              |    4 +
 arch/arm/mach-dove/common.c                   |  154 +++++++++++++++--
 arch/arm/mach-dove/common.h                   |    4 +
 arch/arm/mach-dove/include/mach/pm.h          |   54 ++++--
 arch/arm/mach-kirkwood/Kconfig                |   21 +++
 arch/arm/mach-kirkwood/Makefile               |    3 +
 arch/arm/mach-kirkwood/Makefile.boot          |    3 +
 arch/arm/mach-kirkwood/board-dockstar.c       |   61 +++++++
 arch/arm/mach-kirkwood/board-dt.c             |   12 ++
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c |   57 ++++++
 arch/arm/mach-kirkwood/board-km_kirkwood.c    |   57 ++++++
 arch/arm/mach-kirkwood/common.h               |   18 ++
 23 files changed, 1113 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/arm/Marvell/README
 create mode 100644 arch/arm/boot/dts/dove-cm-a510.dts
 create mode 100644 arch/arm/boot/dts/dove-cubox.dts
 create mode 100644 arch/arm/boot/dts/dove-dove-db.dts
 create mode 100644 arch/arm/boot/dts/dove.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-dockstar.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-km_kirkwood.dts
 create mode 100644 arch/arm/mach-kirkwood/board-dockstar.c
 create mode 100644 arch/arm/mach-kirkwood/board-iomega_ix2_200.c
 create mode 100644 arch/arm/mach-kirkwood/board-km_kirkwood.c
