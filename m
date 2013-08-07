From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:38:19 +0900
Subject: [GIT PULL 00/26] Third round of Renesas ARM based SoC cleanups for
 v3.12
Message-ID: <cover.1375840527.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider this third round of Renesas ARM based SoC cleanups for
v3.12.

This pull-request is based on a merge of renesas-cleanup2-for-v3.12 and
renesas-dt2-for-v3.12 which I have previously sent pull-requests for.

This pull-request has some minor conflicts:

* There are some conflicts with renesas-multiplatform-for-v3.12,
  which I have previously sent a pull request for,
  in arch/arm/mach-shmobile/Makefile.

I have provided an example of how to merge these as part of
the renesas-devel-20180807 tag in the renesas tree.


The following changes since commit 4e0f3fcfe2f3716e3fa9c442cee93211bf2ac793:

  Merge branch 'dt2' into cleanup3-base (2013-08-06 18:06:53 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup3-for-v3.12

for you to fetch changes up to 282b583f752f996ee5c33b0cdc18adf3b5094ee0:

  ARM: shmobile: sh73a0: Remove global GPIO_NR definition (2013-08-06 18:07:13 +0900)

----------------------------------------------------------------
Third round of Renesas ARM based SoC cleanups for v3.12

* Remove global GPIO_NR definition from sh73a0 SoC
* Remove unnecessary nfsroot settings from bootargs of
  kzm9d and armadillo800eva
* Rename irq initialisation functions of r8a7779 SoC
  to make them consistent with other SoCs
* Simplify irq initialisation of r8a7740 SoC
* Add missing __initdata annotations to bockw board, and
  r8a7790 and r8a7779 SoCs
* Refactor time initialisation and remove shmobile_init_time.
  - This affects the following boards: kzm9g, marzen, ape6evm,
    armadillo800eva and bockw
  - This affects the following SoCs: r8a7790, r8a7779, r7a7740, r7a73a4
* Cleanup device registration code of r8a7778 SoC

----------------------------------------------------------------
Kuninori Morimoto (12):
      ARM: shmobile: r8a7778: cleanup registration of mmcif
      ARM: shmobile: r8a7778: cleanup registration of usb phy
      ARM: shmobile: r8a7778: cleanup registration of sdhi
      ARM: shmobile: r8a7778: cleanup registration of i2c
      ARM: shmobile: r8a7778: cleanup registration of hspi
      ARM: shmobile: r8a7779: add missing __initdata
      ARM: shmobile: r8a7790: add missing __initdata
      ARM: shmobile: bockw: add missing __initdata
      ARM: shmobile: r8a7740: move r8a7740_init_irq_of() to setup
      ARM: shmobile: r8a7779: move r8a7779_init_irq_xxx() to setup
      ARM: shmobile: armadillo800eva: remove nfsroot settings from bootargs
      ARM: shmobile: kzm9d: remove nfsroot settings from bootargs

Laurent Pinchart (1):
      ARM: shmobile: sh73a0: Remove global GPIO_NR definition

Magnus Damm (13):
      ARM: shmobile: Use default ->init_time() on r8a73a4
      ARM: shmobile: Use default ->init_time() on r8a7740
      ARM: shmobile: Use default ->init_time() on r8a7778
      ARM: shmobile: Use default ->init_time() on r8a7779
      ARM: shmobile: Use default ->init_time() on Bockw
      ARM: shmobile: Use default ->init_time() on Bockw DT ref
      ARM: shmobile: Use default ->init_time() on Armadillo DT ref
      ARM: shmobile: Use default ->init_time() on APE6EVM
      ARM: shmobile: Use default ->init_time() on APE6EVM DT ref
      ARM: shmobile: Use default ->init_time() on Marzen DT ref
      ARM: shmobile: Use default ->init_time() on KZM9G DT ref
      ARM: shmobile: Use clocksource_of_init() on r8a7790
      ARM: shmobile: Remove unused shmobile_init_time()

 arch/arm/boot/dts/emev2-kzm9d-reference.dts        |   2 +-
 arch/arm/boot/dts/emev2-kzm9d.dts                  |   2 +-
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   2 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |   2 +-
 arch/arm/mach-shmobile/Makefile                    |   4 +-
 arch/arm/mach-shmobile/board-ape6evm-reference.c   |   1 -
 arch/arm/mach-shmobile/board-ape6evm.c             |   1 -
 .../board-armadillo800eva-reference.c              |   1 -
 arch/arm/mach-shmobile/board-bockw-reference.c     |   1 -
 arch/arm/mach-shmobile/board-bockw.c               |  49 +++++++--
 arch/arm/mach-shmobile/board-kzm9g-reference.c     |   1 -
 arch/arm/mach-shmobile/board-kzm9g.c               |  16 +--
 arch/arm/mach-shmobile/board-marzen-reference.c    |   1 -
 arch/arm/mach-shmobile/include/mach/common.h       |   1 -
 arch/arm/mach-shmobile/include/mach/r8a7778.h      |   8 --
 arch/arm/mach-shmobile/include/mach/sh73a0.h       |   2 -
 arch/arm/mach-shmobile/intc-r8a7740.c              |  54 ----------
 arch/arm/mach-shmobile/intc-r8a7779.c              | 116 ---------------------
 arch/arm/mach-shmobile/setup-r8a73a4.c             |   1 -
 arch/arm/mach-shmobile/setup-r8a7740.c             |  33 +++++-
 arch/arm/mach-shmobile/setup-r8a7778.c             |  64 ++----------
 arch/arm/mach-shmobile/setup-r8a7779.c             |  83 ++++++++++++++-
 arch/arm/mach-shmobile/setup-r8a7790.c             |   7 +-
 arch/arm/mach-shmobile/timer.c                     |   4 -
 24 files changed, 179 insertions(+), 277 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/intc-r8a7740.c
 delete mode 100644 arch/arm/mach-shmobile/intc-r8a7779.c
