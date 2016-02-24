From: petr@barix.com (Petr Kulhavy)
Date: Wed, 24 Feb 2016 16:41:49 +0100
Subject: [PATCH v2] ARM: DaVinci USB: removed deprecated properties from MUSB
 config
Message-ID: <1456328509-17839-1-git-send-email-petr@barix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following properties of the musb_hdrc_config structure
are deprecated and no longer required/used by the MUSB driver:

.dyn_fifo
.soft_con
.dma
.dma_channels
.eps_bits

Signed-off-by: Petr Kulhavy <petr@barix.com>
---
v1: <initial>

v2:
 - patch recreated for the 4.5-rc2 tree

 arch/arm/mach-davinci/usb.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
index b0a6b52..6ed5a54 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -19,27 +19,11 @@
 #define DA8XX_USB1_BASE 	0x01e25000
 
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
 
 	.num_eps	= 5,
-	.dma_channels	= 8,
 	.ram_bits	= 10,
-	.eps_bits	= musb_eps,
 };
 
 static struct musb_hdrc_platform_data usb_data = {
-- 
1.9.1
