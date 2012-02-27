From: robherring2@gmail.com (Rob Herring)
Date: Mon, 27 Feb 2012 09:17:15 -0600
Subject: [PATCH] ARM: ep93xx: clean-up mach/io.h
In-Reply-To: <1329169408-17253-12-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-12-git-send-email-robherring2@gmail.com>
Message-ID: <1330355835-19174-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move ep93xx specifics in mach/io.h to ep93xx-regs.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    9 +++++++++
 arch/arm/mach-ep93xx/include/mach/io.h          |    9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index c4a7b84..6e0625e 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -25,6 +25,15 @@
  *	http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
  */
 
+/*
+ * A typesafe __io() variation for variable initialisers
+ */
+#ifdef __ASSEMBLER__
+#define IOMEM(p)                p
+#else
+#define IOMEM(p)                ((void __iomem __force *)(p))
+#endif
+
 #define EP93XX_CS0_PHYS_BASE_ASYNC	0x00000000	/* ASDO Pin = 0 */
 #define EP93XX_SDCE3_PHYS_BASE_SYNC	0x00000000	/* ASDO Pin = 1 */
 #define EP93XX_CS1_PHYS_BASE		0x10000000
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
