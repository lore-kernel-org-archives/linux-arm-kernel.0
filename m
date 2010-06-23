From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 23 Jun 2010 19:52:13 +0800
Subject: [PATCH 1/6] [ARM] Make common definition for IO_SPACE_LIMIT
In-Reply-To: <1277293938-25804-1-git-send-email-eric.y.miao@gmail.com>
References: <1277293938-25804-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1277293938-25804-2-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/include/asm/io.h                  |    2 ++
 arch/arm/mach-aaec2000/include/mach/io.h   |    2 --
 arch/arm/mach-at91/include/mach/io.h       |    2 --
 arch/arm/mach-bcmring/include/mach/io.h    |    2 --
 arch/arm/mach-clps711x/include/mach/io.h   |    2 --
 arch/arm/mach-cns3xxx/include/mach/io.h    |    2 --
 arch/arm/mach-davinci/include/mach/io.h    |    2 --
 arch/arm/mach-dove/include/mach/io.h       |    2 --
 arch/arm/mach-ebsa110/include/mach/io.h    |    2 --
 arch/arm/mach-ep93xx/include/mach/io.h     |    2 --
 arch/arm/mach-footbridge/include/mach/io.h |    2 --
 arch/arm/mach-gemini/include/mach/io.h     |    2 --
 arch/arm/mach-h720x/include/mach/io.h      |    2 --
 arch/arm/mach-integrator/include/mach/io.h |    2 --
 arch/arm/mach-iop13xx/include/mach/io.h    |    2 --
 arch/arm/mach-iop32x/include/mach/io.h     |    1 -
 arch/arm/mach-iop33x/include/mach/io.h     |    1 -
 arch/arm/mach-ixp2000/include/mach/io.h    |    1 -
 arch/arm/mach-ixp23xx/include/mach/io.h    |    2 --
 arch/arm/mach-ixp4xx/include/mach/io.h     |    2 --
 arch/arm/mach-kirkwood/include/mach/io.h   |    2 --
 arch/arm/mach-ks8695/include/mach/io.h     |    2 --
 arch/arm/mach-l7200/include/mach/io.h      |    2 --
 arch/arm/mach-lh7a40x/include/mach/io.h    |    2 --
 arch/arm/mach-loki/include/mach/io.h       |    2 --
 arch/arm/mach-mmp/include/mach/io.h        |    2 --
 arch/arm/mach-msm/include/mach/io.h        |    2 --
 arch/arm/mach-mv78xx0/include/mach/io.h    |    2 --
 arch/arm/mach-netx/include/mach/io.h       |    2 --
 arch/arm/mach-nomadik/include/mach/io.h    |    2 --
 arch/arm/mach-ns9xxx/include/mach/io.h     |    2 --
 arch/arm/mach-nuc93x/include/mach/io.h     |    2 --
 arch/arm/mach-orion5x/include/mach/io.h    |    2 --
 arch/arm/mach-pnx4008/include/mach/io.h    |    2 --
 arch/arm/mach-pxa/include/mach/io.h        |    2 --
 arch/arm/mach-realview/include/mach/io.h   |    2 --
 arch/arm/mach-rpc/include/mach/io.h        |    2 --
 arch/arm/mach-s3c2410/include/mach/io.h    |    2 --
 arch/arm/mach-s3c24a0/include/mach/io.h    |    2 --
 arch/arm/mach-s3c64xx/include/mach/io.h    |    2 --
 arch/arm/mach-s5p6440/include/mach/io.h    |    2 --
 arch/arm/mach-s5p6442/include/mach/io.h    |    2 --
 arch/arm/mach-s5pc100/include/mach/io.h    |    2 --
 arch/arm/mach-s5pv210/include/mach/io.h    |    2 --
 arch/arm/mach-sa1100/include/mach/io.h     |    2 --
 arch/arm/mach-shark/include/mach/io.h      |    2 --
 arch/arm/mach-shmobile/include/mach/io.h   |    2 --
 arch/arm/mach-u300/include/mach/io.h       |    2 --
 arch/arm/mach-ux500/include/mach/io.h      |    2 --
 arch/arm/mach-versatile/include/mach/io.h  |    2 --
 arch/arm/mach-vexpress/include/mach/io.h   |    2 --
 arch/arm/mach-w90x900/include/mach/io.h    |    2 --
 arch/arm/plat-mxc/include/mach/io.h        |    2 --
 arch/arm/plat-omap/include/plat/io.h       |    2 --
 arch/arm/plat-spear/include/plat/io.h      |    2 --
 arch/arm/plat-stmp3xxx/include/mach/io.h   |    2 --
 56 files changed, 2 insertions(+), 107 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index c980156..01eec09 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -99,6 +99,8 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
  */
 #include <mach/io.h>
 
