From: stigge@antcom.de (Roland Stigge)
Date: Mon, 30 Jan 2012 17:02:04 +0100
Subject: [PATCH v2 5/7] LPC32xx: clock.c: warning fix
In-Reply-To: <1327939327-7799-1-git-send-email-stigge@antcom.de>
References: <1327939327-7799-1-git-send-email-stigge@antcom.de>
Message-ID: <1327939327-7799-5-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the debug warning on local_clk_disable() as done in Kevin
Wells' driver update

Signed-off-by: Roland Stigge <stigge@antcom.de>

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 229bec5..01e9aba 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -903,8 +903,6 @@ static inline void clk_unlock(void)
 
 static void local_clk_disable(struct clk *clk)
 {
-	WARN_ON(clk->usecount == 0);
-
 	/* Don't attempt to disable clock if it has no users */
 	if (clk->usecount > 0) {
 		clk->usecount--;
