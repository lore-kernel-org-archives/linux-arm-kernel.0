From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sat,  8 Feb 2014 15:48:55 +0200
Subject: [PATCH] ARM: OMAP1: nokia770: enable tahvo-usb
Message-ID: <1391867335-9192-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add platform data for tahvo-usb. This is the last missing piece to get
Tahvo USB working with 3.14.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-nokia770.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 91449c5cb70f..85089d821982 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -156,6 +156,7 @@ static struct omap_usb_config nokia770_usb_config __initdata = {
 	.register_dev	= 1,
 	.hmc_mode	= 16,
 	.pins[0]	= 6,
+	.extcon		= "tahvo-usb",
 };
 
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
-- 
1.8.5.3