+#define IO_SPACE_LIMIT	0xffffffff
+
 /*
  *  IO port access primitives
  *  -------------------------
diff --git a/arch/arm/mach-aaec2000/include/mach/io.h b/arch/arm/mach-aaec2000/include/mach/io.h
index ab4fe5d..ce19850 100644
--- a/arch/arm/mach-aaec2000/include/mach/io.h
+++ b/arch/arm/mach-aaec2000/include/mach/io.h
@@ -6,8 +6,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 /*
  * We don't actually have real ISA nor PCI buses, but there is so many
  * drivers out there that might just work if we fake them...
diff --git a/arch/arm/mach-at91/include/mach/io.h b/arch/arm/mach-at91/include/mach/io.h
index 0b0cccc..34740b5 100644
--- a/arch/arm/mach-at91/include/mach/io.h
+++ b/arch/arm/mach-at91/include/mach/io.h
@@ -21,8 +21,6 @@
 #ifndef __ASM_ARCH_IO_H
 #define __ASM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT		0xFFFFFFFF
-
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
diff --git a/arch/arm/mach-bcmring/include/mach/io.h b/arch/arm/mach-bcmring/include/mach/io.h
index dae5e9b..1dba26d 100644
--- a/arch/arm/mach-bcmring/include/mach/io.h
+++ b/arch/arm/mach-bcmring/include/mach/io.h
@@ -21,8 +21,6 @@
 
 #include <mach/hardware.h>
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 /*
  * We don't actually have real ISA nor PCI buses, but there is so many
  * drivers out there that might just work if we fake them...
diff --git a/arch/arm/mach-clps711x/include/mach/io.h b/arch/arm/mach-clps711x/include/mach/io.h
index 2e0b3ce..2e90452 100644
--- a/arch/arm/mach-clps711x/include/mach/io.h
+++ b/arch/arm/mach-clps711x/include/mach/io.h
@@ -20,8 +20,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
diff --git a/arch/arm/mach-cns3xxx/include/mach/io.h b/arch/arm/mach-cns3xxx/include/mach/io.h
index 33b6fc1..396b959 100644
--- a/arch/arm/mach-cns3xxx/include/mach/io.h
+++ b/arch/arm/mach-cns3xxx/include/mach/io.h
@@ -9,8 +9,6 @@
 #ifndef __MACH_IO_H
 #define __MACH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 #define __io(a)			__typesafe_io(a)
 #define __mem_pci(a)		(a)
 
diff --git a/arch/arm/mach-davinci/include/mach/io.h b/arch/arm/mach-davinci/include/mach/io.h
index 62b0a90..29a866f 100644
--- a/arch/arm/mach-davinci/include/mach/io.h
+++ b/arch/arm/mach-davinci/include/mach/io.h
@@ -11,8 +11,6 @@
 #ifndef __ASM_ARCH_IO_H
 #define __ASM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 /*
  * We don't actually have real ISA nor PCI buses, but there is so many
  * drivers out there that might just work if we fake them...
diff --git a/arch/arm/mach-dove/include/mach/io.h b/arch/arm/mach-dove/include/mach/io.h
index 3b3e472..eaacc2a 100644
--- a/arch/arm/mach-dove/include/mach/io.h
+++ b/arch/arm/mach-dove/include/mach/io.h
@@ -11,8 +11,6 @@
 
 #include "dove.h"
 
-#define IO_SPACE_LIMIT		0xffffffff
-
 #define __io(a)  ((void __iomem *)(((a) - DOVE_PCIE0_IO_PHYS_BASE) +\
 				   DOVE_PCIE0_IO_VIRT_BASE))
 #define __mem_pci(a)		(a)
diff --git a/arch/arm/mach-ebsa110/include/mach/io.h b/arch/arm/mach-ebsa110/include/mach/io.h
index f68daa6..44679db 100644
--- a/arch/arm/mach-ebsa110/include/mach/io.h
+++ b/arch/arm/mach-ebsa110/include/mach/io.h
@@ -13,8 +13,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffff
-
 u8 __inb8(unsigned int port);
 void __outb8(u8  val, unsigned int port);
 
diff --git a/arch/arm/mach-ep93xx/include/mach/io.h b/arch/arm/mach-ep93xx/include/mach/io.h
index 594b77f..8931f94 100644
--- a/arch/arm/mach-ep93xx/include/mach/io.h
+++ b/arch/arm/mach-ep93xx/include/mach/io.h
@@ -5,8 +5,6 @@
 #ifndef __ASM_MACH_IO_H
 #define __ASM_MACH_IO_H
 
-#define IO_SPACE_LIMIT		0xffffffff
-
 #define __io(p)			__typesafe_io(p)
 #define __mem_pci(p)		(p)
 
diff --git a/arch/arm/mach-footbridge/include/mach/io.h b/arch/arm/mach-footbridge/include/mach/io.h
index 101a4fe..c65ed51 100644
--- a/arch/arm/mach-footbridge/include/mach/io.h
+++ b/arch/arm/mach-footbridge/include/mach/io.h
@@ -17,8 +17,6 @@
 #define PCIO_SIZE		0x00100000
 #define PCIO_BASE		0xff000000
 
-#define IO_SPACE_LIMIT 0xffff
-
 /*
  * Translation of various region addresses to virtual addresses
  */
