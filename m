From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 4 Mar 2013 14:28:29 +0800
Subject: [GIT PULL] imx fixes for 3.9
Message-ID: <20130304062828.GD30431@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.9

for you to fetch changes up to 0545c798e9bb7fe29606681653c20d68e47f4840:

  ARM: dts: imx53-mba53: fix fsl,pins for disp1-grp1 (2013-03-04 09:20:15 +0800)

----------------------------------------------------------------
The imx fixes for 3.9:
 - move early resume code out of .data section to fix allyesconfig
   failure since c08e20d (arm: Add v7_invalidate_l1 to cache-v7.S)
   gets merged
 - Fix incorrect DISP1_DAT_21 number in imx53-mba53 disp1-grp1

----------------------------------------------------------------
Nicolas Pitre (1):
      ARM: mach-imx: move early resume code out of the .data section

Shawn Guo (1):
      ARM: dts: imx53-mba53: fix fsl,pins for disp1-grp1

 arch/arm/boot/dts/imx53-mba53.dts |    3 +--
 arch/arm/mach-imx/headsmp.S       |   18 +++++++++---------
 arch/arm/mach-imx/pm-imx6q.c      |   15 ---------------
 3 files changed, 10 insertions(+), 26 deletions(-)
