From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:46 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Cleanups v3.16
Message-ID: <cover.1400200838.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC cleanups v3.16.

This pull request is based on Renesas ARM Based SoC Updates for v3.16,
tagged as renesas-soc-for-v3.16, which you have already pulled.


This series includes dependencies that do not fit easily into the usual
inter-branch dependencies and as such I have grouped them together in a
single branch.


The following changes since commit e35db38d66d1e4007cfc1bb90a05e11b4aaee2a8:

  ARM: shmobile: r8a7778/bockw: Move "select RENESAS_INTC_IRQPIN" under SoC (2014-04-14 11:28:43 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-cleanup-for-v3.16

for you to fetch changes up to f492b81777c93b33afe892b424e022022b5bc297:

  ARM: shmobile: Set clock frequency in HZ from OF nodes (2014-05-14 14:02:21 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC soc-cleanup Updates for v3.16

r8a7791 (R-Car H2) SoC and its Koelsch board and,
r8a7740 (R-Mobile A1) SoC and its Armadillo800eva board
* Set CPU clock frequency from OF nodes

----------------------------------------------------------------
Magnus Damm (8):
      ARM: shmobile: Add r8a7740 Maximum CPU Frequency to DTS
      ARM: shmobile: Use r8a7740 DT CPU Frequency in common case
      ARM: shmobile: Use r8a7740 DT CPU Frequency for Armadillo DT Ref
      ARM: shmobile: Remove unused r8a7740_init_delay()
      ARM: shmobile: Use r8a7791 DT CPU Frequency in common case
      ARM: shmobile: Use r8a7791 DT CPU Frequency for Koelsch
      ARM: shmobile: Remove unused r8a7791_init_early()
      ARM: shmobile: Use shmobile_init_late() on r8a7740

Simon Horman (1):
      ARM: shmobile: Set clock frequency in HZ from OF nodes

 arch/arm/boot/dts/r8a7740.dtsi                     |  1 +
 .../board-armadillo800eva-reference.c              |  2 +-
 arch/arm/mach-shmobile/board-koelsch-reference.c   |  2 +-
 arch/arm/mach-shmobile/board-koelsch.c             |  2 +-
 arch/arm/mach-shmobile/include/mach/r8a7740.h      |  1 -
 arch/arm/mach-shmobile/include/mach/r8a7791.h      |  1 -
 arch/arm/mach-shmobile/setup-r8a7740.c             |  8 ++------
 arch/arm/mach-shmobile/setup-r8a7791.c             |  9 +--------
 arch/arm/mach-shmobile/timer.c                     | 23 +++++++++++++++++++---
 9 files changed, 27 insertions(+), 22 deletions(-)
