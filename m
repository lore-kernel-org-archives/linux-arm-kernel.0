From: nm@ti.com (Nishanth Menon)
Date: Thu, 17 Apr 2014 15:49:22 -0500
Subject: [PATCH V2 06/19] bus: omap_l3_noc: un-obfuscate l3_targ address
 computation
In-Reply-To: <1397767775-10965-1-git-send-email-nm@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com>
Message-ID: <1397767775-10965-7-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

just simplify derefencing that is equivalent.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
V2: just ordering change
V1: https://patchwork.kernel.org/patch/3984201/
 drivers/bus/omap_l3_noc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index c8facb0..f7d3bf4 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -76,7 +76,7 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 			err_src = __ffs(err_reg);
 
 			/* Read the stderrlog_main_source from clk domain */
-			l3_targ_base = base + *(l3_targ[i] + err_src);
+			l3_targ_base = base + l3_targ[i][err_src];
 			l3_targ_stderr = l3_targ_base + L3_TARG_STDERRLOG_MAIN;
 			l3_targ_slvofslsb = l3_targ_base +
 					    L3_TARG_STDERRLOG_SLVOFSLSB;
-- 
1.7.9.5
