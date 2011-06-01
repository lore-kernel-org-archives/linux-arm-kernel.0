From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed,  1 Jun 2011 15:30:34 -0700
Subject: [PATCH] ARM: S5P: Should be S3C_VA_USB_HSPHY instead of S5P_VA_XX
Message-ID: <1306967434-13562-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basically, other S3C SoCs and S5PC100 use 'S3C_VA_USB_HSPHY'
commonly. It should be changed to 'S3C_VA_USB_HSPHY' for common
usage and others. Now happens build error on S5PC100.

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/cpu.c                       |    2 +-
 arch/arm/mach-exynos4/include/mach/regs-usb-phy.h |    2 +-
 arch/arm/plat-s5p/include/plat/map-s5p.h          |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 08813a6..9babe447 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -98,7 +98,7 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)S5P_VA_USB_HSPHY,
+		.virtual	= (unsigned long)S3C_VA_USB_HSPHY,
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_HSPHY),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
diff --git a/arch/arm/mach-exynos4/include/mach/regs-usb-phy.h b/arch/arm/mach-exynos4/include/mach/regs-usb-phy.h
index 703118d..c337cf3 100644
--- a/arch/arm/mach-exynos4/include/mach/regs-usb-phy.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-usb-phy.h
@@ -11,7 +11,7 @@
 #ifndef __PLAT_S5P_REGS_USB_PHY_H
 #define __PLAT_S5P_REGS_USB_PHY_H
 
-#define EXYNOS4_HSOTG_PHYREG(x)		((x) + S5P_VA_USB_HSPHY)
+#define EXYNOS4_HSOTG_PHYREG(x)		((x) + S3C_VA_USB_HSPHY)
 
 #define EXYNOS4_PHYPWR			EXYNOS4_HSOTG_PHYREG(0x00)
 #define PHY1_HSIC_NORMAL_MASK		(0xf << 9)
diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
index a6c3d32..d973d39 100644
--- a/arch/arm/plat-s5p/include/plat/map-s5p.h
+++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
@@ -39,7 +39,7 @@
 #define S5P_VA_TWD		S5P_VA_COREPERI(0x600)
 #define S5P_VA_GIC_DIST		S5P_VA_COREPERI(0x1000)
 
-#define S5P_VA_USB_HSPHY	S3C_ADDR(0x02900000)
+#define S3C_VA_USB_HSPHY	S3C_ADDR(0x02900000)
 
 #define VA_VIC(x)		(S3C_VA_IRQ + ((x) * 0x10000))
 #define VA_VIC0			VA_VIC(0)
-- 
1.7.4.4
