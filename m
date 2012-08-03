From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 3 Aug 2012 22:23:04 +0800
Subject: [PATCH 1/2] ARM: imx: enable emi_slow_gate clock for imx5
In-Reply-To: <20120803141108.GV1451@pengutronix.de>
References: <1343919712-6240-1-git-send-email-shawn.guo@linaro.org>
 <20120803141108.GV1451@pengutronix.de>
Message-ID: <20120803142302.GD23791@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 03, 2012 at 04:11:08PM +0200, Sascha Hauer wrote:
> Can we add a comment that emi_slow_gate is needed for the EIM interface?
> It's not obvious from the datasheet and this information might help
> people who want to clean up the now unconditionally enabled clocks.
> 
Ok, will amend the following change.

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 6eee32a..4bdcaa9 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -303,7 +303,7 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
        clk_prepare_enable(clk[aips_tz2]); /* fec */
        clk_prepare_enable(clk[spba]);
        clk_prepare_enable(clk[emi_fast_gate]); /* fec */
-       clk_prepare_enable(clk[emi_slow_gate]);
+       clk_prepare_enable(clk[emi_slow_gate]); /* eim */
        clk_prepare_enable(clk[tmax1]);
        clk_prepare_enable(clk[tmax2]); /* esdhc2, fec */
        clk_prepare_enable(clk[tmax3]); /* esdhc1, esdhc4 */

> Otherwise:
> 
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
Thanks.

-- 
Regards,
Shawn
