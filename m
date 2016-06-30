From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:16:11 +0200
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC R-Car SYSC Updates
 for v4.8
Message-ID: <cover.1467292648.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC R-Car SYSC
updates for v4.8.

This pull request is based on the previous round of
such requests, tagged as renesas-rcar-sysc-for-v4.8,
which you have already pulled.


The following changes since commit e0c98b9171eecf1745eda08de86081db8ec41d51:

  soc: renesas: rcar-sysc: Add support for R-Car M3-W power areas (2016-06-06 10:14:21 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-rcar-sysc2-for-v4.8

for you to fetch changes up to ced42730d19dd140a76f86c3761f646b83a35d09:

  soc: renesas: rcar-sysc: Improve SYSC interrupt config in legacy wrapper (2016-06-29 14:37:24 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC R-Car SYSC Updates for v4.8

* Prepare for handling SYSC interrupt configuration purely
  from DT in the rcar-sysc driver for new SoCs, while preserving
  backward compatibility with old DTBs for R-Car H1, H2, and M2-W
* Add R8A7792 support

----------------------------------------------------------------
Geert Uytterhoeven (4):
      soc: renesas: rcar-sysc: Fix uninitialized error code in rcar_sysc_pd_init()
      soc: renesas: rcar-sysc: Make rcar_sysc_init() init the PM domains
      soc: renesas: rcar-sysc: Move SYSC interrupt config to rcar-sysc driver
      soc: renesas: rcar-sysc: Improve SYSC interrupt config in legacy wrapper

Sergei Shtylyov (1):
      soc: renesas: rcar-sysc: add R8A7792 support

 arch/arm/mach-shmobile/pm-r8a7779.c   |  6 +----
 arch/arm/mach-shmobile/pm-rcar-gen2.c |  6 +----
 drivers/soc/renesas/Makefile          |  1 +
 drivers/soc/renesas/r8a7792-sysc.c    | 34 ++++++++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c       | 42 ++++++++++++++++++++++++++---------
 drivers/soc/renesas/rcar-sysc.h       |  1 +
 include/linux/soc/renesas/rcar-sysc.h |  2 +-
 7 files changed, 71 insertions(+), 21 deletions(-)
 create mode 100644 drivers/soc/renesas/r8a7792-sysc.c
