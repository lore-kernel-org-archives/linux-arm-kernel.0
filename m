From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Sep 2015 17:59:33 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Cleanup for v4.4
Message-ID: <cover.1442478814.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC cleanup for v4.4.

 24 files changed, 4 insertions(+), 2687 deletions(-)

Is a pleasing diffstat if I do say so myself.

Of particular note the last legacy board code for Renesas ARM based SoCs,
that of the bockw board, is removed in this pull request.


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-for-v4.4

for you to fetch changes up to 04418c23a9411b85b8789eab5f4397bcbd62b7b4:

  ARM: shmobile: Remove legacy clock support leftovers (2015-09-14 10:06:56 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Cleanup for v4.4

* Remove bockw/r8a7798 legacy board and SoC code
* Many cleanups relating to legacy board and SoC code removal

----------------------------------------------------------------
Geert Uytterhoeven (7):
      ARM: shmobile: Remove unused declaration of r8a7778_add_standard_devices_dt()
      ARM: shmobile: Remove obsolete sh-gpio.h
      ARM: shmobile: Remove obsolete custom earlyprintk code
      ARM: shmobile: Remove obsolete intc.h
      ARM: shmobile: Remove obsolete legacy PM Domain leftovers
      ARM: shmobile: Remove obsolete earlytimer registration
      ARM: shmobile: Remove obsolete twd_local_timer declaration

Laurent Pinchart (1):
      ARM: shmobile: Remove legacy clock support leftovers

Simon Horman (1):
      ARM: shmobile: remove Makefile.boot

Ulrich Hecht (12):
      ARM: shmobile: bockw: remove "reference" device tree
      ARM: shmobile: bockw: remove "reference" board file and config
      ARM: shmobile: remove paragraph on DT reference platforms
      ARM: shmobile: bockw: remove legacy board file and config
      ARM: shmobile: r8a7778: remove obsolete setup code
      ARM: shmobile: Kconfig: remove obsolete option ARCH_R8A7778
      ARM: shmobile: r8a7778: remove legacy clock implementation
      ARM: shmobile: remove ARCH_SHMOBILE_LEGACY option
      ARM: shmobile: bockw: remove legacy defconfig
      MAINTAINERS: remove references to dropped marzen and bockw defconfigs
      ARM: shmobile: bockw: remove legacy DTB build target
      ARM: shmobile: Kconfig: remove unused SHMOBILE_TIMER_HZ section

 Documentation/devicetree/bindings/arm/shmobile.txt |   6 -
 MAINTAINERS                                        |   2 -
 arch/arm/Kconfig                                   |  26 +-
 arch/arm/Kconfig.debug                             |   3 +-
 arch/arm/boot/dts/Makefile                         |   3 -
 arch/arm/boot/dts/r8a7778-bockw-reference.dts      | 139 ----
 arch/arm/configs/bockw_defconfig                   | 133 ----
 arch/arm/mach-shmobile/Kconfig                     |  73 --
 arch/arm/mach-shmobile/Makefile                    |  14 +-
 arch/arm/mach-shmobile/Makefile.boot               |  12 -
 arch/arm/mach-shmobile/board-bockw-reference.c     |  86 ---
 arch/arm/mach-shmobile/board-bockw.c               | 737 ---------------------
 arch/arm/mach-shmobile/clock-r8a7778.c             | 342 ----------
 arch/arm/mach-shmobile/clock.c                     |  47 --
 arch/arm/mach-shmobile/clock.h                     |  42 --
 arch/arm/mach-shmobile/common.h                    |   5 -
 arch/arm/mach-shmobile/console.c                   |  27 -
 arch/arm/mach-shmobile/intc.h                      | 295 ---------
 arch/arm/mach-shmobile/pm-rmobile.h                |   9 -
 arch/arm/mach-shmobile/r8a7778.h                   |  78 ---
 arch/arm/mach-shmobile/r8a7779.h                   |   2 -
 arch/arm/mach-shmobile/setup-r8a7778.c             | 560 +---------------
 arch/arm/mach-shmobile/sh-gpio.h                   |  29 -
 arch/arm/mach-shmobile/timer.c                     |  21 -
 24 files changed, 4 insertions(+), 2687 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a7778-bockw-reference.dts
 delete mode 100644 arch/arm/configs/bockw_defconfig
 delete mode 100644 arch/arm/mach-shmobile/Makefile.boot
 delete mode 100644 arch/arm/mach-shmobile/board-bockw-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-bockw.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r8a7778.c
 delete mode 100644 arch/arm/mach-shmobile/clock.c
 delete mode 100644 arch/arm/mach-shmobile/clock.h
 delete mode 100644 arch/arm/mach-shmobile/console.c
 delete mode 100644 arch/arm/mach-shmobile/intc.h
 delete mode 100644 arch/arm/mach-shmobile/r8a7778.h
 delete mode 100644 arch/arm/mach-shmobile/sh-gpio.h
