From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 Jul 2013 16:36:47 +0900
Subject: [GIT 0/5] Renesas ARM based SoC fixes for v3.12
Message-ID: <cover.1374478336.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,
										please consider the following fixes v3.12.

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v3.12

for you to fetch changes up to 93d8a6fbe69a629a7bb37bb546699a5c49963dc5:

  ARM: shmobile: r8a7740: Fix TPU clock name (2013-07-19 11:12:35 +0900)

----------------------------------------------------------------
Renesas ARM based SoC fixes for v3.12

* Fix TPU clock name for r8a7740 SoC
* Update romImage to relocate appended DTB
* Thumb fixes

----------------------------------------------------------------
Laurent Pinchart (1):
      ARM: shmobile: r8a7740: Fix TPU clock name

Magnus Damm (1):
      ARM: shmobile: Update romImage to relocate appended DTB

Tetsuyuki Kobayashi (3):
      ARM: shmobile: fix compile error when CONFIG_THUMB2_KERNEL=y
      ARM: shmobile: Force ARM mode to compile reset vector for secondary CPUs
      ARM: shmobile: Insert align directives before 4 bytes data

 arch/arm/boot/compressed/head-shmobile.S    | 43 ++++++++++++++++++++++++++---
 arch/arm/mach-shmobile/clock-r8a7740.c      |  2 +-
 arch/arm/mach-shmobile/headsmp-scu.S        |  4 ++-
 arch/arm/mach-shmobile/headsmp.S            |  6 +++-
 arch/arm/mach-shmobile/include/mach/zboot.h |  2 --
 arch/arm/mach-shmobile/sleep-sh7372.S       |  2 ++
 6 files changed, 50 insertions(+), 9 deletions(-)
