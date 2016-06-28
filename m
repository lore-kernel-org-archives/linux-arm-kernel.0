From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 28 Jun 2016 20:46:16 +0800
Subject: [GIT PULL 1/5] i.MX cleanup for 4.8
Message-ID: <1467117980-20063-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-cleanup-4.8

for you to fetch changes up to 44af782227b3977b98be6967533b0d23add40eb4:

  ARM: imx: remove cpu_is_mx*() (2016-06-28 10:26:45 +0800)

----------------------------------------------------------------
The i.MX cleanup for 4.8:
 - A series from Arnd to clean up cpu_is_mx*() from i.MX platform
 - A series from Andrey to clean up i.MX L2-cache code by using
   core support as much as possible
 - Remove the orphan header eukrea-baseboards.h from i.MX platform
 - Remove boilerplate code from TZIC driver by using IRQCHIP_DECLARE

----------------------------------------------------------------
Alexander Shiyan (2):
      ARM: imx: Remove orphan header
      ARM: imx: Use IRQCHIP_DECLARE for TZIC

Andrey Smirnov (5):
      ARM: i.MX: system.c: Convert goto to if statement
      ARM: i.MX: system.c: Remove redundant errata 752271 code
      ARM: i.MX: system.c: Replace magic numbers
      ARM: i.MX: system.c: Tweak prefetch settings for performance
      ARM: i.MX: Do not explicitly call l2x0_of_init()

Arnd Bergmann (6):
      ARM: imx: remove cpu_is_mx1 check
      ARM: imx: deconstruct mxc_rnga initialization
      ARM: imx: deconstruct mx3_idle
      ARM: imx: rework mx27_pm_init() call
      ARM: imx: remove last call to cpu_is_mx5*
      ARM: imx: remove cpu_is_mx*()

 arch/arm/mach-imx/Kconfig                     |   4 -
 arch/arm/mach-imx/Makefile                    |   4 +-
 arch/arm/mach-imx/common.h                    |   3 +-
 arch/arm/mach-imx/cpu-imx5.c                  |   8 --
 arch/arm/mach-imx/cpu.c                       |   2 -
 arch/arm/mach-imx/devices/Kconfig             |   4 -
 arch/arm/mach-imx/devices/platform-mxc_rnga.c |  53 --------------
 arch/arm/mach-imx/eukrea-baseboards.h         |  42 -----------
 arch/arm/mach-imx/imx27-dt.c                  |   1 +
 arch/arm/mach-imx/imx31-dt.c                  |  12 +++
 arch/arm/mach-imx/imx35-dt.c                  |  10 +--
 arch/arm/mach-imx/mach-imx50.c                |   1 -
 arch/arm/mach-imx/mach-imx51.c                |   1 -
 arch/arm/mach-imx/mach-imx53.c                |   1 -
 arch/arm/mach-imx/mach-imx6q.c                |   2 +
 arch/arm/mach-imx/mach-imx6sl.c               |   2 +
 arch/arm/mach-imx/mach-imx6sx.c               |   2 +
 arch/arm/mach-imx/mm-imx1.c                   |   2 +-
 arch/arm/mach-imx/mm-imx27.c                  |   2 +
 arch/arm/mach-imx/mm-imx3.c                   |  32 +++++++-
 arch/arm/mach-imx/mxc.h                       | 101 --------------------------
 arch/arm/mach-imx/pm-imx27.c                  |   8 +-
 arch/arm/mach-imx/pm-imx3.c                   |  38 ----------
 arch/arm/mach-imx/system.c                    |  58 +++++++--------
 arch/arm/mach-imx/tzic.c                      |  10 +--
 25 files changed, 88 insertions(+), 315 deletions(-)
 delete mode 100644 arch/arm/mach-imx/devices/platform-mxc_rnga.c
 delete mode 100644 arch/arm/mach-imx/eukrea-baseboards.h
 delete mode 100644 arch/arm/mach-imx/pm-imx3.c
