From: hsnaves@gmail.com (Humberto Silva Naves)
Date: Mon,  4 Aug 2014 16:02:46 +0200
Subject: [PATCH 0/2] PLL registration clean-up
Message-ID: <1407160968-12108-1-git-send-email-hsnaves@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series changes the way PLL clocks are registered, mainly to
add validation of rate tables. What follows is a list of changes
introduced by the patch:
 - Validation of PLL rate tables
 - Added support for heterogenous rate tables.
 - Removed explicit dependency on the input clock source at
   the driver initialization
 - Keeping tables sorted is no longer needed
 - PLL initialization data is now marked as __initconst

For more details, please refer to:
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg35072.html


Humberto Silva Naves (2):
  clk: samsung: Add validation of rate tables for the PLL clocks
  clk: samsung: Make pll initialization structures read-only.

 drivers/clk/samsung/clk-exynos3250.c | 105 +++++-----
 drivers/clk/samsung/clk-exynos4.c    | 146 ++++++-------
 drivers/clk/samsung/clk-exynos5250.c |  78 +++----
 drivers/clk/samsung/clk-exynos5260.c | 104 +++++-----
 drivers/clk/samsung/clk-exynos5410.c |   2 +-
 drivers/clk/samsung/clk-exynos5420.c |  52 +++--
 drivers/clk/samsung/clk-pll.c        | 387 ++++++++++++++++++++++++++---------
 drivers/clk/samsung/clk-pll.h        |  30 +--
 drivers/clk/samsung/clk-s3c2410.c    | 142 ++++++-------
 drivers/clk/samsung/clk-s3c2412.c    |   2 +-
 drivers/clk/samsung/clk-s3c2443.c    |   4 +-
 drivers/clk/samsung/clk-s3c64xx.c    |   2 +-
 12 files changed, 600 insertions(+), 454 deletions(-)

-- 
2.0.1
