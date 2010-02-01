From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  1 Feb 2010 17:01:30 +0100
Subject: [PATCH 3/8] imx: BUG in clk_disable if the clock isn't enabled
In-Reply-To: <20100201155625.GA22413@pengutronix.de>
References: <20100201155625.GA22413@pengutronix.de>
Message-ID: <1265040095-31656-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/plat-mxc/clock.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
index 9e8fbd5..de99681 100644
--- a/arch/arm/plat-mxc/clock.c
+++ b/arch/arm/plat-mxc/clock.c
@@ -56,6 +56,7 @@ static void __clk_disable(struct clk *clk)
 	__clk_disable(clk->parent);
 	__clk_disable(clk->secondary);
 
+	BUG_ON(!clk->usecount);
 	if (!(--clk->usecount) && clk->disable)
 		clk->disable(clk);
 }
-- 
1.6.6
