From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 May 2013 16:26:32 -0400
Subject: [GIT PULL 3/5] ARM: kirkwood: pcie driver for v3.11
In-Reply-To: <20130528202433.GH31290@titan.lakedaemon.net>
References: <20130528202140.GG31290@titan.lakedaemon.net>
 <20130528202433.GH31290@titan.lakedaemon.net>
Message-ID: <20130528202632.GI31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 3d9939c92efdd4ced672b94994959ca71b141cb8:

  pci: mvebu: fix return value check in mvebu_pcie_probe() (2013-05-27 15:51:56 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/pcie_kw-3.11

for you to fetch changes up to 0d0632f523fa040b307688ae421a1debf79af2d7:

  arm: kirkwood: convert db-88f6281/db-88f6282 to the Device Tree (2013-05-27 16:02:13 +0000)

----------------------------------------------------------------
mvebu pcie driver (kirkwood) for v3.11

 - kirkwood
    - enable pcie driver
    - migrate boards over to pcie dt init

depends
 - mvebu/pcie
    - mvebu/of_pci

----------------------------------------------------------------
Thomas Petazzoni (8):
      pci: mvebu: enable driver usage on Kirkwood
      arm: kirkwood: move PCIe window init to legacy driver
      arm: kirkwood: add SoC-level Device Tree data for PCIe interfaces
      arm: kirkwood: convert Iomega Iconnect to use DT for the PCIe interface
      arm: kirkwood: convert MPL CEC4 to use DT for the PCIe interface
      arm: kirkwood: convert ZyXEL NSA310 to use DT for the PCIe interface
      arm: kirkwood: convert QNAP TS219 to use DT for the PCIe interface
      arm: kirkwood: convert db-88f6281/db-88f6282 to the Device Tree

 .../devicetree/bindings/pci/mvebu-pci.txt          |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/kirkwood-6281.dtsi               |  31 ++++++
 arch/arm/boot/dts/kirkwood-6282.dtsi               |  48 +++++++++
 arch/arm/boot/dts/kirkwood-db-88f6281.dts          |  30 ++++++
 arch/arm/boot/dts/kirkwood-db-88f6282.dts          |  34 +++++++
 arch/arm/boot/dts/kirkwood-db.dtsi                 |  89 +++++++++++++++++
 arch/arm/boot/dts/kirkwood-iconnect.dts            |   8 ++
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |   8 ++
 arch/arm/boot/dts/kirkwood-nsa310.dts              |   8 ++
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |   3 +-
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |   3 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |   9 +-
 arch/arm/boot/dts/kirkwood.dtsi                    |   1 +
 arch/arm/mach-kirkwood/Kconfig                     |  21 ++--
 arch/arm/mach-kirkwood/Makefile                    |   3 +-
 arch/arm/mach-kirkwood/board-db88f628x-bp.c        |  24 +++++
 arch/arm/mach-kirkwood/board-dt.c                  |   6 ++
 arch/arm/mach-kirkwood/board-iconnect.c            |   8 --
 arch/arm/mach-kirkwood/board-mplcec4.c             |   1 -
 arch/arm/mach-kirkwood/board-nsa310.c              |  25 -----
 arch/arm/mach-kirkwood/board-ts219.c               |  10 --
 arch/arm/mach-kirkwood/common.c                    |  24 -----
 arch/arm/mach-kirkwood/common.h                    |   6 ++
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c        | 108 ---------------------
 arch/arm/mach-kirkwood/pcie.c                      |  22 +++++
 drivers/pci/host/Kconfig                           |   2 +-
 drivers/pci/host/pci-mvebu.c                       |   1 +
 28 files changed, 339 insertions(+), 197 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-db-88f6281.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-db-88f6282.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-db.dtsi
 create mode 100644 arch/arm/mach-kirkwood/board-db88f628x-bp.c
 delete mode 100644 arch/arm/mach-kirkwood/board-nsa310.c
 delete mode 100644 arch/arm/mach-kirkwood/db88f6281-bp-setup.c
