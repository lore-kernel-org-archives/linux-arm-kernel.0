From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 23 Jun 2010 19:52:18 +0800
Subject: [PATCH 6/6] [ARM] Introduce common definition for __io()
In-Reply-To: <1277293938-25804-1-git-send-email-eric.y.miao@gmail.com>
References: <1277293938-25804-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1277293938-25804-7-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/include/asm/io.h                 |    4 ++++
 arch/arm/mach-aaec2000/include/mach/io.h  |    1 -
 arch/arm/mach-at91/include/mach/io.h      |    1 -
 arch/arm/mach-bcmring/include/mach/io.h   |    1 -
 arch/arm/mach-clps711x/include/mach/io.h  |    1 -
 arch/arm/mach-cns3xxx/include/mach/io.h   |    1 -
 arch/arm/mach-davinci/include/mach/io.h   |    1 -
 arch/arm/mach-ep93xx/include/mach/io.h    |    1 -
 arch/arm/mach-gemini/include/mach/io.h    |    1 -
 arch/arm/mach-h720x/include/mach/io.h     |    1 -
 arch/arm/mach-ixp4xx/include/mach/io.h    |    1 -
 arch/arm/mach-ks8695/include/mach/io.h    |    1 -
 arch/arm/mach-l7200/include/mach/io.h     |    1 -
 arch/arm/mach-lh7a40x/include/mach/io.h   |    1 -
 arch/arm/mach-mmp/include/mach/io.h       |    1 -
 arch/arm/mach-msm/include/mach/io.h       |    1 -
 arch/arm/mach-netx/include/mach/io.h      |    1 -
 arch/arm/mach-nomadik/include/mach/io.h   |    1 -
 arch/arm/mach-ns9xxx/include/mach/io.h    |    1 -
 arch/arm/mach-nuc93x/include/mach/io.h    |    1 -
 arch/arm/mach-orion5x/include/mach/io.h   |    1 -
 arch/arm/mach-pnx4008/include/mach/io.h   |    1 -
 arch/arm/mach-pxa/include/mach/io.h       |    1 -
 arch/arm/mach-realview/include/mach/io.h  |    1 -
 arch/arm/mach-s3c24a0/include/mach/io.h   |    1 -
 arch/arm/mach-s3c64xx/include/mach/io.h   |    1 -
 arch/arm/mach-s5p6440/include/mach/io.h   |    1 -
 arch/arm/mach-s5p6442/include/mach/io.h   |    1 -
 arch/arm/mach-s5pc100/include/mach/io.h   |    1 -
 arch/arm/mach-s5pv210/include/mach/io.h   |    1 -
 arch/arm/mach-sa1100/include/mach/io.h    |    1 -
 arch/arm/mach-u300/include/mach/io.h      |    1 -
 arch/arm/mach-ux500/include/mach/io.h     |    1 -
 arch/arm/mach-versatile/include/mach/io.h |    1 -
 arch/arm/mach-vexpress/include/mach/io.h  |    1 -
 arch/arm/mach-w90x900/include/mach/io.h   |    1 -
 arch/arm/plat-mxc/include/mach/io.h       |    1 -
 arch/arm/plat-omap/include/plat/io.h      |    1 -
 arch/arm/plat-spear/include/plat/io.h     |    1 -
 arch/arm/plat-stmp3xxx/include/mach/io.h  |    1 -
 40 files changed, 4 insertions(+), 39 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index c5b8803..afcc58a 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -105,6 +105,10 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 #define __mem_pci(a)	(a)
 #endif
 
+#ifndef __io
+#define __io(a)		__typesafe_io(a)
+#endif
+
 /*
  *  IO port access primitives
  *  -------------------------
diff --git a/arch/arm/mach-aaec2000/include/mach/io.h b/arch/arm/mach-aaec2000/include/mach/io.h
index 8b9193d..b391dae 100644
--- a/arch/arm/mach-aaec2000/include/mach/io.h
+++ b/arch/arm/mach-aaec2000/include/mach/io.h
@@ -10,5 +10,4 @@
  * We don't actually have real ISA nor PCI buses, but there is so many
  * drivers out there that might just work if we fake them...
  */
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-at91/include/mach/io.h b/arch/arm/mach-at91/include/mach/io.h
index ab014c0..fe4a498 100644
--- a/arch/arm/mach-at91/include/mach/io.h
+++ b/arch/arm/mach-at91/include/mach/io.h
@@ -21,7 +21,6 @@
 #ifndef __ASM_ARCH_IO_H
 #define __ASM_ARCH_IO_H
 
