From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 28 Mar 2011 18:01:29 +0200
Subject: [PATCH 3/4] arm: lpc32xx: fix size of watchdog resource
In-Reply-To: <1301328090-25994-1-git-send-email-w.sang@pengutronix.de>
References: <1301328090-25994-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1301328090-25994-3-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And remove an unneeded index in the array-initialization.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-lpc32xx/common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index 83daba6..9edcd19 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -36,9 +36,9 @@
  * Watchdog timer
  */
 static struct resource watchdog_resources[] = {
-	[0] = {
+	{
 		.start = LPC32XX_WDTIM_BASE,
-		.end = LPC32XX_WDTIM_BASE + SZ_4K - 1,
+		.end = LPC32XX_WDTIM_BASE + SZ_16K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 };
-- 
1.7.2.5
