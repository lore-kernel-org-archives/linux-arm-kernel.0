From: david@lechnology.com (David Lechner)
Date: Wed, 13 Apr 2016 17:19:12 -0500
Subject: [PATCH] ARM: davinci: da8xx-usb: remove deprecated properties from
 MUSB config
Message-ID: <1460585952-31301-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the same as commit c1b3b058469e ("ARM: DaVinci USB: removed
deprecated properties from MUSB config") applied to usb-da8xx.c.

The following properties of the musb_hdrc_config structure
are deprecated and no longer required/used by the MUSB driver:

.dyn_fifo
.soft_con
.dma
.dma_channels
.eps_bits

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/usb-da8xx.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index 0cab01f..a786c7b 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -17,27 +17,10 @@
 
 #if IS_ENABLED(CONFIG_USB_MUSB_HDRC)
 
-static struct musb_hdrc_eps_bits musb_eps[] = {
-	{ "ep1_tx", 8, },
-	{ "ep1_rx", 8, },
-	{ "ep2_tx", 8, },
-	{ "ep2_rx", 8, },
-	{ "ep3_tx", 5, },
-	{ "ep3_rx", 5, },
-	{ "ep4_tx", 5, },
-	{ "ep4_rx", 5, },
-};
-
 static struct musb_hdrc_config musb_config = {
 	.multipoint	= true,
-	.dyn_fifo	= true,
-	.soft_con	= true,
-	.dma		= true,
-
 	.num_eps	= 5,
-	.dma_channels	= 8,
 	.ram_bits	= 10,
-	.eps_bits	= musb_eps,
 };
 
 static struct musb_hdrc_platform_data usb_data = {
-- 
1.9.1