-#define __io(a)		__typesafe_io(a)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm/mach-bcmring/include/mach/io.h b/arch/arm/mach-bcmring/include/mach/io.h
index 3357d80..ed1cacc 100644
--- a/arch/arm/mach-bcmring/include/mach/io.h
+++ b/arch/arm/mach-bcmring/include/mach/io.h
@@ -25,5 +25,4 @@
  * We don't actually have real ISA nor PCI buses, but there is so many
  * drivers out there that might just work if we fake them...
  */
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-clps711x/include/mach/io.h b/arch/arm/mach-clps711x/include/mach/io.h
index 83980b6..7711803 100644
--- a/arch/arm/mach-clps711x/include/mach/io.h
+++ b/arch/arm/mach-clps711x/include/mach/io.h
@@ -20,7 +20,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define __io(a)		__typesafe_io(a)
 /*
  * We don't support ins[lb]/outs[lb].  Make them fault.
  */
diff --git a/arch/arm/mach-cns3xxx/include/mach/io.h b/arch/arm/mach-cns3xxx/include/mach/io.h
index be5a0d2..092eb41 100644
--- a/arch/arm/mach-cns3xxx/include/mach/io.h
+++ b/arch/arm/mach-cns3xxx/include/mach/io.h
@@ -9,5 +9,4 @@
 #ifndef __MACH_IO_H
 #define __MACH_IO_H
 
-#define __io(a)			__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-davinci/include/mach/io.h b/arch/arm/mach-davinci/include/mach/io.h
index 078d939..a4343f0 100644
--- a/arch/arm/mach-davinci/include/mach/io.h
+++ b/arch/arm/mach-davinci/include/mach/io.h
@@ -15,7 +15,6 @@
  * We don't actually have real ISA nor PCI buses, but there is so many
  * drivers out there that might just work if we fake them...
  */
-#define __io(a)			__typesafe_io(a)
 
 #ifndef __ASSEMBLER__
 #define __arch_ioremap(p, s, t)	davinci_ioremap(p, s, t)
diff --git a/arch/arm/mach-ep93xx/include/mach/io.h b/arch/arm/mach-ep93xx/include/mach/io.h
index b63e543..e579eff 100644
--- a/arch/arm/mach-ep93xx/include/mach/io.h
+++ b/arch/arm/mach-ep93xx/include/mach/io.h
@@ -5,7 +5,6 @@
 #ifndef __ASM_MACH_IO_H
 #define __ASM_MACH_IO_H
 
-#define __io(p)			__typesafe_io(p)
 /*
  * A typesafe __io() variation for variable initialisers
  */
diff --git a/arch/arm/mach-gemini/include/mach/io.h b/arch/arm/mach-gemini/include/mach/io.h
index 9925714..8f94508 100644
--- a/arch/arm/mach-gemini/include/mach/io.h
+++ b/arch/arm/mach-gemini/include/mach/io.h
@@ -10,5 +10,4 @@
 #ifndef __MACH_IO_H
 #define __MACH_IO_H
 
-#define __io(a)		__typesafe_io(a)
 #endif /* __MACH_IO_H */
