From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Nov 2014 11:49:57 +0000
Subject: [PATCH 3/6] arm: vexpress: specify PMUs are for ARMv7 CPUs
In-Reply-To: <1416397800-12457-1-git-send-email-mark.rutland@arm.com>
References: <1416397800-12457-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1416397800-12457-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can specify which PMU variant we're likely to deal with, do
so in the vexpress board code. This will allow us to split the ARMv6,
ARMv7, and XScale PMU drivers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-vexpress/ct-ca9x4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 27bea04..656a17f 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -139,7 +139,7 @@ static struct resource pmu_resources[] = {
 };
 
 static struct platform_device pmu_device = {
-	.name		= "arm-pmu",
+	.name		= "armv7-pmu",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(pmu_resources),
 	.resource	= pmu_resources,
-- 
1.9.1
