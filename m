From: balbi@ti.com (Felipe Balbi)
Date: Tue, 24 Jul 2012 11:53:59 +0300
Subject: [PATCH 2/5] arm: omap: debug-leds: move initialization to debug-leds
In-Reply-To: <1343120042-16695-1-git-send-email-balbi@ti.com>
References: <1343120042-16695-1-git-send-email-balbi@ti.com>
Message-ID: <1343120042-16695-3-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

there's no problem in registering debug-leds on
module_init() as that's not critical to board
boot up.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/debug-leds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
index 17cbef6..615d085 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -306,4 +306,4 @@ static int __init fpga_init(void)
 {
 	return platform_driver_register(&led_driver);
 }
-fs_initcall(fpga_init);
+module_init(fpga_init);
-- 
1.7.11
