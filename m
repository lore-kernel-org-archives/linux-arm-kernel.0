From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 15 May 2010 04:08:44 +0200
Subject: [PATCH] mx21/devices: fix USBOTG resource
Message-ID: <1273889324-29720-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It got a typo from 988addf82e4c03739375279de73929580a2d4a6a.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Martin Fuzzey <mfuzzey@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx2/devices.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
index b91e412..04f36d8 100644
--- a/arch/arm/mach-mx2/devices.c
+++ b/arch/arm/mach-mx2/devices.c
@@ -483,8 +483,8 @@ int __init mxc_register_gpios(void)
 #ifdef CONFIG_MACH_MX21
 static struct resource mx21_usbhc_resources[] = {
 	{
-		.start	= MX21_BASE_ADDR,
-		.end	= MX21_BASE_ADDR + 0x1FFF,
+		.start	= MX21_USBOTG_BASE_ADDR,
+		.end	= MX21_USBOTG_BASE_ADDR + SZ_8K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-- 
1.7.0
