From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 29 Apr 2016 17:37:04 +0530
Subject: [GIT PULL 1/4] DaVinci SoC updates for v4.7 (part 2)
Message-ID: <1461931627-27761-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8a9d088f66f84d7317b4adc64d3d3114f1ee8583:

  ARM: davinci: clk: add set_parent callback for mux clocks (2016-04-14 15:31:48 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.7/soc-part2

for you to fetch changes up to 3f2a09d57bb12ca55f92209b3ef0c0684cdb20b0:

  ARM: davinci: da850: use clk->set_parent for async3 (2016-04-27 16:04:41 +0530)

----------------------------------------------------------------
These patches provide ability to add non-PSC
clocks to DaVinci clock framwork and are
required to support USB PHY clock setting from
USB PHY driver.

----------------------------------------------------------------
David Lechner (2):
      ARM: davinci: Move clock init after ioremap.
      ARM: davinci: da850: use clk->set_parent for async3

 arch/arm/mach-davinci/clock.c  |  2 +-
 arch/arm/mach-davinci/common.c |  6 ---
 arch/arm/mach-davinci/da830.c  |  2 +
 arch/arm/mach-davinci/da850.c  | 83 ++++++++++++++++++------------------------
 arch/arm/mach-davinci/dm355.c  |  1 +
 arch/arm/mach-davinci/dm365.c  |  1 +
 arch/arm/mach-davinci/dm644x.c |  1 +
 arch/arm/mach-davinci/dm646x.c |  1 +
 8 files changed, 42 insertions(+), 55 deletions(-)
