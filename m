From: angus.ainslie@linaro.org (Angus Ainslie)
Date: Thu,  6 Oct 2011 16:03:15 -0600
Subject: [PATCH] arm: exynos4: build is failing due to missing SZ_4K definition
Message-ID: <1317938595-7007-1-git-send-email-angus.ainslie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

linux-next build is failing using the exynos4_defconfig. <asm/sizes.h> needs to be 
for the SZ_4K definition

Signed-off-by: Angus Ainslie <angus.ainslie@linaro.org>
---
 arch/arm/mach-exynos4/include/mach/map.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
index 918a979..02d68f1 100644
--- a/arch/arm/mach-exynos4/include/mach/map.h
+++ b/arch/arm/mach-exynos4/include/mach/map.h
@@ -13,6 +13,7 @@
 #ifndef __ASM_ARCH_MAP_H
 #define __ASM_ARCH_MAP_H __FILE__
 
+#include <asm/sizes.h>
 #include <plat/map-base.h>
 
 /*
-- 
1.7.4.1
