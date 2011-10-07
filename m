From: colin.tuckley@arm.com (Colin Tuckley)
Date: Fri, 07 Oct 2011 15:27:47 +0100
Subject: [PATCH 1/5 v4] ARM Realview PCIX map include file changes
In-Reply-To: <20111007142310.19554.17204.stgit@e102602-lin.cambridge.arm.com>
References: <20111007142310.19554.17204.stgit@e102602-lin.cambridge.arm.com>
Message-ID: <20111007142723.19554.88566.stgit@e102602-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the memory map PCI support to the include
files for the Realview Northbridge based boards.

Signed-off-by: Colin Tuckley <colin.tuckley@arm.com>
---

 arch/arm/mach-realview/include/mach/board-pb11mp.h |   11 ----------
 arch/arm/mach-realview/include/mach/board-pba8.h   |   11 ----------
 arch/arm/mach-realview/include/mach/board-pbx.h    |   11 ----------
 arch/arm/mach-realview/include/mach/hardware.h     |   22 +++++++++++++++++++-
 arch/arm/mach-realview/include/mach/io.h           |    8 +++++--
 arch/arm/mach-realview/include/mach/platform.h     |   15 ++------------
 6 files changed, 29 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-realview/include/mach/board-pb11mp.h b/arch/arm/mach-realview/include/mach/board-pb11mp.h
index 7abf918..0114edb 100644
--- a/arch/arm/mach-realview/include/mach/board-pb11mp.h
+++ b/arch/arm/mach-realview/include/mach/board-pb11mp.h
@@ -62,17 +62,6 @@
 #define REALVIEW_PB11MP_SYS_PLD_CTRL1		0x74
 
 /*
- * PB11MPCore PCI regions
- */
-#define REALVIEW_PB11MP_PCI_BASE		0x90040000	/* PCI-X Unit base */
-#define REALVIEW_PB11MP_PCI_IO_BASE		0x90050000	/* IO Region on AHB */
-#define REALVIEW_PB11MP_PCI_MEM_BASE		0xA0000000	/* MEM Region on AHB */
-
-#define REALVIEW_PB11MP_PCI_BASE_SIZE		0x10000		/* 16 Kb */
-#define REALVIEW_PB11MP_PCI_IO_SIZE		0x1000		/* 4 Kb */
-#define REALVIEW_PB11MP_PCI_MEM_SIZE		0x20000000	/* 512 MB */
-
-/*
  * Testchip peripheral and fpga gic regions
  */
 #define REALVIEW_TC11MP_SCU_BASE		0x1F000000	/* IRQ, Test chip */
diff --git a/arch/arm/mach-realview/include/mach/board-pba8.h b/arch/arm/mach-realview/include/mach/board-pba8.h
index 4dfc67a..f8ad328 100644
--- a/arch/arm/mach-realview/include/mach/board-pba8.h
+++ b/arch/arm/mach-realview/include/mach/board-pba8.h
@@ -59,15 +59,4 @@
 
 #define REALVIEW_PBA8_SYS_PLD_CTRL1		0x74
 
-/*
- * PBA8 PCI regions
- */
-#define REALVIEW_PBA8_PCI_BASE			0x90040000	/* PCI-X Unit base */
-#define REALVIEW_PBA8_PCI_IO_BASE		0x90050000	/* IO Region on AHB */
-#define REALVIEW_PBA8_PCI_MEM_BASE		0xA0000000	/* MEM Region on AHB */
-
-#define REALVIEW_PBA8_PCI_BASE_SIZE		0x10000		/* 16 Kb */
-#define REALVIEW_PBA8_PCI_IO_SIZE		0x1000		/* 4 Kb */
-#define REALVIEW_PBA8_PCI_MEM_SIZE		0x20000000	/* 512 MB */
-
 #endif	/* __ASM_ARCH_BOARD_PBA8_H */
diff --git a/arch/arm/mach-realview/include/mach/board-pbx.h b/arch/arm/mach-realview/include/mach/board-pbx.h
index 848bfff..93a975e 100644
--- a/arch/arm/mach-realview/include/mach/board-pbx.h
+++ b/arch/arm/mach-realview/include/mach/board-pbx.h
@@ -70,17 +70,6 @@
 #define REALVIEW_PBX_SYS_PLD_CTRL1		0x74
 
 /*
- * PBX PCI regions
- */
-#define REALVIEW_PBX_PCI_BASE			0x90040000	/* PCI-X Unit base */
-#define REALVIEW_PBX_PCI_IO_BASE		0x90050000	/* IO Region on AHB */
-#define REALVIEW_PBX_PCI_MEM_BASE		0xA0000000	/* MEM Region on AHB */
-
-#define REALVIEW_PBX_PCI_BASE_SIZE		0x10000		/* 16 Kb */
-#define REALVIEW_PBX_PCI_IO_SIZE		0x1000		/* 4 Kb */
-#define REALVIEW_PBX_PCI_MEM_SIZE		0x20000000	/* 512 MB */
-
-/*
  * Core tile identification (REALVIEW_SYS_PROCID)
  */
 #define REALVIEW_PBX_PROC_MASK          0xFF000000
diff --git a/arch/arm/mach-realview/include/mach/hardware.h b/arch/arm/mach-realview/include/mach/hardware.h
index 8a638d1..d7d01f2 100644
--- a/arch/arm/mach-realview/include/mach/hardware.h
+++ b/arch/arm/mach-realview/include/mach/hardware.h
@@ -24,6 +24,26 @@
 
 #include <asm/sizes.h>
 
