From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:54 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Cleanup for v3.17
Message-ID: <cover.1403487831.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC Cleanup for v3.17.


This pull request is based on 'Renesas ARM Based SoC Header Cleanup for v3.17',
tagged as header-cleanup-for-v3.17, which I have already sent a
pull-request for.


The following changes since commit 62872989bdbf1245d7239b9f4c05a8ee7c775ed5:

  ARM: shmobile: Move rcar-gen2.h, cleanup r8a7790 case (2014-06-17 17:09:40 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-soc-cleanup-for-v3.17

for you to fetch changes up to d83fa4c9c27c4d8612e39e99506b5420fa05b58b:

  ARM: shmobile: Remove unused r8a7790_init_early() (2014-06-17 19:50:35 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Cleanup for v3.17

* Use shmobile_init_delay on r8a7790, r7s72100 and EMEV2 SoCs
* Remove unused redundant callbacks on EMEV2 SoC

----------------------------------------------------------------
Magnus Damm (9):
      ARM: shmobile: Update EMEV2 DTS to include CPU frequency
      ARM: shmobile: Use shmobile_init_delay() on EMEV2
      ARM: shmobile: Get rid of redundant EMEV2 mach callbacks
      ARM: shmobile: Update r7s72100 DTS to include CPU frequency
      ARM: shmobile: Use shmobile_init_delay() on Genmai boards
      ARM: shmobile: Use shmobile_init_delay() on r7s72100
      ARM: shmobile: Use r8a7790 DT CPU Frequency in common case
      ARM: shmobile: Use r8a7790 DT CPU Frequency for Lager
      ARM: shmobile: Remove unused r8a7790_init_early()

 arch/arm/boot/dts/emev2.dtsi                    |  2 ++
 arch/arm/boot/dts/r7s72100.dtsi                 |  1 +
 arch/arm/mach-shmobile/board-genmai-reference.c |  2 +-
 arch/arm/mach-shmobile/board-genmai.c           |  2 +-
 arch/arm/mach-shmobile/board-lager-reference.c  |  2 +-
 arch/arm/mach-shmobile/board-lager.c            |  2 +-
 arch/arm/mach-shmobile/include/mach/r7s72100.h  |  1 -
 arch/arm/mach-shmobile/include/mach/r8a7790.h   |  1 -
 arch/arm/mach-shmobile/setup-emev2.c            | 17 ++---------------
 arch/arm/mach-shmobile/setup-r7s72100.c         |  7 +------
 arch/arm/mach-shmobile/setup-r8a7790.c          |  9 +--------
 11 files changed, 11 insertions(+), 35 deletions(-)
