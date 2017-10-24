From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Oct 2017 20:20:42 +0800
Subject: [GIT PULL 1/4] i.MX SoC changes for 4.15
Message-ID: <1508847645-9191-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.15

for you to fetch changes up to 8e2b04b019c824186548eadd70243dbb97a1675b:

  cpufreq: imx6q: Move speed grading check to cpufreq driver (2017-10-18 10:08:21 +0800)

----------------------------------------------------------------
i.MX SoC changes for 4.15:
 - A series from Marco Franchi from to clean up build warnings see with
   W=1 in arch/arm/mach-imx/.
 - Move i.MX6 speed grading check from i.MX platform code to cpufreq
   driver.  The patch is suggested by cpufreq folks to go through
   arm-soc tree.
 - Enable cpuidle support on i.MX6DL starting from IMX_CHIP_REVISION_1_1.
 - Constify platform_suspend_ops for MXS platform.

----------------------------------------------------------------
Arvind Yadav (1):
      ARM: mxs: constify platform_suspend_ops

Fabio Estevam (1):
      cpufreq: imx6q: Move speed grading check to cpufreq driver

Leonard Crestez (1):
      ARM: imx: Enable cpuidle for i.MX6DL starting at 1.1

Marco Franchi (4):
      ARM: imx: imx31moboard: Include "board-mx31moboard.h" header file
      ARM: imx: 3ds-debugboard: Include "3ds_debugboard.h" header file
      ARM: imx: cpuidle-imx5: Include "cpuidle.h" header file
      ARM: imx: mach-mx31lite: Make mx31lite_map_io static

 arch/arm/mach-imx/3ds_debugboard.c       |  2 +-
 arch/arm/mach-imx/cpuidle-imx5.c         |  1 +
 arch/arm/mach-imx/mach-imx6q.c           | 97 +++-----------------------------
 arch/arm/mach-imx/mach-mx31lite.c        |  2 +-
 arch/arm/mach-imx/mx31moboard-devboard.c |  1 +
 arch/arm/mach-imx/mx31moboard-marxbot.c  |  1 +
 arch/arm/mach-mxs/pm.c                   |  2 +-
 drivers/cpufreq/imx6q-cpufreq.c          | 85 +++++++++++++++++++++-------
 8 files changed, 79 insertions(+), 112 deletions(-)
