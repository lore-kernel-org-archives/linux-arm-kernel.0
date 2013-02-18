From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 18 Feb 2013 13:43:44 +0530
Subject: [PATCH 6/7] ARM: Exynos: remove static io-remapping of mct registers
 for Exynos5
In-Reply-To: <1361175225-19282-1-git-send-email-thomas.abraham@linaro.org>
References: <1361175225-19282-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1361175225-19282-7-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With device tree support enabled for MCT controller, the staticio-remapping
of the MCT controller address space is removed for Exynos5 platforms (which
supports only device tree based boot).

Cc: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-exynos/common.c           |    5 -----
 arch/arm/mach-exynos/include/mach/map.h |    1 -
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 4ce342e..3b6527b 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -283,11 +283,6 @@ static struct map_desc exynos5_iodesc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)S5P_VA_SYSTIMER,
-		.pfn		= __phys_to_pfn(EXYNOS5_PA_SYSTIMER),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S5P_VA_SYSRAM,
 		.pfn		= __phys_to_pfn(EXYNOS5_PA_SYSRAM),
 		.length		= SZ_4K,
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index b8ea67e..99e0a79 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -68,7 +68,6 @@
 #define EXYNOS5_PA_CMU			0x10010000
 
 #define EXYNOS4_PA_SYSTIMER		0x10050000
-#define EXYNOS5_PA_SYSTIMER		0x101C0000
 
 #define EXYNOS4_PA_WATCHDOG		0x10060000
 #define EXYNOS5_PA_WATCHDOG		0x101D0000
-- 
1.7.5.4