diff --git a/arch/arm/mach-gemini/include/mach/io.h b/arch/arm/mach-gemini/include/mach/io.h
index c548056..37b2896 100644
--- a/arch/arm/mach-gemini/include/mach/io.h
+++ b/arch/arm/mach-gemini/include/mach/io.h
@@ -10,8 +10,6 @@
 #ifndef __MACH_IO_H
 #define __MACH_IO_H
 
-#define IO_SPACE_LIMIT	0xffffffff
-
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
diff --git a/arch/arm/mach-h720x/include/mach/io.h b/arch/arm/mach-h720x/include/mach/io.h
index 2c8659c..1b2229f 100644
--- a/arch/arm/mach-h720x/include/mach/io.h
+++ b/arch/arm/mach-h720x/include/mach/io.h
@@ -14,8 +14,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
diff --git a/arch/arm/mach-integrator/include/mach/io.h b/arch/arm/mach-integrator/include/mach/io.h
index f21bb54..37beed3 100644
--- a/arch/arm/mach-integrator/include/mach/io.h
+++ b/arch/arm/mach-integrator/include/mach/io.h
@@ -20,8 +20,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffff
-
 /*
  * WARNING: this has to mirror definitions in platform.h
  */
diff --git a/arch/arm/mach-iop13xx/include/mach/io.h b/arch/arm/mach-iop13xx/include/mach/io.h
index a6e0f9e..a9368e6 100644
--- a/arch/arm/mach-iop13xx/include/mach/io.h
+++ b/arch/arm/mach-iop13xx/include/mach/io.h
@@ -19,8 +19,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 #define __io(a) __iop13xx_io(a)
 #define __mem_pci(a) (a)
 #define __mem_isa(a) (a)
