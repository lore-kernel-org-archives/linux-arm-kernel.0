From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:32 +0900
Subject: [PATCH 096/142] ARM: shmobile: kzm9g: Register pinctrl mappings for
 USB
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-97-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the GPIO-based USB pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 7427041..c1c0401 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -654,6 +654,9 @@ static const struct pinctrl_map kzm_pinctrl_map[] = {
 	/* SMSC */
 	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x.0", "pfc-sh73a0",
 				  "bsc_cs4", "bsc"),
+	/* USB */
+	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-sh73a0",
+				  "usb_vbus", "usb"),
 };
 
 /*
@@ -738,9 +741,6 @@ static void __init kzm_init(void)
 	/* enable Micro SD */
 	gpio_request_one(14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
-	/* enable USB */
-	gpio_request(GPIO_FN_VBUS_0,	NULL);
-
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
 	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
-- 
1.7.10.4