+/*
+ * PCI space virtual addresses
+ */
+#define REALVIEW_PCI_VIRT_BASE		(void __iomem *)0xF8000000ul
+#define REALVIEW_PCI_CFG_VIRT_BASE	(void __iomem *)0xF9000000ul
+#define PCIX_UNIT_BASE			(void __iomem *)0xF8000000ul
+#define REALVIEW_PCI_IO_VBASE		(void __iomem *)0xFA000000ul
+/*
+ * PCI space physical addresses and sizes
+ */
+#define REALVIEW_PB_PCI_BASE		0x90040000	/* PCI-X Unit base */
+#define REALVIEW_PB_PCI_BASE_SIZE	0x00010000	/* 4 Kb + 60Kb reserved */
+#define REALVIEW_PB_PCI_IO_BASE		0x90050000	/* IO Region on AHB */
+#define REALVIEW_PB_PCI_IO_SIZE		0x00010000	/* 64 Kb */
+#define REALVIEW_PB_PCI_IO_LIMIT       (REALVIEW_PB_PCI_IO_BASE + REALVIEW_PB_PCI_IO_SIZE - 1)
+#define REALVIEW_PB_PCI_MEM_BASE	0xA0000000	/* MEM Region on AHB */
+#define REALVIEW_PB_PCI_MEM_SIZE	0x20000000	/* 512 MB */
+
+#define REALVIEW_ISSP_REG_BASE		0x100E3000
+
 /* macro to get at IO space when running virtually */
 #ifdef CONFIG_MMU
 /*
@@ -37,6 +57,6 @@
 #else
 #define IO_ADDRESS(x)		(x)
 #endif
-#define __io_address(n)		__io(IO_ADDRESS(n))
+#define __io_address(n)		__typesafe_io(IO_ADDRESS(n))
 
 #endif
diff --git a/arch/arm/mach-realview/include/mach/io.h b/arch/arm/mach-realview/include/mach/io.h
index f05bcdf..016f294 100644
--- a/arch/arm/mach-realview/include/mach/io.h
+++ b/arch/arm/mach-realview/include/mach/io.h
@@ -20,9 +20,13 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+
+#define IO_SPACE_LIMIT 0x0000ffff
+
+#define __io(a)  (REALVIEW_PCI_IO_VBASE + (a  & IO_SPACE_LIMIT))
 
-#define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
 #endif
diff --git a/arch/arm/mach-realview/include/mach/platform.h b/arch/arm/mach-realview/include/mach/platform.h
index 1b77a27..75bddc4 100644
--- a/arch/arm/mach-realview/include/mach/platform.h
+++ b/arch/arm/mach-realview/include/mach/platform.h
@@ -77,6 +77,7 @@
 #define REALVIEW_SYS_BOOTCS_OFFSET           0x58
 #define REALVIEW_SYS_24MHz_OFFSET            0x5C
 #define REALVIEW_SYS_MISC_OFFSET             0x60
+#define REALVIEW_SYS_PCI_STAT_OFFSET	     0x6C
 #define REALVIEW_SYS_IOSEL_OFFSET            0x70
 #define REALVIEW_SYS_PROCID_OFFSET           0x84
 #define REALVIEW_SYS_TEST_OSC0_OFFSET        0xC0
@@ -111,6 +112,7 @@
 #define REALVIEW_SYS_BOOTCS                  (REALVIEW_SYS_BASE + REALVIEW_SYS_BOOTCS_OFFSET)
 #define REALVIEW_SYS_24MHz                   (REALVIEW_SYS_BASE + REALVIEW_SYS_24MHz_OFFSET)
 #define REALVIEW_SYS_MISC                    (REALVIEW_SYS_BASE + REALVIEW_SYS_MISC_OFFSET)
+#define REALVIEW_SYS_PCI_STAT		     (REALVIEW_SYS_BASE + REALVIEW_SYS_PCI_STAT_OFFSET)
 #define REALVIEW_SYS_IOSEL                   (REALVIEW_SYS_BASE + REALVIEW_SYS_IOSEL_OFFSET)
 #define REALVIEW_SYS_PROCID                  (REALVIEW_SYS_BASE + REALVIEW_SYS_PROCID_OFFSET)
 #define REALVIEW_SYS_TEST_OSC0               (REALVIEW_SYS_BASE + REALVIEW_SYS_TEST_OSC0_OFFSET)
@@ -174,19 +176,6 @@
 #define REALVIEW_DMC_BASE             0x10018000	/* DMC configuration */
 #define REALVIEW_DMAC_BASE            0x10030000	/* DMA controller */
 
-/* PCI space */
-#define REALVIEW_PCI_BASE             0x41000000	/* PCI Interface */
-#define REALVIEW_PCI_CFG_BASE	      0x42000000
-#define REALVIEW_PCI_MEM_BASE0        0x44000000
-#define REALVIEW_PCI_MEM_BASE1        0x50000000
-#define REALVIEW_PCI_MEM_BASE2        0x60000000
-/* Sizes of above maps */
-#define REALVIEW_PCI_BASE_SIZE	       0x01000000
-#define REALVIEW_PCI_CFG_BASE_SIZE    0x02000000
-#define REALVIEW_PCI_MEM_BASE0_SIZE   0x0c000000	/* 32Mb */
-#define REALVIEW_PCI_MEM_BASE1_SIZE   0x10000000	/* 256Mb */
-#define REALVIEW_PCI_MEM_BASE2_SIZE   0x10000000	/* 256Mb */
-
 #define REALVIEW_SDRAM67_BASE         0x70000000	/* SDRAM banks 6 and 7 */
 #define REALVIEW_LT_BASE              0x80000000	/* Logic Tile expansion */
 
