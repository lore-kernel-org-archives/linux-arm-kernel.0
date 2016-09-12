From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 12 Sep 2016 17:02:25 +0800
Subject: [GIT PULL 2/5] i.MX soc updates for 4.9
In-Reply-To: <1473670948-4265-1-git-send-email-shawnguo@kernel.org>
References: <1473670948-4265-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1473670948-4265-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.9

for you to fetch changes up to d64299daf44c7ff57120a379ceb4907f19bbf041:

  ARM: imx: build cpuidle-imx6sx.o for imx6ul (2016-09-08 22:12:10 +0800)

----------------------------------------------------------------
i.MX SoC updates for 4.9:
 - Set INT_MEM_CLK_LPM bit to get proper WAIT mode support on i.MX6SX.
   This is a workaround for i.MX6SX WAIT mode hardware issue.
 - Enable cpuidle support with 3 low-power states (WFI, WAIT, POWER-OFF)
   for i.MX6UL.

----------------------------------------------------------------
Anson Huang (3):
      ARM: imx: rename imx6q_set_int_mem_clk_lpm() function
      ARM: imx: enable WAIT mode hardware workaround for imx6sx
      ARM: imx: add cpuidle support for i.mx6ul

Arnd Bergmann (1):
      ARM: imx: build cpuidle-imx6sx.o for imx6ul

 arch/arm/mach-imx/Makefile         |  1 +
 arch/arm/mach-imx/common.h         |  2 +-
 arch/arm/mach-imx/cpuidle-imx6q.c  |  2 +-
 arch/arm/mach-imx/cpuidle-imx6sx.c | 11 +++++++++++
 arch/arm/mach-imx/mach-imx6ul.c    |  3 +++
 arch/arm/mach-imx/pm-imx6.c        |  8 ++++----
 6 files changed, 21 insertions(+), 6 deletions(-)
