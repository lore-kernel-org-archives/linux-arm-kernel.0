From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue,  5 Oct 2010 11:06:38 +0900
Subject: [PATCH 4/4] ARM: S5P: Cleanup the S5P SoCs' VA address mapping
In-Reply-To: <1286244398-9333-1-git-send-email-kgene.kim@samsung.com>
References: <1286244398-9333-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1286244398-9333-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basically S5P SoCs use the Samsung common VA address mapping where
plat-samsung and use plat-s5p's mapping also. The later is a little
mess. So this patch cleans it up.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s5p/include/plat/map-s5p.h |   40 +++++++++++++++--------------
 1 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
index c833f3f..ec96a19 100644
--- a/arch/arm/plat-s5p/include/plat/map-s5p.h
+++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
@@ -13,27 +13,35 @@
 #ifndef __ASM_PLAT_MAP_S5P_H
 #define __ASM_PLAT_MAP_S5P_H __FILE__
 
-#define S5P_VA_CHIPID		S3C_ADDR(0x00700000)
-#define S5P_VA_GPIO		S3C_ADDR(0x00500000)
-#define S5P_VA_SYSTIMER		S3C_ADDR(0x01200000)
-#define S5P_VA_SROMC		S3C_ADDR(0x01100000)
-#define S5P_VA_SYSRAM		S3C_ADDR(0x01180000)
-#define S3C_VA_USB_HSPHY	S3C_ADDR(0x02000000)
-#define S5P_VA_DMC0		S3C_ADDR(0x00A00000)
-#define S5P_VA_DMC1		S3C_ADDR(0x00A80000)
-
-#define S5P_VA_COMBINER_BASE	S3C_ADDR(0x00600000)
+#define S5P_VA_CHIPID		S3C_ADDR(0x02000000)
+#define S5P_VA_CMU		S3C_ADDR(0x02100000)
+#define S5P_VA_GPIO		S3C_ADDR(0x02200000)
+
+#define S5P_VA_SYSRAM		S3C_ADDR(0x02400000)
+#define S5P_VA_DMC0		S3C_ADDR(0x02440000)
+#define S5P_VA_DMC1		S3C_ADDR(0x02480000)
+#define S5P_VA_SROMC		S3C_ADDR(0x024C0000)
+
+#define S5P_VA_SYSTIMER		S3C_ADDR(0x02500000)
+#define S5P_VA_L2CC		S3C_ADDR(0x02600000)
+
+#define S5P_VA_COMBINER_BASE	S3C_ADDR(0x02700000)
 #define S5P_VA_COMBINER(x)	(S5P_VA_COMBINER_BASE + ((x) >> 2) * 0x10)
 
-#define S5P_VA_COREPERI_BASE	S3C_ADDR(0x00800000)
+#define S5P_VA_COREPERI_BASE	S3C_ADDR(0x02800000)
 #define S5P_VA_COREPERI(x)	(S5P_VA_COREPERI_BASE + (x))
 #define S5P_VA_SCU		S5P_VA_COREPERI(0x0)
 #define S5P_VA_GIC_CPU		S5P_VA_COREPERI(0x100)
 #define S5P_VA_TWD		S5P_VA_COREPERI(0x600)
 #define S5P_VA_GIC_DIST		S5P_VA_COREPERI(0x1000)
 
-#define S5P_VA_L2CC		S3C_ADDR(0x00900000)
-#define S5P_VA_CMU		S3C_ADDR(0x00920000)
+#define S3C_VA_USB_HSPHY	S3C_ADDR(0x02900000)
+
+#define VA_VIC(x)		(S3C_VA_IRQ + ((x) * 0x10000))
+#define VA_VIC0			VA_VIC(0)
+#define VA_VIC1			VA_VIC(1)
+#define VA_VIC2			VA_VIC(2)
+#define VA_VIC3			VA_VIC(3)
 
 #define S5P_VA_UART(x)		(S3C_VA_UART + ((x) * S3C_UART_OFFSET))
 #define S5P_VA_UART0		S5P_VA_UART(0)
@@ -45,10 +53,4 @@
 #define S3C_UART_OFFSET		(0x400)
 #endif
 
-#define VA_VIC(x)		(S3C_VA_IRQ + ((x) * 0x10000))
-#define VA_VIC0			VA_VIC(0)
-#define VA_VIC1			VA_VIC(1)
-#define VA_VIC2			VA_VIC(2)
-#define VA_VIC3			VA_VIC(3)
-
 #endif /* __ASM_PLAT_MAP_S5P_H */
-- 
1.6.2.5
