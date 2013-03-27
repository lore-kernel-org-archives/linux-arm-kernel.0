From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 27 Mar 2013 22:03:17 +0100
Subject: [GIT PULL PATCH 0/3] Ux500 devicetree fixes
Message-ID: <1364418200-15628-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Here are three fixes to get the device tree booting properly again
on the Ux500 platforms.

I am sending out the patches so as to make sure everyone has had
a chance to look at them.

If you like them, please pull this into the ARM SoC tree.

Thanks!
Linus Walleij


The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git tags/ux500-fixes-for-v3.9

for you to fetch changes up to 265c3c0a64df50c0e8fe55cfe8af8851ed5feca5:

  ARM: ux500: Enable the clock controlling Ethernet on Snowball (2013-03-27 20:20:40 +0100)

----------------------------------------------------------------
Fixes boot regressions on Device Tree:
- Get TCPM and TCDM locations from the device tree
- Skip passing the ios_handler for the MMCI
- Enable the ethernet clock for Snowball

----------------------------------------------------------------
Lee Jones (3):
      ARM: ux500: Apply the TCPM and TCDM locations and sizes to dbx5x0 DT
      ARM: ux500: Stop passing ios_handler() as an MMCI power controlling call-back
      ARM: ux500: Enable the clock controlling Ethernet on Snowball

 arch/arm/boot/dts/dbx5x0.dtsi          |  4 ++--
 arch/arm/mach-ux500/board-mop500-sdi.c |  1 -
 arch/arm/mach-ux500/board-mop500.c     | 12 ++++++++++++
 arch/arm/mach-ux500/board-mop500.h     |  1 +
 arch/arm/mach-ux500/cpu-db8500.c       |  5 +++--
 5 files changed, 18 insertions(+), 5 deletions(-)
