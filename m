From: hsnaves@gmail.com (Humberto Silva Naves)
Date: Thu, 31 Jul 2014 13:22:07 +0200
Subject: [PATCHv2 0/5] clk: samsung: exynos5410: Implementation of the PLL
 clocks
Message-ID: <1406805732-17372-1-git-send-email-hsnaves@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series slightly improves the exynos5410 clock driver. Below is
a list of changes introduced by the patch:
 - Basic validation in the clock initialization routine
 - Added resume/suspend handler
 - Implemented some fixed rate clocks and changed the way "fin_pll" is defined
 - Added the remaining PLL clocks

Changelog since v1:
 * Split the reordering and addition of new constants  into two different
commits, as suggested by Thomas Abraham. For details, see:
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34950.html
 * The rate tables are only installed if the clock rate of the parent matches
a specific frequency of 24MHz. For details, please refer to:
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34953.html
 * Added some fixed rate clocks.

Humberto Silva Naves (5):
  clk: samsung: exynos5410: Add NULL pointer checks in clock init
  clk: samsung: exynos5410: Organize register offset constants
  clk: samsung: exynos5410: Add suspend/resume handling
  clk: samsung: exynos5410: Add fixed rate clocks
  clk: samsung: exynos5410: Added clocks DPLL, EPLL, IPLL, and VPLL

 .../devicetree/bindings/clock/exynos5410-clock.txt |   17 +-
 drivers/clk/samsung/clk-exynos5410.c               |  437 ++++++++++++++++++--
 include/dt-bindings/clock/exynos5410.h             |    5 +
 3 files changed, 430 insertions(+), 29 deletions(-)

-- 
1.7.10.4
