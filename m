From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 16 Sep 2011 12:46:58 -0500
Subject: [PATCH v2 0/6] OMAP3+ Clock Fixes
Message-ID: <1316195218-14875-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Hunter <jon-hunter@ti.com>

Various clock fixes for OMAP3 and OMAP4 devices.

Jon Hunter (4):
  OMAP4: Add missing clock divider for OCP_ABE_ICLK
  OMAP3+: use DPLLs recalc function instead of omap2_get_dpll_rate
  OMAP3+: Update DPLL Fint range for OMAP36xx and OMAP4xxx devices
  OMAP4: Clock: Correct the name of SLIMBUS interface clocks

Mike Turquette (2):
  OMAP4: Clock: round_rate and recalc functions for DPLL_ABE
  OMAP3+: use DPLL's round_rate when setting rate

 arch/arm/mach-omap2/clkt_dpll.c      |   51 +++++++++++++++++++++++----------
 arch/arm/mach-omap2/clock.h          |    2 +
 arch/arm/mach-omap2/clock44xx.h      |    2 +
 arch/arm/mach-omap2/clock44xx_data.c |   32 +++++++++++++++------
 arch/arm/mach-omap2/dpll3xxx.c       |    6 ++--
 arch/arm/mach-omap2/dpll44xx.c       |   45 ++++++++++++++++++++++++++++++
 6 files changed, 110 insertions(+), 28 deletions(-)

-- 
1.7.4.1
