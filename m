From: chao.xie@marvell.com (Chao Xie)
Date: Wed,  6 Feb 2013 02:23:45 -0500
Subject: [V6 PATCH 10/16] arm: mmp: remove usb devices from pxa168
In-Reply-To: <1360135431-27280-1-git-send-email-chao.xie@marvell.com>
References: <1360135431-27280-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1360135431-27280-11-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mach-mmp/pxa168.c |   42 ------------------------------------------
 1 files changed, 0 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index b7f074f..dd3a68b 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -28,7 +28,6 @@
 #include <mach/mfp.h>
 #include <linux/dma-mapping.h>
 #include <mach/pxa168.h>
-#include <mach/regs-usb.h>
 
 #include "common.h"
 #include "clock.h"
@@ -135,47 +134,6 @@ struct platform_device pxa168_device_gpio = {
 	.resource	= pxa168_resource_gpio,
 };
 
-struct resource pxa168_usb_host_resources[] = {
-	/* USB Host conroller register base */
-	[0] = {
-		.start	= PXA168_U2H_REGBASE + U2x_CAPREGS_OFFSET,
-		.end	= PXA168_U2H_REGBASE + USB_REG_RANGE,
-		.flags	= IORESOURCE_MEM,
-		.name	= "capregs",
-	},
-	/* USB PHY register base */
-	[1] = {
-		.start	= PXA168_U2H_PHYBASE,
-		.end	= PXA168_U2H_PHYBASE + USB_PHY_RANGE,
-		.flags	= IORESOURCE_MEM,
-		.name	= "phyregs",
-	},
-	[2] = {
-		.start	= IRQ_PXA168_USB2,
-		.end	= IRQ_PXA168_USB2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 pxa168_usb_host_dmamask = DMA_BIT_MASK(32);
-struct platform_device pxa168_device_usb_host = {
-	.name = "pxa-sph",
-	.id   = -1,
-	.dev  = {
-		.dma_mask = &pxa168_usb_host_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-
-	.num_resources = ARRAY_SIZE(pxa168_usb_host_resources),
-	.resource      = pxa168_usb_host_resources,
-};
-
-int __init pxa168_add_usb_host(struct mv_usb_platform_data *pdata)
-{
-	pxa168_device_usb_host.dev.platform_data = pdata;
-	return platform_device_register(&pxa168_device_usb_host);
-}
-
 void pxa168_restart(char mode, const char *cmd)
 {
 	soft_restart(0xffff0000);
-- 
1.7.4.1
