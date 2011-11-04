From: b.van.den.berg.nl@gmail.com (Bas van den Berg)
Date: Fri, 4 Nov 2011 12:00:07 +0100
Subject: [PATCH] ARM: mach-davinci: fixed name and parent of pll1 sysclock6
Message-ID: <20111104110004.GA15331@altenpts-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The name and parent of pll1_sysclk6 should be pll1 and not pll0.
Checked and tested in debugfs on OmapL138.

Signed-off-by: Bas van den Berg <b.van.den.berg.nl@gmail.com>
---
 arch/arm/mach-davinci/da850.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index b047f87..0962275 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -168,8 +168,8 @@ static struct clk pll1_sysclk5 = {
 };
 
 static struct clk pll1_sysclk6 = {
-	.name		= "pll0_sysclk6",
-	.parent		= &pll0_clk,
+	.name		= "pll1_sysclk6",
+	.parent		= &pll1_clk,
 	.flags		= CLK_PLL,
 	.div_reg	= PLLDIV6,
 };
-- 
1.7.0.4
