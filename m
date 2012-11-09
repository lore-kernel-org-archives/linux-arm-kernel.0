From: horms@verge.net.au (Simon Horman)
Date: Fri,  9 Nov 2012 16:31:39 +0900
Subject: [GIT PULL v3] Renesas ARM-based SoC boards for v3.8 #2
Message-ID: <1352446306-19945-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following board enhancements for 3.8.

* This pull request is based on a merge of
  a) The renesas/boards branch of the arm-soc tree
  b) The soc branch of the renesas tree,
     which I have sent a separate pull requst for

* "sh: clkfwk: add sh_clk_fsidiv_register()" is a driver patch
  which is a dependency of
  - ARM: shmobile: sh7372: use sh_clk_fsidiv_register() for FSI-DIV clocks
  - ARM: shmobile: r8a7740: add FSI-DVI clocks
  I have spoken to the driver maintainer, Paul Mundt, and he has indicated
  that he thinks it is best to merge all in one go and acked the patch for
  inclusion in this pull-request.

* The following patches
  - ARM: shmobile: use FSI driver's audio clock on ap4evb
  - ARM: shmobile: use FSI driver's audio clock on mackerel
  - ARM: shmobile: use FSI driver's audio clock on armadillo800eva
  Have a compile-time dependency on the following patch which is present in
  the for-next branch of Mark Brown's sound tree on kernel.org
  - ASoC: fsi: add master clock control functions
    (ab6f6d85210c4d0265cf48e9958c04e08595055a)

----------------------------------------------------------------
The following changes since commit ab3ff12a78a64b851ab22726ab99dca6ad37bf94:

  Merge branch 'soc' into boards (2012-11-08 17:49:35 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git boards

for you to fetch changes up to 12818d82ccad9868a820dbb193b4f9b797cd02d4:

  ARM: shmobile: use FSI driver's audio clock on ap4evb (2012-11-08 17:52:05 +0900)

----------------------------------------------------------------
Kuninori Morimoto (7):
      ARM: shmobile: marzen: add USB phy support
      ARM: shmobile: marzen: add USB EHCI driver support
      ARM: shmobile: marzen: add USB OHCI driver support
      ARM: shmobile: mackerel: enable DMAEngine on USB Host
      ARM: shmobile: use FSI driver's audio clock on armadillo800eva
      ARM: shmobile: use FSI driver's audio clock on mackerel
      ARM: shmobile: use FSI driver's audio clock on ap4evb

 arch/arm/configs/marzen_defconfig              |   14 +-
 arch/arm/mach-shmobile/Kconfig                 |    2 +
 arch/arm/mach-shmobile/board-ap4evb.c          |  139 +-----------------
 arch/arm/mach-shmobile/board-armadillo800eva.c |   38 +----
 arch/arm/mach-shmobile/board-mackerel.c        |   74 +---------
 arch/arm/mach-shmobile/board-marzen.c          |  186 +++++++++++++++++++++++-
 6 files changed, 205 insertions(+), 248 deletions(-)
