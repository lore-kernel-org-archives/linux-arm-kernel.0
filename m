From: xerofoify@gmail.com (Nicholas Krause)
Date: Fri,  4 Jul 2014 17:04:03 -0400
Subject: [PATCH] mach-omap2: Change if statement in omap2_dflt_clk_enable
Message-ID: <1404507843-3648-1-git-send-email-xerofoify@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes this function to check for if v is returning value from the
called function. If not it does the else. Furthermore fixes the FIXME message above
if statement for holding INVERT_ENABLE bit when not needing to be checked for
in if statement by just checking for if v is not Null.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/arm/mach-omap2/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 591581a..626363d 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -379,7 +379,7 @@ void omap2_dflt_clk_disable(struct clk_hw *hw)
 	}
 
 	v = omap2_clk_readl(clk, clk->enable_reg);
-	if (clk->flags & INVERT_ENABLE)
+	if (v)
 		v |= (1 << clk->enable_bit);
 	else
 		v &= ~(1 << clk->enable_bit);
-- 
1.9.1
