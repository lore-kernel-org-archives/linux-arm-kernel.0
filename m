From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:37:00 +0900
Subject: [GIT PULL 00/12] Renesas ARM based SoC board updates for v3.13
Message-ID: <cover.1380530519.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kevin and Arnd,

please consider these Renesas ARM based SoC board updates for v3.13.

This pull-request is based on renesas-soc-for-v3.13 which I will also send
a pull-request for today.

The following changes since commit f39d35fcc2cd7a24ec3128adffd7876953999e1f:

  ARM: shmobile: r8a7778: add usb phy power control function (2013-09-30 16:11:23 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git boards

for you to fetch changes up to b77c6bcef2082a7cd96124daf15df8da5b670ebe:

  ARM: shmobile: lager: disable MMCIF Command Completion Signal, add CLK_CTRL2 (2013-09-30 16:56:20 +0900)

----------------------------------------------------------------
Renesas ARM based SoC board updates for v3.13

* Display Unit support for lager and marzen boards
* Update regulators for MMC0, SDHI0 and SDHI1 on ape6evm board
* Enable use of FPGA on bockw board
* Add sounds support to bockw board
* Add USB function support to bockw board
* Add Koelsch board
* Disable MMCIF command completion signal on ape6evm, armadillo800eva,
  kzm9g and lager boards.

----------------------------------------------------------------
Guennadi Liakhovetski (5):
      ARM: shmobile: ape6evm: update MMC0, SDHI0 and SDHI1 with correct regulators
      ARM: shmobile: ape6evm: disable MMCIF Command Completion Signal
      ARM: shmobile: armadillo800eva: disable MMCIF Command Completion Signal
      ARM: shmobile: kzm9g: disable MMCIF Command Completion Signal
      ARM: shmobile: lager: disable MMCIF Command Completion Signal, add CLK_CTRL2

Hisashi Nakamura (1):
      ARM: shmobile: Koelsch support

Kuninori Morimoto (3):
      ARM: shmobile: bockw: enable global use of FPGA
      ARM: shmobile: bockw: add R-Car sound support (PIO)
      ARM: shmobile: bockw: add USB Function support

Laurent Pinchart (3):
      ARM: shmobile: marzen: Add Display Unit support
      ARM: shmobile: lager: Add Display Unit support
      ARM: shmobile: lager: Fix Display Unit platform data

 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/r8a7791-koelsch.dts          |  32 +++
 arch/arm/mach-shmobile/Kconfig                 |   7 +
 arch/arm/mach-shmobile/Makefile                |   1 +
 arch/arm/mach-shmobile/Makefile.boot           |   1 +
 arch/arm/mach-shmobile/board-ape6evm.c         |  55 +++-
 arch/arm/mach-shmobile/board-armadillo800eva.c |   1 +
 arch/arm/mach-shmobile/board-bockw.c           | 370 ++++++++++++++++++++++++-
 arch/arm/mach-shmobile/board-koelsch.c         |  44 +++
 arch/arm/mach-shmobile/board-kzm9g.c           |   1 +
 arch/arm/mach-shmobile/board-lager.c           |  68 +++++
 arch/arm/mach-shmobile/board-marzen.c          |  72 +++++
 12 files changed, 634 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7791-koelsch.dts
 create mode 100644 arch/arm/mach-shmobile/board-koelsch.c
