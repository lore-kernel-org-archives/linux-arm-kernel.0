From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 20 May 2010 13:36:11 +0200
Subject: [PATCH 1/2] mx27 devices: Fix CSI/EMMA base addresses
Message-ID: <mailman.466.1274426293.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx2/devices.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
index de501ac..6a49c79 100644
--- a/arch/arm/mach-mx2/devices.c
+++ b/arch/arm/mach-mx2/devices.c
@@ -43,20 +43,20 @@
 #ifdef CONFIG_MACH_MX27
 static struct resource mx27_camera_resources[] = {
 	{
-	       .start = CSI_BASE_ADDR,
-	       .end = CSI_BASE_ADDR + 0x1f,
+	       .start = MX27_CSI_BASE_ADDR,
+	       .end = MX27_CSI_BASE_ADDR + 0x1f,
 	       .flags = IORESOURCE_MEM,
 	}, {
-	       .start = EMMA_PRP_BASE_ADDR,
-	       .end = EMMA_PRP_BASE_ADDR + 0x1f,
+	       .start = MX27_EMMA_PRP_BASE_ADDR,
+	       .end = MX27_EMMA_PRP_BASE_ADDR + 0x1f,
 	       .flags = IORESOURCE_MEM,
 	}, {
-	       .start = MXC_INT_CSI,
-	       .end = MXC_INT_CSI,
+	       .start = MX27_INT_CSI,
+	       .end = MX27_INT_CSI,
 	       .flags = IORESOURCE_IRQ,
 	},{
-	       .start = MXC_INT_EMMAPRP,
-	       .end = MXC_INT_EMMAPRP,
+	       .start = MX27_INT_EMMAPRP,
+	       .end = MX27_INT_EMMAPRP,
 	       .flags = IORESOURCE_IRQ,
 	},
 };
-- 
1.7.0


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
