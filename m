From: khilman@ti.com (Kevin Hilman)
Date: Thu, 26 Apr 2012 16:29:50 -0700
Subject: [PATCH/RFT 5/8] ARM: OMAP: clock: remove unused CK_3505 flag
In-Reply-To: <1335482993-14035-1-git-send-email-khilman@ti.com>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
Message-ID: <1335482993-14035-6-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag is no longer used since clock init all AM35x devices
is now the same.

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index b299b8d..45afa4d 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -34,7 +34,6 @@ struct omap_clk {
 #define CK_243X		(1 << 5)	/* 243x, 253x */
 #define CK_3430ES1	(1 << 6)	/* 34xxES1 only */
 #define CK_3430ES2PLUS	(1 << 7)	/* 34xxES2, ES3, non-Sitara 35xx only */
-#define CK_3505		(1 << 8)
 #define CK_3517		(1 << 9)
 #define CK_36XX		(1 << 10)	/* 36xx/37xx-specific clocks */
 #define CK_443X		(1 << 11)
@@ -44,7 +43,7 @@ struct omap_clk {
 
 
 #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
-#define CK_AM35XX	(CK_3505 | CK_3517)	/* all Sitara AM35xx */
+#define CK_AM35XX	CK_3517		/* all Sitara AM35xx */
 #define CK_3XXX		(CK_34XX | CK_AM35XX | CK_36XX)
 
 
-- 
1.7.9.2
