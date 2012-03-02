From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:25 -0600
Subject: [PATCH v3 13/30] ARM: ep93xx: clean-up mach/io.h
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-14-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move ep93xx specifics in mach/io.h to ep93xx-regs.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    9 +++++++++
 arch/arm/mach-ep93xx/include/mach/io.h          |    9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index c4a7b84..e711d0e 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -6,6 +6,15 @@
 #define __ASM_ARCH_EP93XX_REGS_H
 
 /*
+ * A typesafe __io() variation for variable initialisers
+ */
+#ifdef __ASSEMBLER__
+#define IOMEM(p)                p
+#else
+#define IOMEM(p)                ((void __iomem __force *)(p))
+#endif
+
+/*
  * EP93xx Physical Memory Map:
  *
  * The ASDO pin is sampled at system reset to select a synchronous or
diff --git a/arch/arm/mach-ep93xx/include/mach/io.h b/arch/arm/mach-ep93xx/include/mach/io.h
index 594b77f..17e76ef 100644
--- a/arch/arm/mach-ep93xx/include/mach/io.h
+++ b/arch/arm/mach-ep93xx/include/mach/io.h
@@ -10,13 +10,4 @@
 #define __io(p)			__typesafe_io(p)
 #define __mem_pci(p)		(p)
 
-/*
- * A typesafe __io() variation for variable initialisers
- */
-#ifdef __ASSEMBLER__
-#define IOMEM(p)		p
-#else
-#define IOMEM(p)		((void __iomem __force *)(p))
-#endif
-
 #endif /* __ASM_MACH_IO_H */
-- 
1.7.5.4
