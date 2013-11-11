From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Nov 2013 23:31:51 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.13
Message-ID: <20131111153124.GD11083@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit edae583a6d4d1ad2eb73981787790993fef1bbad:

  Merge tag 'arc-v3.13-rc1-part1' of git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc (2013-11-11 18:19:06 +0900)

are available in the git repository at:


  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.13

for you to fetch changes up to 036e29918078e38b0b127b89deb4c595028c1bc0:

  ARM: dts: i.MX51: Fix OTG PHY clock (2013-11-11 22:58:45 +0800)

----------------------------------------------------------------
The imx fixes for 3.13:
 - A couple of imx5 and imx6 clock fixes
 - Two follow-up patches for improving/fixing the commit "ARM: imx:
   replace imx6q_restart()with mxc_restart()"
 - One compile fix for imx6sl with randconfig
 - Commits to fix pllv3 relock/power issues found in IPU/HDMI testing

----------------------------------------------------------------
Alexander Shiyan (1):
      ARM: dts: i.MX51: Fix OTG PHY clock

Jiada Wang (1):
      ARM: i.MX6q: fix the wrong parent of can_root clock

Lothar Wa?mann (1):
      ARM: imx6q: add missing sentinel to divider table

Shawn Guo (6):
      ARM: imx: remove imx_src_prepare_restart() call
      ARM: imx: improve mxc_restart() on the SRC bit writes
      ARM: imx: v7_cpu_resume() is needed by imx6sl build
      ARM: imx: add sleep for pllv3 relock
      ARM: imx: pllv3 needs relock in .set_rate() call
      ARM: imx: set up pllv3 POWER and BYPASS sequentially

 arch/arm/boot/dts/imx51.dtsi  |    2 +-
 arch/arm/mach-imx/Makefile    |    4 ++--
 arch/arm/mach-imx/clk-imx6q.c |    7 +++---
 arch/arm/mach-imx/clk-pllv3.c |   51 +++++++++++++++++++++++++++--------------
 arch/arm/mach-imx/common.h    |    5 ----
 arch/arm/mach-imx/src.c       |   15 ------------
 arch/arm/mach-imx/system.c    |   12 ++++++----
 7 files changed, 49 insertions(+), 47 deletions(-)
