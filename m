From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 18 Jul 2012 19:15:22 +0530
Subject: [PATCH 2/8] ARM: EXYNOS5: Add machine data for USB 2.0
In-Reply-To: <1342619128-25013-1-git-send-email-gautam.vivek@samsung.com>
References: <1342619128-25013-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1342619128-25013-3-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ajay Kumar <ajaykumar.rs@samsung.com>

This patch adds address mapping of USB 2.0 PHY for exynos5

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 4eb39cd..92d5e61 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -275,6 +275,11 @@ static struct map_desc exynos5_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(EXYNOS5_PA_GIC_DIST),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_USB_HSPHY,
+		.pfn		= __phys_to_pfn(EXYNOS5_PA_USB_PHY),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
 	},
 };
 
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index c72b675..331ae57 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -192,6 +192,8 @@
 #define EXYNOS4_PA_UART			0x13800000
 #define EXYNOS5_PA_UART			0x12C00000
 
+#define EXYNOS5_PA_USB_PHY		0x12130000
+
 #define EXYNOS4_PA_VP			0x12C00000
 #define EXYNOS4_PA_MIXER		0x12C10000
 #define EXYNOS4_PA_SDO			0x12C20000
-- 
1.7.0.4
