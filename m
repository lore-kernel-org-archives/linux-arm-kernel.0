From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 17:54:12 +0900
Subject: [GIT PULL 00/16] Renesas ARM based SoC cleanups for v3.14
Message-ID: <cover.1385628709.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Olof and Arnd,

please consider these Renesas ARM based SoC cleanups for v3.14.

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-for-v3.14

for you to fetch changes up to 8af3f18b7b42e32387b54d2e2f8300589b0198e9:

  ARM: shmobile: sh7372: tidyup clock table order (2013-11-24 15:14:32 +0900)

----------------------------------------------------------------
Renesas ARM based SoC cleanups for v3.14

* Tidy up clock table order for r7s72100, r8a7779, r8a7779, r8a7790,
  sh7372 and sh73a0 SoCs.
* Tidy up camera-rcar header for r8a7779 SoC
* Tidy up registration of VIN on r8a7779 SoC
* Tidy up PFC registration on r8a7790 SoC
* Correct typo in clocks for r8a7790 SoC
* Don't use named resources for IPMMU, I2C and TMU on sh73a0 SoC
* Don't use named resources for MMCIF and SDHI on ape6evm board
* Don't use named resources for MMCIF on lager board
* Tidy up device registration on lager board
* Tidy up headers for bockw board

----------------------------------------------------------------
Kuninori Morimoto (13):
      ARM: shmobile: ape6evm: don't use named resource for MMCIF
      ARM: shmobile: ape6evm: don't use named resource for SDHI
      ARM: shmobile: lager: don't use named resource for MMCIF
      ARM: shmobile: sh73a0: don't use named resource for TMU
      ARM: shmobile: sh73a0: don't use named resource for I2C
      ARM: shmobile: sh73a0: don't use named resource for IPMMU
      ARM: shmobile: bockw: header cleanup
      ARM: shmobile: r8a7779: cleanup registration of VIN
      ARM: shmobile: r8a7779: camera-rcar header cleanup
      ARM: shmobile: r8a7779: cleanup registration of sh_eth
      ARM: shmobile: sh73a0: tidyup clock table order
      ARM: shmobile: r7s72100: tidyup clock table order
      ARM: shmobile: sh7372: tidyup clock table order

Magnus Damm (2):
      ARM: shmobile: Cosmetic update of Lager DT Reference
      ARM: shmobile: Add r8a7790_register_pfc() function

Simon Horman (1):
      ARM: shmobile: r8a7790: Correct typo in clocks

 arch/arm/mach-shmobile/board-ape6evm.c         |  6 +--
 arch/arm/mach-shmobile/board-bockw-reference.c |  1 -
 arch/arm/mach-shmobile/board-lager-reference.c |  5 +--
 arch/arm/mach-shmobile/board-lager.c           |  2 +-
 arch/arm/mach-shmobile/board-marzen.c          | 25 ++++++++++-
 arch/arm/mach-shmobile/clock-r7s72100.c        |  3 ++
 arch/arm/mach-shmobile/clock-r8a7790.c         |  2 +-
 arch/arm/mach-shmobile/clock-sh7372.c          |  9 ++--
 arch/arm/mach-shmobile/clock-sh73a0.c          | 14 ++++---
 arch/arm/mach-shmobile/include/mach/r8a7779.h  |  5 ---
 arch/arm/mach-shmobile/setup-r8a7779.c         | 57 --------------------------
 arch/arm/mach-shmobile/setup-r8a7790.c         |  7 +++-
 arch/arm/mach-shmobile/setup-sh73a0.c          | 16 ++++----
 13 files changed, 59 insertions(+), 93 deletions(-)
