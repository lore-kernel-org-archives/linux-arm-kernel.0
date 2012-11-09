From: horms@verge.net.au (Simon Horman)
Date: Fri,  9 Nov 2012 16:29:15 +0900
Subject: [GIT PULL v2] Renesas ARM-based SoC for v3.8 #2
Message-ID: <1352446165-19298-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following SoC enhancements for 3.8.

* This series is based on the renesas/soc branch of the arm-soc tree.
  There will be a subquent 'SoC2' pull request which is based on this
  pull-request and a pull-request for boards.

----------------------------------------------------------------
The following changes since commit 86bc52ef4373be64867b56f3a9e30cbabf64e0dd:

  ARM: shmobile: r8a7740: Enable PMU (2012-11-06 13:47:24 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git soc

for you to fetch changes up to 2944628607f76e4755660cd710f22a4748ef88d8:

  ARM: shmobile: add fsi external clock sh7372 (2012-11-08 15:22:06 +0900)

----------------------------------------------------------------
Kuninori Morimoto (10):
      ARM: shmobile: r8a7779: PFC rename PENCx -> USB_PENCx
      ARM: shmobile: r8a7740: add USB24 clock explain
      ARM: shmobile: r8a7779: add USB EHCI clock support
      ARM: shmobile: r8a7779: add USB OHCI clock support
      sh: clkfwk: add sh_clk_fsidiv_register()
      ARM: shmobile: sh7372: sh7372_fsidivX_clk become non-global
      ARM: shmobile: sh7372: use sh_clk_fsidiv_register() for FSI-DIV clocks
      ARM: shmobile: r8a7740: add FSI-DVI clocks
      ARM: shmobile: add fsi external clock on r8a7740
      ARM: shmobile: add fsi external clock sh7372

 arch/arm/mach-shmobile/board-ap4evb.c         |    2 +-
 arch/arm/mach-shmobile/board-mackerel.c       |    2 +-
 arch/arm/mach-shmobile/clock-r8a7740.c        |   34 +++++++++
 arch/arm/mach-shmobile/clock-r8a7779.c        |    7 ++
 arch/arm/mach-shmobile/clock-sh7372.c         |   94 ++++---------------------
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    2 +-
 arch/arm/mach-shmobile/include/mach/sh7372.h  |    2 -
 arch/arm/mach-shmobile/pfc-r8a7779.c          |   16 ++---
 drivers/sh/clk/cpg.c                          |   86 ++++++++++++++++++++++
 include/linux/sh_clk.h                        |    9 +++
 10 files changed, 159 insertions(+), 95 deletions(-)
