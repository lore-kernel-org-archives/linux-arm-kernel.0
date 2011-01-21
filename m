From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 21 Jan 2011 11:57:54 +0100
Subject: [PATCH 3/3] ARM i.MX23/28: remove secondary field from struct clk.
	It's unused
In-Reply-To: <1295607474-6559-1-git-send-email-s.hauer@pengutronix.de>
References: <1295607474-6559-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1295607474-6559-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mxs/clock.c              |    2 --
 arch/arm/mach-mxs/include/mach/clock.h |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mxs/clock.c b/arch/arm/mach-mxs/clock.c
index e7d2269..a7093c8 100644
--- a/arch/arm/mach-mxs/clock.c
+++ b/arch/arm/mach-mxs/clock.c
@@ -57,7 +57,6 @@ static void __clk_disable(struct clk *clk)
 		if (clk->disable)
 			clk->disable(clk);
 		__clk_disable(clk->parent);
-		__clk_disable(clk->secondary);
 	}
 }
 
@@ -68,7 +67,6 @@ static int __clk_enable(struct clk *clk)
 
 	if (clk->usecount++ == 0) {
 		__clk_enable(clk->parent);
-		__clk_enable(clk->secondary);
 
 		if (clk->enable)
 			clk->enable(clk);
diff --git a/arch/arm/mach-mxs/include/mach/clock.h b/arch/arm/mach-mxs/include/mach/clock.h
index 041e276..592c9ab 100644
--- a/arch/arm/mach-mxs/include/mach/clock.h
+++ b/arch/arm/mach-mxs/include/mach/clock.h
@@ -29,8 +29,6 @@ struct clk {
 	int id;
 	/* Source clock this clk depends on */
 	struct clk *parent;
-	/* Secondary clock to enable/disable with this clock */
-	struct clk *secondary;
 	/* Reference count of clock enable/disable */
 	__s8 usecount;
 	/* Register bit position for clock's enable/disable control. */
-- 
1.7.2.3
