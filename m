From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 20 Jan 2015 16:07:28 +0000
Subject: [PATCHv2 4/5] arm: shmobile: specify PMUs are for ARMv7 CPUs
In-Reply-To: <1421770049-32029-1-git-send-email-mark.rutland@arm.com>
References: <1421770049-32029-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1421770049-32029-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can specify which PMU variant we're likely to deal with, do
so in the shmobile board code. This will allow us to split the ARMv6,
ARMv7, and XScale PMU drivers

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 79ad93d..6edde2f 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -656,7 +656,7 @@ static struct resource pmu_resources[] = {
 };
 
 static struct platform_device pmu_device = {
-	.name	= "arm-pmu",
+	.name	= "armv7-pmu",
 	.id	= -1,
 	.num_resources = ARRAY_SIZE(pmu_resources),
 	.resource = pmu_resources,
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 93ebe34..bdfa7a5 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -563,7 +563,7 @@ static struct resource pmu_resources[] = {
 };
 
 static struct platform_device pmu_device = {
-	.name		= "arm-pmu",
+	.name		= "armv7-pmu",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(pmu_resources),
 	.resource	= pmu_resources,
-- 
1.9.1
