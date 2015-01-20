From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 20 Jan 2015 16:07:26 +0000
Subject: [PATCHv2 2/5] arm: pxa: specify PMUs are for XScale CPUs
In-Reply-To: <1421770049-32029-1-git-send-email-mark.rutland@arm.com>
References: <1421770049-32029-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1421770049-32029-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can specify which PMU variant we're likely to deal with, do
so in the pxa board code. This will allow us to split the ARMv6, ARMv7,
and XScale PMU drivers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-pxa/devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index ac7b3ea..3543466 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -40,7 +40,7 @@ static struct resource pxa_resource_pmu = {
 };
 
 struct platform_device pxa_device_pmu = {
-	.name		= "arm-pmu",
+	.name		= "xscale-pmu",
 	.id		= -1,
 	.resource	= &pxa_resource_pmu,
 	.num_resources	= 1,
-- 
1.9.1
