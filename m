From: robh@kernel.org (Rob Herring)
Date: Mon, 11 May 2015 17:41:26 -0500
Subject: [PATCH v3 1/4] ARM: pxa: add memory resource to RTC device
In-Reply-To: <1431384089-28367-1-git-send-email-robh@kernel.org>
References: <1431384089-28367-1-git-send-email-robh@kernel.org>
Message-ID: <1431384089-28367-2-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the memory resource for the sa1100-rtc device. Since the memory
resource is already present in the pxa_rtc_resources, that makes
sa1100_rtc_resources and pxa_rtc_resources equivalent, so use
pxa_rtc_resources for both devices and remove the duplicate
sa1100_rtc_resources.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-pxa/devices.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 3543466..b598db6 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -439,25 +439,11 @@ struct platform_device pxa_device_rtc = {
 	.resource       = pxa_rtc_resources,
 };
 
-static struct resource sa1100_rtc_resources[] = {
-	{
-		.start  = IRQ_RTC1Hz,
-		.end    = IRQ_RTC1Hz,
-		.name	= "rtc 1Hz",
-		.flags  = IORESOURCE_IRQ,
-	}, {
-		.start  = IRQ_RTCAlrm,
-		.end    = IRQ_RTCAlrm,
-		.name	= "rtc alarm",
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
 struct platform_device sa1100_device_rtc = {
 	.name		= "sa1100-rtc",
 	.id		= -1,
-	.num_resources	= ARRAY_SIZE(sa1100_rtc_resources),
-	.resource	= sa1100_rtc_resources,
+	.num_resources  = ARRAY_SIZE(pxa_rtc_resources),
+	.resource       = pxa_rtc_resources,
 };
 
 static struct resource pxa_ac97_resources[] = {
-- 
2.1.0
