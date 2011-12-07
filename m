From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Dec 2011 11:40:16 -0800
Subject: [GIT PULL] More omap1 boot regression fixes for v3.2-rc4
Message-ID: <20111207194015.GH31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please pull omap1 fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

These are still needed to deal with breakage of moving reprogramming
of the DPLL1 later on in commit a66cb3454f220f49f900646ebdc76cb943319eb7.

That commit caused multiple issues for omap1 boards that did not have
OMAP_CLOCKS_SET_BY_BOOTLOADER set. This series fixes issues for boards
booting at less than 60MHz rate, at least Amstrad Delta is known to
not work without this series.

Regards,

Tony


The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:
  Linus Torvalds (1):
        Linux 3.2-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Janusz Krzysztofik (3):
      ARM: OMAP1: Remove unsafe clock values from omap1_defconfig
      ARM: OMAP1: Fix ckctl value used for dpll1 defualt rate
      ARM: OMAP1: recalculate loops per jiffy after dpll1 reprogram

Tony Lindgren (1):
      ARM: OMAP1: Fix reprogramming of DPLL1 for systems that boot at rates below 60MHz

 arch/arm/configs/omap1_defconfig |    5 -----
 arch/arm/mach-omap1/clock_data.c |   12 ++++++++++--
 2 files changed, 10 insertions(+), 7 deletions(-)