diff --git a/arch/arm/mach-iop32x/include/mach/io.h b/arch/arm/mach-iop32x/include/mach/io.h
index 339e585..9ddc4df 100644
--- a/arch/arm/mach-iop32x/include/mach/io.h
+++ b/arch/arm/mach-iop32x/include/mach/io.h
@@ -17,7 +17,6 @@ extern void __iomem *__iop3xx_ioremap(unsigned long cookie, size_t size,
 	unsigned int mtype);
 extern void __iop3xx_iounmap(void __iomem *addr);
 
-#define IO_SPACE_LIMIT		0xffffffff
 #define __io(p)		((void __iomem *)IOP3XX_PCI_IO_PHYS_TO_VIRT(p))
 #define __mem_pci(a)		(a)
 
diff --git a/arch/arm/mach-iop33x/include/mach/io.h b/arch/arm/mach-iop33x/include/mach/io.h
index e99a7ed..9c1341d 100644
--- a/arch/arm/mach-iop33x/include/mach/io.h
+++ b/arch/arm/mach-iop33x/include/mach/io.h
@@ -17,7 +17,6 @@ extern void __iomem *__iop3xx_ioremap(unsigned long cookie, size_t size,
 	unsigned int mtype);
 extern void __iop3xx_iounmap(void __iomem *addr);
 
-#define IO_SPACE_LIMIT		0xffffffff
 #define __io(p)		((void __iomem *)IOP3XX_PCI_IO_PHYS_TO_VIRT(p))
 #define __mem_pci(a)		(a)
 
diff --git a/arch/arm/mach-ixp2000/include/mach/io.h b/arch/arm/mach-ixp2000/include/mach/io.h
index 859e584..e441d97 100644
--- a/arch/arm/mach-ixp2000/include/mach/io.h
+++ b/arch/arm/mach-ixp2000/include/mach/io.h
@@ -17,7 +17,6 @@
 
 #include <mach/hardware.h>
 
-#define IO_SPACE_LIMIT		0xffffffff
 #define __mem_pci(a)		(a)
 
 /*
diff --git a/arch/arm/mach-ixp23xx/include/mach/io.h b/arch/arm/mach-ixp23xx/include/mach/io.h
index fd9ef8e..1e3752d 100644
--- a/arch/arm/mach-ixp23xx/include/mach/io.h
+++ b/arch/arm/mach-ixp23xx/include/mach/io.h
@@ -15,8 +15,6 @@
 #ifndef __ASM_ARCH_IO_H
 #define __ASM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 #define __io(p)		((void __iomem*)((p) + IXP23XX_PCI_IO_VIRT))
 #define __mem_pci(a)	(a)
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index 6ea7e2f..72af996 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -17,8 +17,6 @@
 
 #include <mach/hardware.h>
 
-#define IO_SPACE_LIMIT 0x0000ffff
-
 extern int (*ixp4xx_pci_read)(u32 addr, u32 cmd, u32* data);
 extern int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data);
 
diff --git a/arch/arm/mach-kirkwood/include/mach/io.h b/arch/arm/mach-kirkwood/include/mach/io.h
index 44e8be0..68560bf 100644
--- a/arch/arm/mach-kirkwood/include/mach/io.h
+++ b/arch/arm/mach-kirkwood/include/mach/io.h
@@ -11,8 +11,6 @@
 
 #include "kirkwood.h"
 
-#define IO_SPACE_LIMIT		0xffffffff
-
 static inline void __iomem *__io(unsigned long addr)
 {
 	return (void __iomem *)((addr - KIRKWOOD_PCIE_IO_BUS_BASE)
diff --git a/arch/arm/mach-ks8695/include/mach/io.h b/arch/arm/mach-ks8695/include/mach/io.h
index a7a63ac..1b2e825 100644
--- a/arch/arm/mach-ks8695/include/mach/io.h
+++ b/arch/arm/mach-ks8695/include/mach/io.h
@@ -11,8 +11,6 @@
 #ifndef __ASM_ARCH_IO_H
 #define __ASM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT		0xffffffff
-
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
diff --git a/arch/arm/mach-l7200/include/mach/io.h b/arch/arm/mach-l7200/include/mach/io.h
index a770a89..814c0b3 100644
--- a/arch/arm/mach-l7200/include/mach/io.h
+++ b/arch/arm/mach-l7200/include/mach/io.h
@@ -10,8 +10,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 /*
  * There are not real ISA nor PCI buses, so we fake it.
  */
