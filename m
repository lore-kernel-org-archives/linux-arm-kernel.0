From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 28 Nov 2011 12:53:08 +0100
Subject: [PATCH 1/1] ARM: at91: fix clock conid for atmel_tcb.1 on 9260/9g20
Message-ID: <1322481188-8839-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the conid is supposed to be t0/t1/t2_clk

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: stable at kernel.org
---
Hi,

	could you apply this is present since 3.0

Best Regards,
J.
 arch/arm/mach-at91/at91sam9260.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 2e59126..8c75932 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -196,9 +196,9 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tc0_clk),
 	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.0", &tc1_clk),
 	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.0", &tc2_clk),
-	CLKDEV_CON_DEV_ID("t3_clk", "atmel_tcb.1", &tc3_clk),
-	CLKDEV_CON_DEV_ID("t4_clk", "atmel_tcb.1", &tc4_clk),
-	CLKDEV_CON_DEV_ID("t5_clk", "atmel_tcb.1", &tc5_clk),
+	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.1", &tc3_clk),
+	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.1", &tc4_clk),
+	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.1", &tc5_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc_clk),
 	/* more usart lookup table for DT entries */
 	CLKDEV_CON_DEV_ID("usart", "fffff200.serial", &mck),
-- 
1.7.7
