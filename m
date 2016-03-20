From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 20 Mar 2016 21:29:53 +0100
Subject: [GIT PULL 2/8] ARM: SoC cleanups for v4.6
In-Reply-To: <10465240.PKeEEAAbCF@wuerfel>
References: <10465240.PKeEEAAbCF@wuerfel>
Message-ID: <3344097.G7hsSqFMa6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 901c5ffaaed117a38be9d0c29247c4888d6c8636:

  ARM: shmobile: Remove shmobile_boot_arg (2016-02-17 18:27:21 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-cleanup

for you to fetch changes up to 809683ee060de5ea45294d465dc242dee1ff189f:

  Merge tag 'mvebu-cleanup-4.6-2' of git://git.infradead.org/linux-mvebu into next/cleanup (2016-02-29 23:53:01 +0100)

----------------------------------------------------------------
ARM: SoC cleanups for v4.6

A few simple cleanups across multiple platforms, not much standing out:

- lpc32xx removes its private implementation of the clk API, after
  generic code was merged in 4.5
- all unused Makefile.boot files get removed
- a number of simplifications for shmobile
- asm/clkdev.h gets replaced with the asm-generic version after
  all mach/clkdev.h implementations are gone

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge tag 'renesas-cleanup2-for-v4.6' of git://git.kernel.org/.../horms/renesas into next/cleanup
      Merge tag 'mvebu-cleanup-4.6-2' of git://git.infradead.org/linux-mvebu into next/cleanup

Geert Uytterhoeven (5):
      ARM: shmobile: rcar-gen2: Make rcar_gen2_dma_contiguous static
      ARM: shmobile: Add includes providing forward declarations
      ARM: shmobile: Typo s/MIPDR/MPIDR/
      ARM: shmobile: r8a7779: Remove remainings of removed SCU boot setup code
      ARM: shmobile: Consolidate SCU mapping code

Magnus Damm (1):
      ARM: shmobile: Kconfig: Get rid of old comment

Masahiro Yamada (5):
      ARM: mv78xx0: use "depends on" instead of "if" after prompt
      ARM: mvebu: add missing of_node_put()
      ARM: drop unused Makefile.boot of Multiplatform SoCs
      ARM: integrator: remove redundant select in Kconfig
      ARM: netx: remove redundant "depends on ARCH_NETX"

Olof Johansson (4):
      Merge tag 'renesas-cleanup-for-v4.6' of git://git.kernel.org/.../horms/renesas into next/cleanup
      Merge tag 'mvebu-cleanup-4.6-1' of git://git.infradead.org/linux-mvebu into next/cleanup
      Merge branch 'lpc32xx/soc' of https://github.com/vzapolskiy/linux into next/cleanup
      Merge tag 'plat-versatile-cleanup' of git://git.kernel.org/.../linusw/linux-integrator into next/cleanup

Stephen Boyd (2):
      ARM: plat-versatile: Remove unused clock.c file
      ARM: Use generic clkdev.h header

Vladimir Zapolskiy (3):
      arm: lpc32xx: switch to common clock framework
      arm: lpc32xx: remove selected HAVE_IDE
      arm: lpc32xx: remove direct control of GPIOs from shared mach file

 arch/arm/Kconfig                         |    4 +-
 arch/arm/include/asm/Kbuild              |    1 +
 arch/arm/include/asm/clkdev.h            |   31 -
 arch/arm/mach-cns3xxx/Makefile.boot      |    3 -
 arch/arm/mach-exynos/Makefile.boot       |    2 -
 arch/arm/mach-integrator/Kconfig         |    6 -
 arch/arm/mach-integrator/Makefile.boot   |    4 -
 arch/arm/mach-keystone/Makefile.boot     |    1 -
 arch/arm/mach-lpc32xx/Makefile           |    3 +-
 arch/arm/mach-lpc32xx/clock.c            | 1284 ------------------------------
 arch/arm/mach-lpc32xx/phy3250.c          |   53 --
 arch/arm/mach-lpc32xx/serial.c           |    3 -
 arch/arm/mach-lpc32xx/timer.c            |  144 ----
 arch/arm/mach-mmp/Makefile.boot          |    1 -
 arch/arm/mach-mv78xx0/Kconfig            |    3 +-
 arch/arm/mach-mv78xx0/Makefile.boot      |    3 -
 arch/arm/mach-mvebu/platsmp.c            |    1 +
 arch/arm/mach-netx/Kconfig               |    3 -
 arch/arm/mach-nspire/Makefile.boot       |    0
 arch/arm/mach-omap2/Makefile.boot        |    3 -
 arch/arm/mach-orion5x/Makefile.boot      |    3 -
 arch/arm/mach-prima2/Makefile.boot       |    3 -
 arch/arm/mach-realview/Makefile.boot     |    9 -
 arch/arm/mach-s3c64xx/Makefile.boot      |    2 -
 arch/arm/mach-shmobile/Kconfig           |    2 -
 arch/arm/mach-shmobile/common.h          |    5 +-
 arch/arm/mach-shmobile/cpufreq.c         |    2 +
 arch/arm/mach-shmobile/headsmp-scu.S     |    2 +-
 arch/arm/mach-shmobile/platsmp-scu.c     |   10 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c |    7 +-
 arch/arm/mach-shmobile/smp-emev2.c       |    3 +-
 arch/arm/mach-shmobile/smp-r8a7779.c     |    3 +-
 arch/arm/mach-shmobile/smp-sh73a0.c      |    3 +-
 arch/arm/mach-shmobile/suspend.c         |    2 +
 arch/arm/mach-shmobile/timer.c           |    2 +
 arch/arm/mach-spear/Makefile.boot        |    3 -
 arch/arm/mach-u300/Makefile.boot         |    4 -
 arch/arm/mach-ux500/Makefile.boot        |    3 -
 arch/arm/mach-zynq/Makefile.boot         |    3 -
 arch/arm/plat-versatile/Kconfig          |    3 -
 arch/arm/plat-versatile/Makefile         |    1 -
 arch/arm/plat-versatile/clock.c          |   74 --
 42 files changed, 30 insertions(+), 1672 deletions(-)
