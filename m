From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 May 2012 15:38:43 -0700
Subject: [GIT PULL 5/5] omap hwmod changes for v3.5 merge window
In-Reply-To: <pull-1336430323-742388>
Message-ID: <mailman.8.1336430347.1417.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9c3a3009f1c66f4a758b1e5d31b6977185d70a56:

  Merge tag 'omap-cleanup-b-for-3.5' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into cleanup-hwmod (2012-04-19 17:43:42 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-hwmod-for-v3.5

for you to fetch changes up to 1df82cd6d7673006ae2ecbe8745bcf44f61c53a8:

  Merge tag 'omap-devel-a-for-3.5' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into devel-hwmod (2012-04-19 17:45:33 -0700)

----------------------------------------------------------------

Add most of remaining hwmods for omap4

----------------------------------------------------------------
Benot Cousson (6):
      ARM: OMAP4: hwmod data: add GPMC
      ARM: OMAP4: hwmod data: add the Slimbus IP blocks
      ARM: OMAP4: hwmod data: add McASP
      ARM: OMAP4: hwmod data: add remaining USB-related IP blocks
      ARM: OMAP4: hwmod data: add the OCP-WP IP block
      ARM: OMAP4: hwmod data: add DEBUGSS skeleton

Ming Lei (1):
      ARM: OMAP4: hwmod data: introduce fdif(face detect module) hwmod

Paul Walmsley (8):
      ARM: OMAP2+: clockdomains: make {prm,cm}_clkdm common
      ARM: OMAP4: hwmod data: add HDQ/1-wire
      ARM: OMAP4: hwmod data: add EMIF1 and 2
      ARM: OMAP4: hwmod data: add GPU
      ARM: OMAP4: hwmod data: add some interconnect-related IP blocks
      ARM: OMAP4: hwmod data: add OCM RAM IP block
      ARM: OMAP4: hwmod data: add System Control Module
      ARM: OMAP4: hwmod data: add PRCM and related IP blocks

Tony Lindgren (1):
      Merge tag 'omap-devel-a-for-3.5' of git://git.kernel.org/.../pjw/omap-pending into devel-hwmod

 arch/arm/mach-omap2/Makefile                     |    8 +-
 arch/arm/mach-omap2/clockdomain44xx.c            |    6 +
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |   10 -
 arch/arm/mach-omap2/clockdomains44xx_data.c      |    2 +
 arch/arm/mach-omap2/clockdomains_common_data.c   |   24 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c       | 1504 ++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h     |    1 +
 7 files changed, 1463 insertions(+), 92 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains_common_data.c
