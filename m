From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed,  7 Aug 2013 18:29:44 +0200
Subject: [PATCH] ARM: at91: add missing uart clocks DT entries
Message-ID: <1375892984-2835-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clocks to clock lookup table for uart DT entries.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/mach-at91/at91sam9x5.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 2abee66..916e5a1 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -227,6 +227,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("usart", "f8020000.serial", &usart1_clk),
 	CLKDEV_CON_DEV_ID("usart", "f8024000.serial", &usart2_clk),
 	CLKDEV_CON_DEV_ID("usart", "f8028000.serial", &usart3_clk),
+	CLKDEV_CON_DEV_ID("usart", "f8040000.serial", &uart0_clk),
+	CLKDEV_CON_DEV_ID("usart", "f8044000.serial", &uart1_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "f8008000.timer", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "f800c000.timer", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("mci_clk", "f0008000.mmc", &mmc0_clk),
-- 
1.7.9.5
