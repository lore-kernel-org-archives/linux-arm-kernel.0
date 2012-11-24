From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 25 Nov 2012 02:14:52 +0530
Subject: [PATCH v2 4/5] ARM: Exynos: remove static io-remapping of mct
 registers for Exynos5
In-Reply-To: <1353789893-2460-1-git-send-email-thomas.abraham@linaro.org>
References: <1353789893-2460-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1353789893-2460-5-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With device tree support enabled for MCT controller, the static io-remapping
of the MCT controller address space is removed for Exynos5 platforms (which
supports only device tree based boot).

Cc: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/common.c           |    5 -----
 arch/arm/mach-exynos/include/mach/map.h |    1 -
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 95c0882..8fafac5 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -253,11 +253,6 @@ static struct map_desc exynos5_iodesc[] __initdata = {
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
index 1df6abb..7f99b7b 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -65,7 +65,6 @@
 #define EXYNOS5_PA_CMU			0x10010000
 
 #define EXYNOS4_PA_SYSTIMER		0x10050000
-#define EXYNOS5_PA_SYSTIMER		0x101C0000
 
 #define EXYNOS4_PA_WATCHDOG		0x10060000
 #define EXYNOS5_PA_WATCHDOG		0x101D0000
-- 
1.7.4.4
