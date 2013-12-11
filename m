From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed, 11 Dec 2013 17:27:04 +0530
Subject: [PATCH 0/5] Power Related Fixes for Exynos5250
Message-ID: <1386763029-8516-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 1 prevents the gating of sysreg clock on Exynos5250.
Patch 2 is a re-send of an earlier patch.
(http://www.spinics.net/lists/linux-samsung-soc/msg15485.html)
Patches 3 and 4 are fixes for MAX77686 on Exynos5250 based Snow
board (boot-up issues).
Patch 5 implements a power-off call-back for Exynos5250 that can
be re-used for Exynos5420.

The patches have been tested on an SMDK5250 based Chromebook.

Abhilash Kesavan (4):
  clk: samsung: exynos5250: Add CLK_IGNORE_UNUSED flag for the sysreg
    clock
  ARM: EXYNOS5: Fix PMU register configuration for local power blocks
  clk: max77686: Replace is_enabled() with is_prepared call-back
  ARM: dts: Setup the interrupt parent for max77686

Olof Johansson (1):
  ARM: EXYNOS5250: Implement pm_power_off

 arch/arm/boot/dts/cros5250-common.dtsi       |   11 ++++
 arch/arm/mach-exynos/include/mach/regs-pmu.h |    3 +
 arch/arm/mach-exynos/pmu.c                   |   86 ++++++++++++++++++++------
 drivers/clk/clk-max77686.c                   |    4 +-
 drivers/clk/samsung/clk-exynos5250.c         |    3 +-
 5 files changed, 86 insertions(+), 21 deletions(-)

-- 
1.7.9.5
