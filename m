From: gsi@denx.de (Gerhard Sittig)
Date: Tue,  6 Aug 2013 22:43:59 +0200
Subject: [PATCH v4 19/31] clk: mpc512x: don't pre-enable FEC and I2C clocks
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
Message-ID: <1375821851-31609-20-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

after the device tree nodes provide clock specs for client side lookups,
peripheral drivers can attach to their clocks and the clock driver need
no longer pre-enable those clock items

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/clock-commonclk.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index 09721d5..3f559fe 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -685,9 +685,7 @@ static void mpc512x_clk_setup_clock_tree(int busfreq)
 	clk_prepare_enable(clks[MPC512x_CLK_PSC_FIFO]);
 	/* some are not yet acquired by their respective drivers */
 	clk_prepare_enable(clks[MPC512x_CLK_PSC3_MCLK]);/* serial console */
-	clk_prepare_enable(clks[MPC512x_CLK_FEC]);	/* network, NFS */
 	clk_prepare_enable(clks[MPC512x_CLK_DIU]);	/* display */
-	clk_prepare_enable(clks[MPC512x_CLK_I2C]);
 	for (mclk_idx = 0; mclk_idx < ARRAY_SIZE(mclk_psc_data); mclk_idx++)
 		clk_prepare_enable(clks[MPC512x_CLK_PSC0 + mclk_idx]);
 	clk_prepare_enable(clks[MPC512x_CLK_BDLC]);
-- 
1.7.10.4
