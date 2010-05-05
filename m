From: Dinh.Nguyen@freescale.com (Dinh Nguyen)
Date: Wed,  5 May 2010 17:56:10 -0500
Subject: [PATCHv1 2.6.34-rc6 2/3] mx5: change usb clock source from pll3 to
	pll2
In-Reply-To: <1273100171-3235-2-git-send-email-Dinh.Nguyen@freescale.com>
References: <1273100171-3235-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1273100171-3235-2-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <1273100171-3235-3-git-send-email-Dinh.Nguyen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For power management reasons, pll2 should be used to source the USBOH3
clock for mx51. PLL3 can be completely gated off when USB is not used.

Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index dcca330..933c0d1 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -763,7 +763,7 @@ DEFINE_CLOCK(gpt_ipg_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG10_OFFSET,
 
 /* USB */
 DEFINE_CLOCK(usboh3_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG14_OFFSET,
-	NULL, NULL, &pll3_sw_clk, NULL);
+	NULL, NULL, &pll2_sw_clk, NULL);
 
 /* FEC */
 DEFINE_CLOCK(fec_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG12_OFFSET,
-- 
1.6.0.4