diff --git a/arch/arm/mach-lh7a40x/include/mach/io.h b/arch/arm/mach-lh7a40x/include/mach/io.h
index 6ece459..f64cde6 100644
--- a/arch/arm/mach-lh7a40x/include/mach/io.h
+++ b/arch/arm/mach-lh7a40x/include/mach/io.h
@@ -11,8 +11,6 @@
 #ifndef __ASM_ARCH_IO_H
 #define __ASM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 /* No ISA or PCI bus on this machine. */
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
diff --git a/arch/arm/mach-loki/include/mach/io.h b/arch/arm/mach-loki/include/mach/io.h
index a373cd5..ea63e33 100644
--- a/arch/arm/mach-loki/include/mach/io.h
+++ b/arch/arm/mach-loki/include/mach/io.h
@@ -11,8 +11,6 @@
 
 #include "loki.h"
 
-#define IO_SPACE_LIMIT		0xffffffff
-
 static inline void __iomem *__io(unsigned long addr)
 {
 	return (void __iomem *)((addr - LOKI_PCIE0_IO_PHYS_BASE)
diff --git a/arch/arm/mach-mmp/include/mach/io.h b/arch/arm/mach-mmp/include/mach/io.h
index e7adf3d..dc24d77 100644
--- a/arch/arm/mach-mmp/include/mach/io.h
+++ b/arch/arm/mach-mmp/include/mach/io.h
@@ -9,8 +9,6 @@
 #ifndef __ASM_MACH_IO_H
 #define __ASM_MACH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 /*
  * We don't actually have real ISA nor PCI buses, but there is so many
  * drivers out there that might just work if we fake them...
diff --git a/arch/arm/mach-msm/include/mach/io.h b/arch/arm/mach-msm/include/mach/io.h
index c35b29f..40698df 100644
--- a/arch/arm/mach-msm/include/mach/io.h
+++ b/arch/arm/mach-msm/include/mach/io.h
@@ -16,8 +16,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 #define __arch_ioremap __msm_ioremap
 #define __arch_iounmap __iounmap
 
diff --git a/arch/arm/mach-mv78xx0/include/mach/io.h b/arch/arm/mach-mv78xx0/include/mach/io.h
index 450e0e1..a92df8c 100644
--- a/arch/arm/mach-mv78xx0/include/mach/io.h
+++ b/arch/arm/mach-mv78xx0/include/mach/io.h
@@ -11,8 +11,6 @@
 
 #include "mv78xx0.h"
 
-#define IO_SPACE_LIMIT		0xffffffff
-
 static inline void __iomem *__io(unsigned long addr)
 {
 	return (void __iomem *)((addr - MV78XX0_PCIE_IO_PHYS_BASE(0))
diff --git a/arch/arm/mach-netx/include/mach/io.h b/arch/arm/mach-netx/include/mach/io.h
index c3921cb..a1b7e23 100644
--- a/arch/arm/mach-netx/include/mach/io.h
+++ b/arch/arm/mach-netx/include/mach/io.h
@@ -20,8 +20,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)            (a)
 
diff --git a/arch/arm/mach-nomadik/include/mach/io.h b/arch/arm/mach-nomadik/include/mach/io.h
index 2e1eca1..d988297 100644
--- a/arch/arm/mach-nomadik/include/mach/io.h
+++ b/arch/arm/mach-nomadik/include/mach/io.h
@@ -10,8 +10,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 /*
  * We don't actually have real ISA nor PCI buses, but there is so many
  * drivers out there that might just work if we fake them...
diff --git a/arch/arm/mach-ns9xxx/include/mach/io.h b/arch/arm/mach-ns9xxx/include/mach/io.h
index f08451d..fb401c9 100644
--- a/arch/arm/mach-ns9xxx/include/mach/io.h
+++ b/arch/arm/mach-ns9xxx/include/mach/io.h
@@ -11,8 +11,6 @@
 #ifndef __ASM_ARCH_IO_H
 #define __ASM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT  0xffffffff /* XXX */
-
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)    (a)
 #define __mem_isa(a)    (IO_BASE + (a))
diff --git a/arch/arm/mach-nuc93x/include/mach/io.h b/arch/arm/mach-nuc93x/include/mach/io.h
index 72e5051..2d0d853 100644
--- a/arch/arm/mach-nuc93x/include/mach/io.h
+++ b/arch/arm/mach-nuc93x/include/mach/io.h
@@ -16,8 +16,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT	0xffffffff
-
 /*
  * 1:1 mapping for ioremapped regions.
  */
diff --git a/arch/arm/mach-orion5x/include/mach/io.h b/arch/arm/mach-orion5x/include/mach/io.h
index c47b033..839b888 100644
--- a/arch/arm/mach-orion5x/include/mach/io.h
+++ b/arch/arm/mach-orion5x/include/mach/io.h
@@ -13,8 +13,6 @@
 
 #include "orion5x.h"
 
-#define IO_SPACE_LIMIT		0xffffffff
-
 static inline void __iomem *
 __arch_ioremap(unsigned long paddr, size_t size, unsigned int mtype)
 {
diff --git a/arch/arm/mach-pnx4008/include/mach/io.h b/arch/arm/mach-pnx4008/include/mach/io.h
index cbf0904..76d5bca 100644
--- a/arch/arm/mach-pnx4008/include/mach/io.h
+++ b/arch/arm/mach-pnx4008/include/mach/io.h
@@ -13,8 +13,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
diff --git a/arch/arm/mach-pxa/include/mach/io.h b/arch/arm/mach-pxa/include/mach/io.h
index 262691f..fedd427 100644
--- a/arch/arm/mach-pxa/include/mach/io.h
+++ b/arch/arm/mach-pxa/include/mach/io.h
@@ -6,8 +6,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 /*
  * We don't actually have real ISA nor PCI buses, but there is so many
  * drivers out there that might just work if we fake them...
diff --git a/arch/arm/mach-realview/include/mach/io.h b/arch/arm/mach-realview/include/mach/io.h
index f05bcdf..2bdf15d 100644
--- a/arch/arm/mach-realview/include/mach/io.h
+++ b/arch/arm/mach-realview/include/mach/io.h
@@ -20,8 +20,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
diff --git a/arch/arm/mach-rpc/include/mach/io.h b/arch/arm/mach-rpc/include/mach/io.h
index 20da7f4..3ccc17d 100644
--- a/arch/arm/mach-rpc/include/mach/io.h
+++ b/arch/arm/mach-rpc/include/mach/io.h
@@ -15,8 +15,6 @@
 
 #include <mach/hardware.h>
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 /*
  * We use two different types of addressing - PC style addresses, and ARM
  * addresses.  PC style accesses the PC hardware with the normal PC IO
diff --git a/arch/arm/mach-s3c2410/include/mach/io.h b/arch/arm/mach-s3c2410/include/mach/io.h
index 9813dbf..d9ba838 100644
--- a/arch/arm/mach-s3c2410/include/mach/io.h
+++ b/arch/arm/mach-s3c2410/include/mach/io.h
@@ -11,8 +11,6 @@
 
 #include <mach/hardware.h>
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 /*
  * We use two different types of addressing - PC style addresses, and ARM
  * addresses.  PC style accesses the PC hardware with the normal PC IO
diff --git a/arch/arm/mach-s3c24a0/include/mach/io.h b/arch/arm/mach-s3c24a0/include/mach/io.h
index 4326c30..4ad89b9 100644
--- a/arch/arm/mach-s3c24a0/include/mach/io.h
+++ b/arch/arm/mach-s3c24a0/include/mach/io.h
@@ -13,6 +13,4 @@
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
-#define IO_SPACE_LIMIT (0xFFFFFFFF)
-
 #endif
diff --git a/arch/arm/mach-s3c64xx/include/mach/io.h b/arch/arm/mach-s3c64xx/include/mach/io.h
index de5716d..1e9625c 100644
--- a/arch/arm/mach-s3c64xx/include/mach/io.h
+++ b/arch/arm/mach-s3c64xx/include/mach/io.h
@@ -13,6 +13,4 @@
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
-#define IO_SPACE_LIMIT (0xFFFFFFFF)
-
 #endif
diff --git a/arch/arm/mach-s5p6440/include/mach/io.h b/arch/arm/mach-s5p6440/include/mach/io.h
index fa2d69c..72611ec 100644
--- a/arch/arm/mach-s5p6440/include/mach/io.h
+++ b/arch/arm/mach-s5p6440/include/mach/io.h
@@ -13,6 +13,4 @@
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
-#define IO_SPACE_LIMIT (0xFFFFFFFF)
-
 #endif
diff --git a/arch/arm/mach-s5p6442/include/mach/io.h b/arch/arm/mach-s5p6442/include/mach/io.h
index 5d2195a..7c1cb7c 100644
--- a/arch/arm/mach-s5p6442/include/mach/io.h
+++ b/arch/arm/mach-s5p6442/include/mach/io.h
@@ -12,6 +12,4 @@
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
-#define IO_SPACE_LIMIT (0xFFFFFFFF)
-
 #endif
diff --git a/arch/arm/mach-s5pc100/include/mach/io.h b/arch/arm/mach-s5pc100/include/mach/io.h
index 819acf5..25a0e92 100644
--- a/arch/arm/mach-s5pc100/include/mach/io.h
+++ b/arch/arm/mach-s5pc100/include/mach/io.h
@@ -13,6 +13,4 @@
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
-#define IO_SPACE_LIMIT (0xFFFFFFFF)
-
 #endif
diff --git a/arch/arm/mach-s5pv210/include/mach/io.h b/arch/arm/mach-s5pv210/include/mach/io.h
index 5ab9d56..32ff10e 100644
--- a/arch/arm/mach-s5pv210/include/mach/io.h
+++ b/arch/arm/mach-s5pv210/include/mach/io.h
@@ -21,6 +21,4 @@
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
-#define IO_SPACE_LIMIT (0xFFFFFFFF)
-
 #endif /* __ASM_ARM_ARCH_IO_H */
diff --git a/arch/arm/mach-sa1100/include/mach/io.h b/arch/arm/mach-sa1100/include/mach/io.h
index d8b43f3..bb1be3f 100644
--- a/arch/arm/mach-sa1100/include/mach/io.h
+++ b/arch/arm/mach-sa1100/include/mach/io.h
@@ -10,8 +10,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 /*
  * We don't actually have real ISA nor PCI buses, but there is so many 
  * drivers out there that might just work if we fake them...
diff --git a/arch/arm/mach-shark/include/mach/io.h b/arch/arm/mach-shark/include/mach/io.h
index 9ccbcec..9e09e10 100644
--- a/arch/arm/mach-shark/include/mach/io.h
+++ b/arch/arm/mach-shark/include/mach/io.h
@@ -11,8 +11,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 #define __io(a)                 ((void __iomem *)(0xe0000000 + (a)))
 
 #define __mem_pci(addr) (addr)
diff --git a/arch/arm/mach-shmobile/include/mach/io.h b/arch/arm/mach-shmobile/include/mach/io.h
index 7339fe4..7b4d896 100644
--- a/arch/arm/mach-shmobile/include/mach/io.h
+++ b/arch/arm/mach-shmobile/include/mach/io.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_MACH_IO_H
 #define __ASM_MACH_IO_H
 
-#define IO_SPACE_LIMIT		0xffffffff
-
 #define __io(a)			((void __iomem *)(a))
 #define __mem_pci(a)		(a)
 
diff --git a/arch/arm/mach-u300/include/mach/io.h b/arch/arm/mach-u300/include/mach/io.h
index 5d6b4c1..49a1ceb 100644
--- a/arch/arm/mach-u300/include/mach/io.h
+++ b/arch/arm/mach-u300/include/mach/io.h
@@ -12,8 +12,6 @@
 #ifndef __MACH_IO_H
 #define __MACH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
diff --git a/arch/arm/mach-ux500/include/mach/io.h b/arch/arm/mach-ux500/include/mach/io.h
index 1cf3f44..03504ff 100644
--- a/arch/arm/mach-ux500/include/mach/io.h
+++ b/arch/arm/mach-ux500/include/mach/io.h
@@ -10,8 +10,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 /*
  * We don't actually have real ISA nor PCI buses, but there is so many
  * drivers out there that might just work if we fake them...
diff --git a/arch/arm/mach-versatile/include/mach/io.h b/arch/arm/mach-versatile/include/mach/io.h
index f067c14..e87fb4a 100644
--- a/arch/arm/mach-versatile/include/mach/io.h
+++ b/arch/arm/mach-versatile/include/mach/io.h
@@ -20,8 +20,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
diff --git a/arch/arm/mach-vexpress/include/mach/io.h b/arch/arm/mach-vexpress/include/mach/io.h
index 748bb52..13522d8 100644
--- a/arch/arm/mach-vexpress/include/mach/io.h
+++ b/arch/arm/mach-vexpress/include/mach/io.h
@@ -20,8 +20,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
diff --git a/arch/arm/mach-w90x900/include/mach/io.h b/arch/arm/mach-w90x900/include/mach/io.h
index d96ab99..062d401 100644
--- a/arch/arm/mach-w90x900/include/mach/io.h
+++ b/arch/arm/mach-w90x900/include/mach/io.h
@@ -18,8 +18,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT	0xffffffff
-
 /*
  * 1:1 mapping for ioremapped regions.
  */
diff --git a/arch/arm/plat-mxc/include/mach/io.h b/arch/arm/plat-mxc/include/mach/io.h
index b4f2de7..18ab5ff 100644
--- a/arch/arm/plat-mxc/include/mach/io.h
+++ b/arch/arm/plat-mxc/include/mach/io.h
@@ -12,8 +12,6 @@
 #define __ASM_ARCH_MXC_IO_H__
 
 /* Allow IO space to be anywhere in the memory */
-#define IO_SPACE_LIMIT 0xffffffff
-
 #ifdef CONFIG_ARCH_MX3
 #define __arch_ioremap __mx3_ioremap
 #define __arch_iounmap __iounmap
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index 128b549..bb3f68f 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -39,8 +39,6 @@
 
 #include <mach/hardware.h>
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 /*
  * We don't actually have real ISA nor PCI buses, but there is so many
  * drivers out there that might just work if we fake them...
diff --git a/arch/arm/plat-spear/include/plat/io.h b/arch/arm/plat-spear/include/plat/io.h
index 4d4ba82..4358221 100644
--- a/arch/arm/plat-spear/include/plat/io.h
+++ b/arch/arm/plat-spear/include/plat/io.h
@@ -14,8 +14,6 @@
 #ifndef __PLAT_IO_H
 #define __PLAT_IO_H
 
-#define IO_SPACE_LIMIT		0xFFFFFFFF
-
 #define __io(a)			__typesafe_io(a)
 #define __mem_pci(a)		(a)
 
diff --git a/arch/arm/plat-stmp3xxx/include/mach/io.h b/arch/arm/plat-stmp3xxx/include/mach/io.h
index d08b1b7..ccf0246 100644
--- a/arch/arm/plat-stmp3xxx/include/mach/io.h
+++ b/arch/arm/plat-stmp3xxx/include/mach/io.h
@@ -16,8 +16,6 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
-
 #define __io(a) 	__typesafe_io(a)
 #define __mem_pci(a)	(a)
 #define __mem_isa(a)	(a)
-- 
1.7.1
