From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:41:47 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Marzen Board Removal for v4.3
Message-ID: <cover.1437726584.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC marzen board removal for v4.3.

This series removes legacy r8a7779 SoC and marzen board code.
It does so in a way that does not introduce feature regressions
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
renesas-next-20150724-v4.2-rc1 tag of the renesas tree.

I would be happy to rebase these patches on top of renesas-cleanup-for-v4.3
and resubmit a conflict-free pull request if you like.

On a more positive note, I believe this to well over 8000 lines of legacy
code removed in this cycle :)


The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-marzen-board-removal-for-v4.3

for you to fetch changes up to 3fecc170e5b7b141a2db6c8bc40607fb323c3aa2:

  ARM: shmobile: r8a7779: Remove legacy SoC code (2015-07-17 10:34:51 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Marzen Board Removal for v4.3

* Remove legacy r8a7779 SoC code
* Remove legacy marzen board code

3fecc170e5b7 ARM: shmobile: r8a7779: Remove legacy SoC code
9d35777f2b96 ARM: shmobile: marzen: Remove legacy board code
8dd80b6d7c5b ARM: multi_v7_defconfig: Remove Marzen
824fd0fb7daa ARM: shmobile: Remove Marzen from shmobile_defconfig
a73e4d95da66 ARM: shmobile: r8a7779: Cleanup header file
d2fb6bdaffc7 ARM: shmobile: marzen-reference: Remove C board code
719074d8b220 ARM: shmobile: Enable fixed voltage regulator in shmobile_defconfig
44ade5edf90c ARM: shmobile: r8a7779: Generic SMP ops
131c2e0480b0 ARM: shmobile: r8a7779: Generic CCF and timer support

----------------------------------------------------------------
Magnus Damm (7):
      ARM: shmobile: r8a7779: Generic CCF and timer support
      ARM: shmobile: r8a7779: Generic SMP ops
      ARM: shmobile: marzen-reference: Remove C board code
      ARM: shmobile: r8a7779: Cleanup header file
      ARM: shmobile: Remove Marzen from shmobile_defconfig
      ARM: shmobile: marzen: Remove legacy board code
      ARM: shmobile: r8a7779: Remove legacy SoC code

Simon Horman (2):
      ARM: shmobile: Enable fixed voltage regulator in shmobile_defconfig
      ARM: multi_v7_defconfig: Remove Marzen

 arch/arm/boot/dts/Makefile                      |   1 -
 arch/arm/configs/multi_v7_defconfig             |   1 -
 arch/arm/configs/shmobile_defconfig             |   2 +-
 arch/arm/mach-shmobile/Kconfig                  |  14 -
 arch/arm/mach-shmobile/Makefile                 |   6 +-
 arch/arm/mach-shmobile/Makefile.boot            |   1 -
 arch/arm/mach-shmobile/board-marzen-reference.c |  56 --
 arch/arm/mach-shmobile/board-marzen.c           | 347 ------------
 arch/arm/mach-shmobile/clock-r8a7779.c          | 271 ----------
 arch/arm/mach-shmobile/r8a7779.h                |  19 -
 arch/arm/mach-shmobile/setup-r8a7779.c          | 681 +-----------------------
 arch/arm/mach-shmobile/smp-r8a7779.c            |   9 -
 12 files changed, 16 insertions(+), 1392 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/board-marzen-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-marzen.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r8a7779.c
