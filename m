From: horms@verge.net.au (Simon Horman)
Date: Thu,  8 Nov 2012 10:27:29 +0900
Subject: [GIT PULL v2] Renesas ARM-based SoC boards for v3.8 #2
Message-ID: <1352338056-21107-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following board enhancements for 3.8.

* This pull-request is based on an earlier request which I
  posted on the 1st and was merged yesterday: [GIT PULL v3] Renesas
  ARM-based SoC boards for v3.8

* This pull request replaces the one that I sent yesterday:
  [GIT PULL] Renesas ARM-based SoC boards for v3.8 #2

* Patch #2 of this series has a build-time dependency on
  the soc pull request that I sent a few minutes ago:
  [GIT PULL] Renesas ARM-based SoC for v3.8 #2

  In particular, "ARM: shmobile: marzen: add USB EHCI driver support"
  depends on "[PATCH 1/7] ARM: shmobile: r8a7779: PFC rename PENCx -> USB_PENCx"

* Patch 4 of this pull-request is a driver patch which is a dependency
  of patches 6 and 7 of this pull-request. I have spoken to the driver
  maintainer, Paul Mundt, and he has indicated that he thinks it
  is best to merge all in one go.

  In more detail:

  "sh: clkfwk: add sh_clk_fsidiv_register()" is a dependency of
  - "ARM: shmobile: sh7372: use sh_clk_fsidiv_register() for FSI-DIV clocks"
  - "ARM: shmobile: r8a7740: add FSI-DVI clocks"

----------------------------------------------------------------
The following changes since commit 631a7b5d958d2ef2c2333b105794c693642f0641:

  ARM: shmobile: Remove G4EVM machine support (2012-10-30 15:25:59 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git boards

for you to fetch changes up to 32ce635f0251bf5b2232cc59151d344303b73718:

  ARM: shmobile: r8a7740: add FSI-DVI clocks (2012-11-08 10:16:13 +0900)

----------------------------------------------------------------
Kuninori Morimoto (7):
      ARM: shmobile: marzen: add USB phy support
      ARM: shmobile: marzen: add USB EHCI driver support
      ARM: shmobile: marzen: add USB OHCI driver support
      sh: clkfwk: add sh_clk_fsidiv_register()
      ARM: shmobile: sh7372: sh7372_fsidivX_clk become non-global
      ARM: shmobile: sh7372: use sh_clk_fsidiv_register() for FSI-DIV clocks
      ARM: shmobile: r8a7740: add FSI-DVI clocks

 arch/arm/configs/marzen_defconfig            |   14 +-
 arch/arm/mach-shmobile/Kconfig               |    2 +
 arch/arm/mach-shmobile/board-ap4evb.c        |    2 +-
 arch/arm/mach-shmobile/board-mackerel.c      |    2 +-
 arch/arm/mach-shmobile/board-marzen.c        |  186 +++++++++++++++++++++++++-
 arch/arm/mach-shmobile/clock-r8a7740.c       |   16 +++
 arch/arm/mach-shmobile/clock-sh7372.c        |   92 ++-----------
 arch/arm/mach-shmobile/include/mach/sh7372.h |    2 -
 drivers/sh/clk/cpg.c                         |   86 ++++++++++++
 include/linux/sh_clk.h                       |    9 ++
 10 files changed, 321 insertions(+), 90 deletions(-)
