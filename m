From: stigge@antcom.de (Roland Stigge)
Date: Wed,  8 Feb 2012 21:41:04 +0100
Subject: [PATCH v4 6/7] ARM: LPC32xx: clock.c: warning fix
In-Reply-To: <1328733665-17836-1-git-send-email-stigge@antcom.de>
References: <1328733665-17836-1-git-send-email-stigge@antcom.de>
Message-ID: <1328733665-17836-7-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the debug warning on local_clk_disable() as done in Kevin
Wells' driver update

Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
Tested-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Kevin Wells <kevin.wells@nxp.com>

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index d527288..0606a63 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -904,8 +904,6 @@ static inline void clk_unlock(void)
 
 static void local_clk_disable(struct clk *clk)
 {
-	WARN_ON(clk->usecount == 0);
-
 	/* Don't attempt to disable clock if it has no users */
 	if (clk->usecount > 0) {
 		clk->usecount--;
