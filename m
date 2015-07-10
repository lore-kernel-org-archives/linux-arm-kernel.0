From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jul 2015 15:37:12 +0900
Subject: [GIT PULL] Renesas ARM Based SoC PM Domain Updates for v4.3
Message-ID: <cover.1436510166.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC PM domain updates for v4.3.


The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-pm-domain-for-v4.3

for you to fetch changes up to bd82aff9192dad2bfd3cb3fc19fdf741c2f6028e:

  ARM: shmobile: r8a7790: Make struct rcar_sysc_ch const (2015-07-06 09:35:24 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC PM Domain Updates for v4.3

* Make rcar_sysc_ch const for r8a779[09] SoCs
* Get rid of on_off_fn() function pointer
* Use BIT() macro instead of open coding
* Make struct rcar_sysc_ch * parameters const
* Break infinite loop
* Shrink rcar_sysc_ch size
* Improve documentation

----------------------------------------------------------------
Geert Uytterhoeven (8):
      ARM: shmobile: R-Car: Improve documentation
      ARM: shmobile: R-Car: Shrink rcar_sysc_ch size
      ARM: shmobile: R-Car: Break infinite loop
      ARM: shmobile: R-Car: Make struct rcar_sysc_ch * parameters const
      ARM: shmobile: R-Car: Use BIT() macro instead of open coding
      ARM: shmobile: R-Car: Get rid of on_off_fn() function pointer
      ARM: shmobile: r8a7779: Make struct rcar_sysc_ch const
      ARM: shmobile: r8a7790: Make struct rcar_sysc_ch const

 arch/arm/mach-shmobile/pm-r8a7779.c  |   3 +-
 arch/arm/mach-shmobile/pm-rcar.c     | 105 ++++++++++++++++++++++-------------
 arch/arm/mach-shmobile/pm-rcar.h     |  12 ++--
 arch/arm/mach-shmobile/smp-r8a7779.c |  12 ++--
 arch/arm/mach-shmobile/smp-r8a7790.c |   4 +-
 5 files changed, 82 insertions(+), 54 deletions(-)
