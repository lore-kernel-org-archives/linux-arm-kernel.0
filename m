From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 10 Sep 2012 01:57:41 -0400
Subject: [GIT PULL V2 2/4] ARM: Kirkwood: boards for v3.7
In-Reply-To: <20120829001129.GO19437@titan.lakedaemon.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
Message-ID: <20120910055741.GD15277@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This PR is based on v3.6-rc5 and depends upon kirkwood/dt.

It also depends upon the following in l2-mtd.git:

	mtd: orion_nand: remove <mach/hardware.h> include

Although this is a corner case.  The user needs to select ARCH_MVEBU=y
_and_ MTD_NAND_ORION=[y|m], which mvebu doesn't use.  I only ran across
in by accident.

thx,

Jason.

The following changes since commit 5d7b3dd7c8dc06679027a57750f4415b3f9b21ad:

  arm: l2x0: add aurora related properties to OF binding (2012-09-10 03:56:57 +0000)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git kirkwood/boards

Alan M Butler (1):
      ARM: Kirkwood: Iomega ix2-200 DT support

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
 arch/arm/boot/dts/dove-cm-a510.dts            |   38 ++++
 arch/arm/boot/dts/dove-cubox.dts              |   42 +++++
 arch/arm/boot/dts/dove-dove-db.dts            |   38 ++++
 arch/arm/boot/dts/dove.dtsi                   |  143 +++++++++++++++
 arch/arm/boot/dts/kirkwood-dockstar.dts       |   57 ++++++
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts |  105 +++++++++++
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts    |   29 +++
 arch/arm/mach-dove/Kconfig                    |    7 +
 arch/arm/mach-dove/Makefile.boot              |    4 +
 arch/arm/mach-dove/common.c                   |  154 +++++++++++++++--
 arch/arm/mach-dove/include/mach/pm.h          |   54 ++++--
 arch/arm/mach-kirkwood/Kconfig                |   21 +++
 arch/arm/mach-kirkwood/Makefile               |    3 +
 arch/arm/mach-kirkwood/Makefile.boot          |    3 +
 arch/arm/mach-kirkwood/board-dockstar.c       |   61 +++++++
 arch/arm/mach-kirkwood/board-dt.c             |   12 ++
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c |   57 ++++++
 arch/arm/mach-kirkwood/board-km_kirkwood.c    |   57 ++++++
 arch/arm/mach-kirkwood/common.h               |   18 ++
 20 files changed, 1105 insertions(+), 30 deletions(-)
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
