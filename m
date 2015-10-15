From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 09:33:02 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Cleanup for v4.4
Message-ID: <cover.1444868660.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC cleanup for v4.4.

This pull request is based on the previous round of
such requests, tagged as renesas-cleanup-for-v4.4,
which you have already pulled.


The following changes since commit 04418c23a9411b85b8789eab5f4397bcbd62b7b4:

  ARM: shmobile: Remove legacy clock support leftovers (2015-09-14 10:06:56 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup2-for-v4.4

for you to fetch changes up to 1fd377b3fc1e071702e27b2f828e3abd8b31c74d:

  ARM: shmobile: R-Mobile: add missing of_node_put (2015-10-12 09:15:29 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Cleanup for v4.4

* Remove now unused legacy pm domain code
* Add missing of_node_put to pm-rmobile
* Corresct spelling of interrupt-names in renesas-memory-controller binding
  documentation
* Correct signdness of CPU id in shmobile apmu implementation
* Make some functions static as appropriate

----------------------------------------------------------------
Andrzej Hajda (1):
      ARM: shmobile: apmu: correct type of CPU id

Geert Uytterhoeven (3):
      ARM: shmobile: smp: Make shmobile_smp_apmu_cpu_shutdown() static
      ARM: shmobile: r8a7778: Make r8a7778_init_irq_dt() static
      ARM: shmobile: r8a7779: Remove legacy PM Domain remainings

Julia Lawall (1):
      ARM: shmobile: R-Mobile: add missing of_node_put

Lee Jones (1):
      ARM: shmobile: dt: Rename incorrect interrupt related binding

 .../renesas-memory-controllers.txt                 |  6 +-
 arch/arm/mach-shmobile/platsmp-apmu.c              |  4 +-
 arch/arm/mach-shmobile/pm-r8a7779.c                | 99 ----------------------
 arch/arm/mach-shmobile/pm-rmobile.c                |  4 +-
 arch/arm/mach-shmobile/r8a7779.h                   |  6 --
 arch/arm/mach-shmobile/setup-r8a7778.c             |  3 +-
 6 files changed, 10 insertions(+), 112 deletions(-)
