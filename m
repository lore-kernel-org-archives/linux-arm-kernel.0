From: balbi@ti.com (Felipe Balbi)
Date: Mon, 17 Jan 2011 06:31:15 +0200
Subject: [PATCH 2/7] arm: omap1: fix compile warning
In-Reply-To: <1295238680-26738-1-git-send-email-balbi@ti.com>
References: <1295238680-26738-1-git-send-email-balbi@ti.com>
Message-ID: <1295238680-26738-3-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following compile warning:
arch/arm/mach-omap1/board-palmte.c:233:13: warning:
'palmte_headphones_detect' defined but not used

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/board-palmte.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index fb51ce6..c9d38f4 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -230,19 +230,6 @@ static struct spi_board_info palmte_spi_info[] __initdata = {
 	},
 };
 
-static void palmte_headphones_detect(void *data, int state)
-{
-	if (state) {
-		/* Headphones connected, disable speaker */
-		gpio_set_value(PALMTE_SPEAKER_GPIO, 0);
-		printk(KERN_INFO "PM: speaker off\n");
-	} else {
-		/* Headphones unplugged, re-enable speaker */
-		gpio_set_value(PALMTE_SPEAKER_GPIO, 1);
-		printk(KERN_INFO "PM: speaker on\n");
-	}
-}
-
 static void __init palmte_misc_gpio_setup(void)
 {
 	/* Set TSC2102 PINTDAV pin as input (used by TSC2102 driver) */
-- 
1.7.3.4.598.g85356