diff --git a/arch/arm/mach-h720x/include/mach/io.h b/arch/arm/mach-h720x/include/mach/io.h
index 8745f59..c632af0 100644
--- a/arch/arm/mach-h720x/include/mach/io.h
+++ b/arch/arm/mach-h720x/include/mach/io.h
@@ -14,5 +14,4 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index 7489f8f..8dc8d50 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -233,7 +233,6 @@ static inline void __indirect_readsl(const volatile void __iomem *bus_addr,
 
 #ifndef CONFIG_PCI
 
-#define	__io(v)		__typesafe_io(v)
 
 #else
 
diff --git a/arch/arm/mach-ks8695/include/mach/io.h b/arch/arm/mach-ks8695/include/mach/io.h
index d2029d3..5e7e96b 100644
--- a/arch/arm/mach-ks8695/include/mach/io.h
+++ b/arch/arm/mach-ks8695/include/mach/io.h
@@ -11,5 +11,4 @@
 #ifndef __ASM_ARCH_IO_H
 #define __ASM_ARCH_IO_H
 
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-l7200/include/mach/io.h b/arch/arm/mach-l7200/include/mach/io.h
index 13b6e5c..d3b837a 100644
--- a/arch/arm/mach-l7200/include/mach/io.h
+++ b/arch/arm/mach-l7200/include/mach/io.h
@@ -13,5 +13,4 @@
 /*
  * There are not real ISA nor PCI buses, so we fake it.
  */
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-lh7a40x/include/mach/io.h b/arch/arm/mach-lh7a40x/include/mach/io.h
index 4de858b..09e42f6 100644
--- a/arch/arm/mach-lh7a40x/include/mach/io.h
+++ b/arch/arm/mach-lh7a40x/include/mach/io.h
@@ -12,5 +12,4 @@
 #define __ASM_ARCH_IO_H
 
 /* No ISA or PCI bus on this machine. */
-#define __io(a)		__typesafe_io(a)
 #endif /* __ASM_ARCH_IO_H */
diff --git a/arch/arm/mach-mmp/include/mach/io.h b/arch/arm/mach-mmp/include/mach/io.h
index e9581d5..3a0b9c8 100644
--- a/arch/arm/mach-mmp/include/mach/io.h
+++ b/arch/arm/mach-mmp/include/mach/io.h
@@ -13,5 +13,4 @@
  * We don't actually have real ISA nor PCI buses, but there is so many
  * drivers out there that might just work if we fake them...
  */
-#define __io(a)		__typesafe_io(a)
 #endif /* __ASM_MACH_IO_H */
diff --git a/arch/arm/mach-msm/include/mach/io.h b/arch/arm/mach-msm/include/mach/io.h
index 5e0e93d..94bc292 100644
--- a/arch/arm/mach-msm/include/mach/io.h
+++ b/arch/arm/mach-msm/include/mach/io.h
@@ -21,7 +21,6 @@
 
 void __iomem *__msm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype);
 
-#define __io(a)		__typesafe_io(a)
 void msm_map_qsd8x50_io(void);
 void msm_map_msm7x30_io(void);
 
diff --git a/arch/arm/mach-netx/include/mach/io.h b/arch/arm/mach-netx/include/mach/io.h
index ac134a8..57e251c 100644
--- a/arch/arm/mach-netx/include/mach/io.h
+++ b/arch/arm/mach-netx/include/mach/io.h
@@ -20,5 +20,4 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-nomadik/include/mach/io.h b/arch/arm/mach-nomadik/include/mach/io.h
index a2b9e1a..9dffc02 100644
--- a/arch/arm/mach-nomadik/include/mach/io.h
+++ b/arch/arm/mach-nomadik/include/mach/io.h
@@ -14,5 +14,4 @@
  * We don't actually have real ISA nor PCI buses, but there is so many
  * drivers out there that might just work if we fake them...
  */
-#define __io(a)         __typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-ns9xxx/include/mach/io.h b/arch/arm/mach-ns9xxx/include/mach/io.h
index 11de350..f2495ae 100644
--- a/arch/arm/mach-ns9xxx/include/mach/io.h
+++ b/arch/arm/mach-ns9xxx/include/mach/io.h
@@ -11,6 +11,5 @@
 #ifndef __ASM_ARCH_IO_H
 #define __ASM_ARCH_IO_H
 
-#define __io(a)		__typesafe_io(a)
 
 #endif /* ifndef __ASM_ARCH_IO_H */
diff --git a/arch/arm/mach-nuc93x/include/mach/io.h b/arch/arm/mach-nuc93x/include/mach/io.h
index 99fe76d..96faf0e 100644
--- a/arch/arm/mach-nuc93x/include/mach/io.h
+++ b/arch/arm/mach-nuc93x/include/mach/io.h
@@ -20,6 +20,5 @@
  * 1:1 mapping for ioremapped regions.
  */
 
-#define __io(a)		__typesafe_io(a)
 
 #endif
