From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:16:22 +0200
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Updates for v4.8
Message-ID: <cover.1467293089.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC updates for v4.8.

This pull request is based on a merge of:

* This pull request is based on the previous round of
  such requests, tagged as renesas-soc-for-v4.8,
  which you have already pulled.

* "Second Round of Renesas ARM Based SoC R-Car SYSC Updates for v4.8",
  tagged as renesas-rcar-sysc2-for-v4.8,
  which I have also sent a pull request for.

  This provides run-time dependencies for APMU patches in this series
  and prevents a regression in the absence of complementary DT updates.


The following changes since commit f0aa411de83c096e09cf46b9ea0d68a1eeab4863:

  Merge branch 'rcar-sysc-for-v4.8' into HEAD (2016-06-29 14:41:43 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v4.8

for you to fetch changes up to f89a51700d7ae0ef58956a8c8f0e2c68767bcdae:

  ARM: shmobile: r8a7791: Prioritize DT APMU support (2016-06-29 14:43:40 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Updates for v4.8

* Add DT support to the APMU driver and prioritise DT APMU support
* Obtain extal frequency from DT
* Add support for r8a7792

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: shmobile: rcar-gen2: Obtain extal frequency from DT
      ARM: shmobile: rcar-gen2: Correct arch timer frequency on R-Car V2H
      ARM: shmobile: apmu: Move #ifdef CONFIG_SMP to cover more functions

Magnus Damm (4):
      ARM: shmobile: apmu: Add APMU DT support via Enable method
      ARM: shmobile: smp: Add function to prioritize DT SMP
      ARM: shmobile: r8a7790: Prioritize DT APMU support
      ARM: shmobile: r8a7791: Prioritize DT APMU support

Sergei Shtylyov (1):
      ARM: shmobile: r8a7792: basic SoC support

 arch/arm/mach-shmobile/Kconfig           |  4 ++
 arch/arm/mach-shmobile/Makefile          |  1 +
 arch/arm/mach-shmobile/common.h          |  1 +
 arch/arm/mach-shmobile/platsmp-apmu.c    | 94 ++++++++++++++++++++++++++++++--
 arch/arm/mach-shmobile/platsmp.c         |  6 ++
 arch/arm/mach-shmobile/setup-r8a7790.c   |  1 +
 arch/arm/mach-shmobile/setup-r8a7791.c   |  1 +
 arch/arm/mach-shmobile/setup-r8a7792.c   | 35 ++++++++++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 45 ++++++++-------
 9 files changed, 162 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7792.c
