From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Wed, 17 Mar 2010 10:11:55 +0300
Subject: [PATCH 1/2] [ARM] [IMX]: Removed superfluous checks for argument
	validity.
Message-ID: <1268809916-6525-1-git-send-email-vzapolskiy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The checks for clk argument are doubled in __clk_disable() and
__clk_enable() functions and thus may be skipped in clk_disable() and
clk_enable() bodies.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/clock.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
index 323ff8c..2daec3c 100644
--- a/arch/arm/plat-mxc/clock.c
+++ b/arch/arm/plat-mxc/clock.c
@@ -82,9 +82,6 @@ int clk_enable(struct clk *clk)
 {
 	int ret = 0;
 
-	if (clk == NULL || IS_ERR(clk))
-		return -EINVAL;
-
 	mutex_lock(&clocks_mutex);
 	ret = __clk_enable(clk);
 	mutex_unlock(&clocks_mutex);
@@ -99,9 +96,6 @@ EXPORT_SYMBOL(clk_enable);
  */
 void clk_disable(struct clk *clk)
 {
-	if (clk == NULL || IS_ERR(clk))
-		return;
-
 	mutex_lock(&clocks_mutex);
 	__clk_disable(clk);
 	mutex_unlock(&clocks_mutex);
-- 
1.6.6.1