diff --git a/arch/arm/mach-orion5x/include/mach/io.h b/arch/arm/mach-orion5x/include/mach/io.h
index 34c2a5c..b3b24eb 100644
--- a/arch/arm/mach-orion5x/include/mach/io.h
+++ b/arch/arm/mach-orion5x/include/mach/io.h
@@ -38,7 +38,6 @@ __arch_iounmap(void __iomem *addr)
 
 #define __arch_ioremap(p, s, m)	__arch_ioremap(p, s, m)
 #define __arch_iounmap(a)	__arch_iounmap(a)
-#define __io(a)			__typesafe_io(a)
 
 /*****************************************************************************
  * Helpers to access Orion registers
diff --git a/arch/arm/mach-pnx4008/include/mach/io.h b/arch/arm/mach-pnx4008/include/mach/io.h
index bd655e5..cc9648b 100644
--- a/arch/arm/mach-pnx4008/include/mach/io.h
+++ b/arch/arm/mach-pnx4008/include/mach/io.h
@@ -13,5 +13,4 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/io.h b/arch/arm/mach-pxa/include/mach/io.h
index 5bfd427..286be85 100644
--- a/arch/arm/mach-pxa/include/mach/io.h
+++ b/arch/arm/mach-pxa/include/mach/io.h
@@ -10,5 +10,4 @@
  * We don't actually have real ISA nor PCI buses, but there is so many
  * drivers out there that might just work if we fake them...
  */
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-realview/include/mach/io.h b/arch/arm/mach-realview/include/mach/io.h
index cc45381..cfe167d 100644
--- a/arch/arm/mach-realview/include/mach/io.h
+++ b/arch/arm/mach-realview/include/mach/io.h
@@ -20,5 +20,4 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-s3c24a0/include/mach/io.h b/arch/arm/mach-s3c24a0/include/mach/io.h
index e04664f..67ec841 100644
--- a/arch/arm/mach-s3c24a0/include/mach/io.h
+++ b/arch/arm/mach-s3c24a0/include/mach/io.h
@@ -10,5 +10,4 @@
 #define __ASM_ARM_ARCH_IO_H
 
 /* No current ISA/PCI bus support. */
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-s3c64xx/include/mach/io.h b/arch/arm/mach-s3c64xx/include/mach/io.h
index eb4dae8..5588df0 100644
--- a/arch/arm/mach-s3c64xx/include/mach/io.h
+++ b/arch/arm/mach-s3c64xx/include/mach/io.h
@@ -10,5 +10,4 @@
 #define __ASM_ARM_ARCH_IO_H
 
 /* No current ISA/PCI bus support. */
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-s5p6440/include/mach/io.h b/arch/arm/mach-s5p6440/include/mach/io.h
index 10e18d3..00a9bf2 100644
--- a/arch/arm/mach-s5p6440/include/mach/io.h
+++ b/arch/arm/mach-s5p6440/include/mach/io.h
@@ -10,5 +10,4 @@
 #define __ASM_ARM_ARCH_IO_H
 
 /* No current ISA/PCI bus support. */
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-s5p6442/include/mach/io.h b/arch/arm/mach-s5p6442/include/mach/io.h
index 02cacba..ee3f30b 100644
--- a/arch/arm/mach-s5p6442/include/mach/io.h
+++ b/arch/arm/mach-s5p6442/include/mach/io.h
@@ -9,5 +9,4 @@
 #define __ASM_ARM_ARCH_IO_H
 
 /* No current ISA/PCI bus support. */
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-s5pc100/include/mach/io.h b/arch/arm/mach-s5pc100/include/mach/io.h
index d0970e4..cdabf13 100644
--- a/arch/arm/mach-s5pc100/include/mach/io.h
+++ b/arch/arm/mach-s5pc100/include/mach/io.h
@@ -10,5 +10,4 @@
 #define __ASM_ARM_ARCH_IO_H
 
 /* No current ISA/PCI bus support. */
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-s5pv210/include/mach/io.h b/arch/arm/mach-s5pv210/include/mach/io.h
index f80590e..3aa48f4 100644
--- a/arch/arm/mach-s5pv210/include/mach/io.h
+++ b/arch/arm/mach-s5pv210/include/mach/io.h
@@ -18,5 +18,4 @@
 #define __ASM_ARM_ARCH_IO_H __FILE__
 
 /* No current ISA/PCI bus support. */
