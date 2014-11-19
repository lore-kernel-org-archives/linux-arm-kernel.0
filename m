From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Nov 2014 11:49:58 +0000
Subject: [PATCH 4/6] arm: iop: specify PMUs are for XScale CPUs
In-Reply-To: <1416397800-12457-1-git-send-email-mark.rutland@arm.com>
References: <1416397800-12457-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1416397800-12457-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can specify which PMU variant we're likely to deal with, do
so in the iop board code. This will allow us to split the ARMv6, ARMv7,
and XScale PMU drivers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/plat-iop/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-iop/pmu.c b/arch/arm/plat-iop/pmu.c
index ad9f974..c6d979a 100644
--- a/arch/arm/plat-iop/pmu.c
+++ b/arch/arm/plat-iop/pmu.c
@@ -24,7 +24,7 @@ static struct resource pmu_resource = {
 };
 
 static struct platform_device pmu_device = {
-	.name		= "arm-pmu",
+	.name		= "xscale-pmu",
 	.id		= -1,
 	.resource	= &pmu_resource,
 	.num_resources	= 1,
-- 
1.9.1
