From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Tue, 24 Aug 2010 09:57:39 +0200
Subject: [PATCH] MX3x: clean kpp resource structure definitions
Message-ID: <1282636659-2868-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/mach-mx3/devices.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index a4fd1a2..a3e0fe2 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -374,12 +374,12 @@ struct platform_device imx_rtc_device0 = {
 
 static struct resource imx_kpp_resources[] = {
 	{
-		.start	= MX3x_KPP_BASE_ADDR,
-		.end	= MX3x_KPP_BASE_ADDR + 0xf,
-		.flags	= IORESOURCE_MEM
+		.start	= KPP_BASE_ADDR,
+		.end	= KPP_BASE_ADDR + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
 	}, {
-		.start	= MX3x_INT_KPP,
-		.end	= MX3x_INT_KPP,
+		.start	= MXC_INT_KPP,
+		.end	= MXC_INT_KPP,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
-- 
1.7.1