-#define __io(a)		__typesafe_io(a)
 #endif /* __ASM_ARM_ARCH_IO_H */
diff --git a/arch/arm/mach-sa1100/include/mach/io.h b/arch/arm/mach-sa1100/include/mach/io.h
index 0817eb0..32d1a64 100644
--- a/arch/arm/mach-sa1100/include/mach/io.h
+++ b/arch/arm/mach-sa1100/include/mach/io.h
@@ -14,5 +14,4 @@
  * We don't actually have real ISA nor PCI buses, but there is so many 
  * drivers out there that might just work if we fake them...
  */
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-u300/include/mach/io.h b/arch/arm/mach-u300/include/mach/io.h
index 6770eea..e290b2c 100644
--- a/arch/arm/mach-u300/include/mach/io.h
+++ b/arch/arm/mach-u300/include/mach/io.h
@@ -12,5 +12,4 @@
 #ifndef __MACH_IO_H
 #define __MACH_IO_H
 
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-ux500/include/mach/io.h b/arch/arm/mach-ux500/include/mach/io.h
index 16acb3b..844d86a 100644
--- a/arch/arm/mach-ux500/include/mach/io.h
+++ b/arch/arm/mach-ux500/include/mach/io.h
@@ -14,5 +14,4 @@
  * We don't actually have real ISA nor PCI buses, but there is so many
  * drivers out there that might just work if we fake them...
  */
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-versatile/include/mach/io.h b/arch/arm/mach-versatile/include/mach/io.h
index 25c902a..e329b57 100644
--- a/arch/arm/mach-versatile/include/mach/io.h
+++ b/arch/arm/mach-versatile/include/mach/io.h
@@ -20,5 +20,4 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-vexpress/include/mach/io.h b/arch/arm/mach-vexpress/include/mach/io.h
index 2b73325..33a77d4 100644
--- a/arch/arm/mach-vexpress/include/mach/io.h
+++ b/arch/arm/mach-vexpress/include/mach/io.h
@@ -20,5 +20,4 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define __io(a)		__typesafe_io(a)
 #endif
diff --git a/arch/arm/mach-w90x900/include/mach/io.h b/arch/arm/mach-w90x900/include/mach/io.h
index 272f76b..fdbde6d 100644
--- a/arch/arm/mach-w90x900/include/mach/io.h
+++ b/arch/arm/mach-w90x900/include/mach/io.h
@@ -22,6 +22,5 @@
  * 1:1 mapping for ioremapped regions.
  */
 
-#define __io(a)		__typesafe_io(a)
 
 #endif
diff --git a/arch/arm/plat-mxc/include/mach/io.h b/arch/arm/plat-mxc/include/mach/io.h
index ed05017..784b421 100644
--- a/arch/arm/plat-mxc/include/mach/io.h
+++ b/arch/arm/plat-mxc/include/mach/io.h
@@ -33,6 +33,5 @@ __mx3_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
 #endif
 
 /* io address mapping macro */
-#define __io(a)		__typesafe_io(a)
 
 #endif
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index a9beb3c..03e7d91 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -43,7 +43,6 @@
  * We don't actually have real ISA nor PCI buses, but there is so many
  * drivers out there that might just work if we fake them...
  */
-#define __io(a)		__typesafe_io(a)
 /*
  * ----------------------------------------------------------------------------
  * I/O mapping
diff --git a/arch/arm/plat-spear/include/plat/io.h b/arch/arm/plat-spear/include/plat/io.h
index faf8e7e..540d5ad 100644
--- a/arch/arm/plat-spear/include/plat/io.h
+++ b/arch/arm/plat-spear/include/plat/io.h
@@ -14,5 +14,4 @@
 #ifndef __PLAT_IO_H
 #define __PLAT_IO_H
 
-#define __io(a)			__typesafe_io(a)
 #endif /* __PLAT_IO_H */
diff --git a/arch/arm/plat-stmp3xxx/include/mach/io.h b/arch/arm/plat-stmp3xxx/include/mach/io.h
index 4649a7b..64144c4 100644
--- a/arch/arm/plat-stmp3xxx/include/mach/io.h
+++ b/arch/arm/plat-stmp3xxx/include/mach/io.h
@@ -16,6 +16,5 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define __io(a) 	__typesafe_io(a)
 
 #endif
-- 
1.7.1
