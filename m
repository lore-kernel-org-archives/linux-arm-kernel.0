From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 1 Sep 2011 19:21:27 +0200
Subject: [PATCH 11/13] OMAP4: board-dt: Remove static i2c init
In-Reply-To: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314897689-17791-12-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the minimal DT support is there to initialize
properly the twl6030, remove the static init from
the board file.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap4-dt.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4-dt.c b/arch/arm/mach-omap2/board-omap4-dt.c
index 5688cd5..cefe0a6 100644
--- a/arch/arm/mach-omap2/board-omap4-dt.c
+++ b/arch/arm/mach-omap2/board-omap4-dt.c
@@ -51,20 +51,6 @@ static struct of_device_id omap_dt_gic_match[] __initdata = {
 	{}
 };
 
-/*
- * XXX: Still needed to boot until the i2c & twl driver is adapted to
- * device-tree
- */
-static struct twl4030_platform_data sdp4430_twldata = {
-	.irq_base	= TWL6030_IRQ_BASE,
-	.irq_end	= TWL6030_IRQ_END,
-};
-
-static void __init omap4_i2c_init(void)
-{
-	omap4_pmic_init("twl6030", &sdp4430_twldata);
-}
-
 static void __init omap4_init_machine(void)
 {
 	int package = OMAP_PACKAGE_CBS;
@@ -78,7 +64,6 @@ static void __init omap4_init_machine(void)
 		package = OMAP_PACKAGE_CBL;
 	omap4_mux_init(NULL, NULL, package);
 
-	omap4_i2c_init();
 	/*
 	 * XXX: Still needed to boot until the omap-serial driver is adapted
 	 * to device-tree
-- 
1.7.0.4
