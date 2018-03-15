From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 15 Mar 2018 19:36:36 +0800
Subject: [GIT PULL 2/6] i.MX SoC changes for 4.17
In-Reply-To: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
References: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1521113800-16401-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.17

for you to fetch changes up to dee5dee2a5b285d20f55a4758d3a51349691eeea:

  ARM: imx: Add basic msl support for imx6sll (2018-03-09 09:22:06 +0800)

----------------------------------------------------------------
i.MX SoC changes for 4.17:
 - Add i.MX 6SoloLiteLite (i.MX6SLL) SoC support on top of the existing
   i.MX6SL platform code.
 - Improve the SoC revision mapping by utilizing the MAJOR field of
   ANATOP DIGPROG register.
 - Add CPUIDLE_FLAG_TIMER_STOP flag for cpuidle ARM power off state,
   so that we can use ARM generic timer for some i.MX6 SoC.
 - Set low-power interrupt mask for i.MX25 to support STOP mode.
 - Drop EPIT driver as there is no user of it.
 - Simplify the error path of imx6_pm_get_base() a bit.

----------------------------------------------------------------
Bai Ping (2):
      ARM: imx: Improve the soc revision calculation flow
      ARM: imx: Add basic msl support for imx6sll

Fabio Estevam (2):
      ARM: imx: Remove epit support
      ARM: imx: pm-imx6: Return the error directly

Martin Kaiser (1):
      ARM: imx: avic: set low-power interrupt mask for imx25

Stefan Agner (1):
      ARM: imx: add timer stop flag to ARM power off state

 arch/arm/mach-imx/Kconfig          |  20 ++--
 arch/arm/mach-imx/Makefile         |   2 +-
 arch/arm/mach-imx/anatop.c         |  56 ++++-----
 arch/arm/mach-imx/avic.c           |  37 ++++++
 arch/arm/mach-imx/cpu.c            |   3 +
 arch/arm/mach-imx/cpuidle-imx6sl.c |   7 +-
 arch/arm/mach-imx/cpuidle-imx6sx.c |   1 +
 arch/arm/mach-imx/epit.c           | 228 -------------------------------------
 arch/arm/mach-imx/mach-imx6sl.c    |  10 +-
 arch/arm/mach-imx/mxc.h            |   6 +
 arch/arm/mach-imx/pm-imx6.c        |   7 +-
 11 files changed, 89 insertions(+), 288 deletions(-)
 delete mode 100644 arch/arm/mach-imx/epit.c
