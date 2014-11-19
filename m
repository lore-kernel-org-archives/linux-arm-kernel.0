From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Nov 2014 11:49:59 +0000
Subject: [PATCH 5/6] arm: shmobile: specify PMUs are for ARMv7 CPUs
In-Reply-To: <1416397800-12457-1-git-send-email-mark.rutland@arm.com>
References: <1416397800-12457-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1416397800-12457-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can specify which PMU variant we're likely to deal with, do
so in the shmobile board code. This will allow us to split the ARMv6,
ARMv7, and XScale PMU drivers

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 8894e1b..f3abc9e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -659,7 +659,7 @@ static struct resource pmu_resources[] = {
 };
 
 static struct platform_device pmu_device = {
-	.name	= "arm-pmu",
+	.name	= "armv7-pmu",
 	.id	= -1,
 	.num_resources = ARRAY_SIZE(pmu_resources),
 	.resource = pmu_resources,
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index b7bd8e5..23aa1c1 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -546,7 +546,7 @@ static struct resource pmu_resources[] = {
 };
 
 static struct platform_device pmu_device = {
-	.name		= "arm-pmu",
+	.name		= "armv7-pmu",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(pmu_resources),
 	.resource	= pmu_resources,
-- 
1.9.1
