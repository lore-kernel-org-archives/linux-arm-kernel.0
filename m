From: tony@atomide.com (Tony Lindgren)
Date: Thu, 27 Feb 2014 16:07:15 -0800
Subject: [GIT PULL] omap fixes for v3.14-rc4
Message-ID: <20140228000715.GA14514@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8842446ac74263f1330f46e11ed649e2b0ed6545:

  Documentation: dt: OMAP: Update Overo/Tobi (2014-02-14 08:37:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/fixes-rc4

for you to fetch changes up to 4b41636878ee32d4c45a49de7749abca9721bd6a:

  ARM: OMAP3: Fix pinctrl interrupts for core2 (2014-02-27 15:35:48 -0800)

----------------------------------------------------------------
Fixes for omaps mostly to fix the 3430 display regression,
and random crashes if booting n900 with device tree and
thumb mode. Also few other regressions and fixes.

----------------------------------------------------------------
Illia Smyrnov (1):
      ARM: OMAP4: hwmod: Fix SOFTRESET logic for OMAP4

Santosh Shilimkar (1):
      ARM: OMAP: Kill warning in CPUIDLE code with !CONFIG_SMP

Sebastian Reichel (1):
      ARM: OMAP2+: Add support for thumb mode on DT booted N900

Suman Anna (1):
      ARM: DRA7: hwmod data: correct the sysc data for spinlock

Tomi Valkeinen (1):
      ARM: OMAP2+: clock: fix clkoutx2 with CLK_SET_RATE_PARENT

Tony Lindgren (2):
      Merge tag 'for-v3.14-rc/omap-fixes-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.14/fixes
      ARM: OMAP3: Fix pinctrl interrupts for core2

Vaibhav Bedia (1):
      ARM: OMAP5: PRM: Fix reboot handling

 arch/arm/mach-omap2/cclock3xxx_data.c     |  2 +
 arch/arm/mach-omap2/cpuidle44xx.c         |  8 ++-
 arch/arm/mach-omap2/dpll3xxx.c            | 92 ++++++++++++++++++++++++++-----
 arch/arm/mach-omap2/omap_hwmod.c          | 20 ++++---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  9 ++-
 arch/arm/mach-omap2/pdata-quirks.c        | 21 ++++++-
 arch/arm/mach-omap2/prminst44xx.c         |  4 +-
 include/linux/clk/ti.h                    |  4 ++
 8 files changed, 125 insertions(+), 35 deletions(-)
