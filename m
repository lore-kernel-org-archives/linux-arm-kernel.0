From: ian.molton@codethink.co.uk (Ian Molton)
Date: Mon, 30 Jul 2012 16:15:53 +0100
Subject: [PATCH 0/6] mv643xx Ethernet DT support and CSB1724 board support.
Message-ID: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the CSB1724 SoM by Cogent.

It also provides mv643xx DT support, and the CSB1724 was my test platform
for this support.

The mv643xx driver needs a LOT more TLC, but this should be a pretty
non-invasive way to get started on it.

The CSB1724 SoM platform support is ready-to-go. Supported so far is
SATA, Ethernet, and Serial.

SATA is built upon Thomas' work.

Ian Molton (6):
  Initial csb1724 board support (FDT)
  mv643xx.c: Remove magic numbers.
  mv643xx.c: Add basic device tree support.
  kirkwood: setup clock only in eth helpers.
  csb1724: Enable device tree based mv643xx ethernet support.
  DT: Convert all kirkwood boards with mv643xx that use DT

 arch/arm/boot/dts/kirkwood-csb1724.dts     |   55 ++++++++++++++
 arch/arm/boot/dts/kirkwood-dnskw.dtsi      |   12 +++
 arch/arm/boot/dts/kirkwood-dreamplug.dts   |   24 ++++++
 arch/arm/boot/dts/kirkwood-goflexnet.dts   |   11 +++
 arch/arm/boot/dts/kirkwood-ib62x0.dts      |   13 ++++
 arch/arm/boot/dts/kirkwood-iconnect.dts    |   13 ++++
 arch/arm/boot/dts/kirkwood-lsxl.dtsi       |   23 ++++++
 arch/arm/boot/dts/kirkwood-ts219-6281.dts  |   11 ++-
 arch/arm/boot/dts/kirkwood-ts219-6282.dts  |   11 ++-
 arch/arm/boot/dts/kirkwood-ts219.dtsi      |    3 +
 arch/arm/boot/dts/kirkwood.dtsi            |   16 ++++
 arch/arm/configs/csb1724_defconfig         |   92 ++++++++++++++++++++++
 arch/arm/mach-kirkwood/Kconfig             |    7 ++
 arch/arm/mach-kirkwood/Makefile            |    1 +
 arch/arm/mach-kirkwood/Makefile.boot       |    1 +
 arch/arm/mach-kirkwood/board-csb1724.c     |   62 +++++++++++++++
 arch/arm/mach-kirkwood/board-dnskw.c       |    7 +-
 arch/arm/mach-kirkwood/board-dreamplug.c   |   13 +---
 arch/arm/mach-kirkwood/board-dt.c          |    4 +
 arch/arm/mach-kirkwood/board-goflexnet.c   |    7 +-
 arch/arm/mach-kirkwood/board-ib62x0.c      |    7 +-
 arch/arm/mach-kirkwood/board-iconnect.c    |    7 +-
 arch/arm/mach-kirkwood/board-lsxl.c        |   13 +---
 arch/arm/mach-kirkwood/board-ts219.c       |   10 +--
 arch/arm/mach-kirkwood/common.c            |    6 +-
 arch/arm/mach-kirkwood/common.h            |    6 ++
 drivers/net/ethernet/marvell/mv643xx_eth.c |  114 ++++++++++++++++++++++++----
 27 files changed, 475 insertions(+), 74 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-csb1724.dts
 create mode 100644 arch/arm/configs/csb1724_defconfig
 create mode 100644 arch/arm/mach-kirkwood/board-csb1724.c

-- 
1.7.9.5
