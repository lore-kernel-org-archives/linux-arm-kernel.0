From: balbi@ti.com (Felipe Balbi)
Date: Tue, 24 Jul 2012 11:53:58 +0300
Subject: [PATCH 1/5] arm: omap: debug-leds: drop machine_is_* checks
In-Reply-To: <1343120042-16695-1-git-send-email-balbi@ti.com>
References: <1343120042-16695-1-git-send-email-balbi@ti.com>
Message-ID: <1343120042-16695-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

that platform_device is only registered by
board-h4.c, so there's no need to check which
machine is running as the driver won't bind
to anything.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/debug-leds.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
index 39407cb..17cbef6 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -304,12 +304,6 @@ static struct platform_driver led_driver = {
 
 static int __init fpga_init(void)
 {
-	if (machine_is_omap_h4()
-			|| machine_is_omap_h3()
-			|| machine_is_omap_h2()
-			|| machine_is_omap_perseus2()
-			)
-		return platform_driver_register(&led_driver);
-	return 0;
+	return platform_driver_register(&led_driver);
 }
 fs_initcall(fpga_init);
-- 
1.7.11
