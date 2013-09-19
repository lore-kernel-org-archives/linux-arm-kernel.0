From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 19 Sep 2013 15:52:24 +0530
Subject: [GIT PULL] DaVinci fixes for v3.12-rc
Message-ID: <523AD060.8000504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v3.12-rc2

for you to fetch changes up to caf9269f883bf0d5b83384efb96e2aa572d1d013:

  ARM: edma: dt: create unused channel list (2013-09-19 15:13:32 +0530)

----------------------------------------------------------------
DaVinci fixes for v3.12-rc2
---------------------------

This pull request includes:

1) A patch to fix build breakage with DEBUG_LL
2) A patch to quell a build-time warning.
3) A patch to complete the DT support for EDMA. Without
   this patch, the DT support for EDMA cannot be used.
   There are no in-tree DT users of EDMA currently but
   nevertheless the patch fixes a previously incomplete
   implementation.

----------------------------------------------------------------
Brian Norris (1):
      ARM: davinci: dm365 evm: fix unused variable warning

Joel Fernandes (1):
      ARM: edma: dt: create unused channel list

Sekhar Nori (1):
      ARM: davinci: fix build breakage with DEBUG_LL

 arch/arm/common/edma.c                      |   39 ++++++++++++++++++++++-----
 arch/arm/mach-davinci/board-dm365-evm.c     |    2 +-
 arch/arm/mach-davinci/include/mach/serial.h |    4 +--
 3 files changed, 35 insertions(+), 10 deletions(-)
