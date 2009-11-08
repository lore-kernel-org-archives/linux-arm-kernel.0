From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Sun, 08 Nov 2009 19:52:27 +0100
Subject: [REPOST PATCH 2/3] MXC: use DMA_BIT_MASK macro rather than hardcoded
	constants.
In-Reply-To: <20091108185217.14742.32892.stgit@srv002.fuzzey.net>
References: <20091108185217.14742.32892.stgit@srv002.fuzzey.net>
Message-ID: <20091108185227.14742.27843.stgit@srv002.fuzzey.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also fixes tab/space issue causing checkpatch to compplain.

Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 arch/arm/mach-mx2/devices.c |   53 ++++++++++++++++++++++---------------------
 1 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
index 50199af..3522397 100644
--- a/arch/arm/mach-mx2/devices.c
+++ b/arch/arm/mach-mx2/devices.c
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/dma-mapping.h>
 
 #include <mach/irqs.h>
 #include <mach/hardware.h>
@@ -292,7 +293,7 @@ struct platform_device mxc_fb_device = {
 	.num_resources = ARRAY_SIZE(mxc_fb),
 	.resource = mxc_fb,
 	.dev = {
-		.coherent_dma_mask = 0xFFFFFFFF,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
@@ -395,17 +396,17 @@ static struct resource mxc_sdhc1_resources[] = {
 	},
 };
 
-static u64 mxc_sdhc1_dmamask = 0xffffffffUL;
+static u64 mxc_sdhc1_dmamask = DMA_BIT_MASK(32);
 
 struct platform_device mxc_sdhc_device0 = {
-       .name           = "mxc-mmc",
-       .id             = 0,
-       .dev            = {
-               .dma_mask = &mxc_sdhc1_dmamask,
-               .coherent_dma_mask = 0xffffffff,
-       },
-       .num_resources  = ARRAY_SIZE(mxc_sdhc1_resources),
-       .resource       = mxc_sdhc1_resources,
+	.name           = "mxc-mmc",
+	.id             = 0,
+	.dev            = {
+		.dma_mask = &mxc_sdhc1_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+	.num_resources  = ARRAY_SIZE(mxc_sdhc1_resources),
+	.resource       = mxc_sdhc1_resources,
 };
 
 static struct resource mxc_sdhc2_resources[] = {
@@ -424,17 +425,17 @@ static struct resource mxc_sdhc2_resources[] = {
 	},
 };
 
-static u64 mxc_sdhc2_dmamask = 0xffffffffUL;
+static u64 mxc_sdhc2_dmamask = DMA_BIT_MASK(32);
 
 struct platform_device mxc_sdhc_device1 = {
-       .name           = "mxc-mmc",
-       .id             = 1,
-       .dev            = {
-               .dma_mask = &mxc_sdhc2_dmamask,
-               .coherent_dma_mask = 0xffffffff,
-       },
-       .num_resources  = ARRAY_SIZE(mxc_sdhc2_resources),
-       .resource       = mxc_sdhc2_resources,
+	.name           = "mxc-mmc",
+	.id             = 1,
+	.dev            = {
+		.dma_mask = &mxc_sdhc2_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+	.num_resources  = ARRAY_SIZE(mxc_sdhc2_resources),
+	.resource       = mxc_sdhc2_resources,
 };
 
 #ifdef CONFIG_MACH_MX27
@@ -450,7 +451,7 @@ static struct resource otg_resources[] = {
 	},
 };
 
-static u64 otg_dmamask = 0xffffffffUL;
+static u64 otg_dmamask = DMA_BIT_MASK(32);
 
 /* OTG gadget device */
 struct platform_device mxc_otg_udc_device = {
@@ -458,7 +459,7 @@ struct platform_device mxc_otg_udc_device = {
 	.id		= -1,
 	.dev		= {
 		.dma_mask		= &otg_dmamask,
-		.coherent_dma_mask	= 0xffffffffUL,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 	.resource	= otg_resources,
 	.num_resources	= ARRAY_SIZE(otg_resources),
@@ -469,7 +470,7 @@ struct platform_device mxc_otg_host = {
 	.name = "mxc-ehci",
 	.id = 0,
 	.dev = {
-		.coherent_dma_mask = 0xffffffff,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.dma_mask = &otg_dmamask,
 	},
 	.resource = otg_resources,
@@ -478,7 +479,7 @@ struct platform_device mxc_otg_host = {
 
 /* USB host 1 */
 
-static u64 usbh1_dmamask = 0xffffffffUL;
+static u64 usbh1_dmamask = DMA_BIT_MASK(32);
 
 static struct resource mxc_usbh1_resources[] = {
 	{
@@ -496,7 +497,7 @@ struct platform_device mxc_usbh1 = {
 	.name = "mxc-ehci",
 	.id = 1,
 	.dev = {
-		.coherent_dma_mask = 0xffffffff,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.dma_mask = &usbh1_dmamask,
 	},
 	.resource = mxc_usbh1_resources,
@@ -504,7 +505,7 @@ struct platform_device mxc_usbh1 = {
 };
 
 /* USB host 2 */
-static u64 usbh2_dmamask = 0xffffffffUL;
+static u64 usbh2_dmamask = DMA_BIT_MASK(32);
 
 static struct resource mxc_usbh2_resources[] = {
 	{
@@ -522,7 +523,7 @@ struct platform_device mxc_usbh2 = {
 	.name = "mxc-ehci",
 	.id = 2,
 	.dev = {
-		.coherent_dma_mask = 0xffffffff,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.dma_mask = &usbh2_dmamask,
 	},
 	.resource = mxc_usbh2_resources,
