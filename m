From: amit.kachhap@linaro.org (Amit Daniel Kachhap)
Date: Fri, 19 Aug 2011 18:39:00 +0530
Subject: [RFC PATCH 0/4] ARM: EXYNOS4: Use cpuidle common save/restore
	framework code
Message-ID: <1313759340-31319-1-git-send-email-amit.kachhap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patch adds support for samsung exynos4 platform cpuidle driver to use
the common cpuidle framework submitted earlier by Lorenzo Pieralisi. Basically
a single interface cpu_enter_idle takes care of saving and restoring single 
cpu or whole cluster information.  The link to the framework patchset is,
http://www.spinics.net/lists/arm-kernel/msg132044.html

Description of patches in this list:
1)Patch (ARM: kernel: Some fixes in save/restore common code) adds some
essential fixes for the common save/restore to work on exynos4 platform.

2)Patch (ARM: EXYNOS4: Fix to work with origen boards) adds a fix for 
extracting chip revision number.

3)Patch (ARM: EXYNOS4: Add support AFTR mode cpuidle state on EXYNOS4210) 
rebases the L2 retention C state cpuidle driver submitted earlier by 
Jaecheol Lee.

4)Patch (Modify cpuidle code to adapt to save/restore common code) uses the
generic infrastructure to enter and exit from the retention idle state. 

All these codes have been tested on Samsung ORIGEN board against the tree
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-next.

Amit Daniel Kachhap (4):
  ARM: kernel: Some fixes in save/restore common code.
  ARM: EXYNOS4: Fix to work with origen boards.
  ARM: EXYNOS4: Add support AFTR mode cpuidle state on EXYNOS4210
  ARM: EXYNOS4: Modify cpuidle code to adapt to save/restore common
    code

 arch/arm/Kconfig                         |    1 +
 arch/arm/common/gic.c                    |    1 -
 arch/arm/kernel/sr_helpers.h             |    2 +-
 arch/arm/mach-exynos4/cpu.c              |   10 ++
 arch/arm/mach-exynos4/cpuidle.c          |  150 +++++++++++++++++++++++++++++-
 arch/arm/mach-exynos4/include/mach/pmu.h |    1 -
 arch/arm/mm/cache-l2x0.c                 |   10 ++-
 arch/arm/plat-s5p/include/plat/exynos4.h |    1 +
 8 files changed, 169 insertions(+), 7 deletions(-)
