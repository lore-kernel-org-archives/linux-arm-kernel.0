From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Wed, 8 Dec 2010 17:18:46 +0530
Subject: [PATCH] ux500: fix 5500 PER6 clock rate
Message-ID: <1291808926-19863-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DB5500 PER6 clock rate is the same as the DB8500 one, i.e. 133.33 MHz.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/clock.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index 3576e66..f5ae68c 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -583,7 +583,6 @@ int __init clk_init(void)
 		/* Clock tree for U5500 not implemented yet */
 		clk_prcc_ops.enable = clk_prcc_ops.disable = NULL;
 		clk_prcmu_ops.enable = clk_prcmu_ops.disable = NULL;
-		clk_per6clk.rate = 26000000;
 		clk_uartclk.rate = 36360000;
 		clk_sdmmcclk.rate = 99900000;
 	}
-- 
1.7.2.dirty
