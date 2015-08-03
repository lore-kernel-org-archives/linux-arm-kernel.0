From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  3 Aug 2015 15:04:55 +0900
Subject: [GIT PULL v2] Renesas ARM Based SoC Marzen Board Removal for v4.3
Message-ID: <cover.1438581659.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC marzen board removal for v4.3.


This series removes legacy r8a7779 SoC and marzen board code.
It aims to do do so in a way that does not introduce feature regressions
when when booting the r8a7779/marzen board using shmobile_defconfig,
which provides for booting using multiplatform, a scenario which previously
used board code to provide some features including SMP.

Because of the above this series modifies SoC and DT files,
and then removes code. And because of that it was not entirely clear to
me which branch it should go into, so I have provided it in a stand-alone
branch.

Unfortunately this branch has a number of minor conflicts with the "Renesas
ARM Based SoC Cleanup for v4.3", tagged as renesas-cleanup-for-v4.3, which
you have previously pulled.

A resolution to those conflicts can be found in the
renesas-next-20150730-v4.2-rc1 tag of the renesas tree.

On a more positive note, I believe this to well over 8000 lines of legacy
code removed in this cycle :)


Changes between v1 and v2:

* As requested by Olof: Do not include defconfig updates;
  these will be handled separately


The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-marzen-board-removal-for-v4.3

for you to fetch changes up to c99cd90d98a98aa101b169e44d249e5cd71f46f2:

  ARM: shmobile: r8a7779: Remove legacy SoC code (2015-07-28 09:27:16 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Marzen Board Removal for v4.3

* Remove legacy r8a7779 SoC code
* Remove legacy marzen board code

----------------------------------------------------------------
Magnus Damm (6):
      ARM: shmobile: r8a7779: Generic CCF and timer support
      ARM: shmobile: r8a7779: Generic SMP ops
      ARM: shmobile: marzen-reference: Remove C board code
      ARM: shmobile: r8a7779: Cleanup header file
      ARM: shmobile: marzen: Remove legacy board code
      ARM: shmobile: r8a7779: Remove legacy SoC code

 arch/arm/boot/dts/Makefile                      |   1 -
 arch/arm/mach-shmobile/Kconfig                  |  14 -
 arch/arm/mach-shmobile/Makefile                 |   6 +-
 arch/arm/mach-shmobile/Makefile.boot            |   1 -
 arch/arm/mach-shmobile/board-marzen-reference.c |  56 --
 arch/arm/mach-shmobile/board-marzen.c           | 347 ------------
 arch/arm/mach-shmobile/clock-r8a7779.c          | 271 ----------
 arch/arm/mach-shmobile/r8a7779.h                |  19 -
 arch/arm/mach-shmobile/setup-r8a7779.c          | 681 +-----------------------
 arch/arm/mach-shmobile/smp-r8a7779.c            |   9 -
 10 files changed, 15 insertions(+), 1390 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/board-marzen-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-marzen.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r8a7779.c
