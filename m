From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 21 Jun 2010 01:17:09 +0200
Subject: [PATCH] ux500: use neutral PRCMU base
Message-ID: <1277075829-1051-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MTU wallclock timing fix-up patch was hardwired to the DB8500
causing a regression. This makes it work on the DB5500 as well.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index fe84b90..0a1318f 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -131,7 +131,7 @@ EXPORT_SYMBOL(clk_disable);
  */
 static unsigned long clk_mtu_get_rate(struct clk *clk)
 {
-	void __iomem *addr = __io_address(U8500_PRCMU_BASE)
+	void __iomem *addr = __io_address(UX500_PRCMU_BASE)
 		+ PRCM_TCR;
 	u32 tcr = readl(addr);
 	int mtu = (int) clk->data;
-- 
1.6.3.3
