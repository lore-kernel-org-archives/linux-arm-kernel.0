From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 18 Sep 2010 11:42:45 +0900
Subject: [PATCH] ARM: S5PV310: Fix clkset_moutcore_list
Message-ID: <1284777765-23223-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaecheol Lee <jc.lee@samsung.com>

This patch fixes source clocks of moutcore.
That should be clk_mout_apll instead of clk_sclk_apll.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
index 262a46f..32146db 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -155,7 +155,7 @@ static struct clksrc_clk clk_mout_mpll = {
 };
 
 static struct clk *clkset_moutcore_list[] = {
-	[0] = &clk_sclk_apll.clk,
+	[0] = &clk_mout_apll.clk,
 	[1] = &clk_mout_mpll.clk,
 };
 
-- 
1.6.2.5
