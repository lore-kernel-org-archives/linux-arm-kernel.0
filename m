From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 Mar 2011 22:52:23 +0800
Subject: [PATCH] ARM: mx5: fix clk id for a few DEFINE_CLOCK
Message-ID: <1300114343-3736-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 652ace4..b25dba6 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1301,10 +1301,10 @@ DEFINE_CLOCK_FULL(ecspi1_ipg_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG9_OFFSET,
 		&ipg_clk, &spba_clk);
 DEFINE_CLOCK(ecspi1_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG10_OFFSET,
 		NULL, NULL, &ecspi_main_clk, &ecspi1_ipg_clk);
-DEFINE_CLOCK_FULL(ecspi2_ipg_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG11_OFFSET,
+DEFINE_CLOCK_FULL(ecspi2_ipg_clk, 1, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG11_OFFSET,
 		NULL, NULL, _clk_ccgr_enable_inrun, _clk_ccgr_disable,
 		&ipg_clk, &aips_tz2_clk);
-DEFINE_CLOCK(ecspi2_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG12_OFFSET,
+DEFINE_CLOCK(ecspi2_clk, 1, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG12_OFFSET,
 		NULL, NULL, &ecspi_main_clk, &ecspi2_ipg_clk);
 
 /* CSPI */
@@ -1314,7 +1314,7 @@ DEFINE_CLOCK(cspi_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG13_OFFSET,
 		NULL, NULL, &ipg_clk, &cspi_ipg_clk);
 
 /* SDMA */
-DEFINE_CLOCK(sdma_clk, 1, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG15_OFFSET,
+DEFINE_CLOCK(sdma_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG15_OFFSET,
 		NULL, NULL, &ahb_clk, NULL);
 
 /* eSDHC */
-- 
1.7.1
