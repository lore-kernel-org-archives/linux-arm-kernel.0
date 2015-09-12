From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 12 Sep 2015 13:36:49 +0200
Subject: [PATCH] ARM: pxa: add resources to pxaficp_ir
Message-ID: <1442057809-9586-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add io memory and dma requestor lines to the irda pxa device. This is
part of the conversion of pxaficp_ir to dmaengine, and to shrink its
adherence to 'mach' includes.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/devices.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 35434662dc7c..9592667453b0 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -394,6 +394,26 @@ static struct resource pxa_ir_resources[] = {
 		.end    = IRQ_ICP,
 		.flags  = IORESOURCE_IRQ,
 	},
+	[3] = {
+		.start  = 0x40800000,
+		.end	= 0x4080001b,
+		.flags  = IORESOURCE_MEM,
+	},
+	[4] = {
+		.start  = 0x40700000,
+		.end	= 0x40700023,
+		.flags  = IORESOURCE_MEM,
+	},
+	[5] = {
+		.start  = 17,
+		.end	= 17,
+		.flags  = IORESOURCE_DMA,
+	},
+	[6] = {
+		.start  = 18,
+		.end	= 18,
+		.flags  = IORESOURCE_DMA,
+	},
 };
 
 struct platform_device pxa_device_ficp = {
-- 
2.1.4
