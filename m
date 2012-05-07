From: chao.xie@marvell.com (Chao Xie)
Date: Mon,  7 May 2012 11:22:22 +0800
Subject: [PATCH V2 1/2] ARM: mmp: move XX_REG definition to addr-map.h
Message-ID: <1336360943-16862-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move APBC_REG, APMU_REG and CIU_REG definition to addr-map.h
driver only need include addr-map.h to get access of the
registers.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mach-mmp/include/mach/addr-map.h  |   12 ++++++++++++
 arch/arm/mach-mmp/include/mach/regs-apbc.h |    3 ---
 arch/arm/mach-mmp/include/mach/regs-apmu.h |    3 ---
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/addr-map.h b/arch/arm/mach-mmp/include/mach/addr-map.h
index b1ece08..f88a44c 100644
--- a/arch/arm/mach-mmp/include/mach/addr-map.h
+++ b/arch/arm/mach-mmp/include/mach/addr-map.h
@@ -31,4 +31,16 @@
 #define SMC_CS1_PHYS_BASE	0x90000000
 #define SMC_CS1_PHYS_SIZE	0x10000000
 
+#define APMU_VIRT_BASE		(AXI_VIRT_BASE + 0x82800)
+#define APMU_REG(x)		(APMU_VIRT_BASE + (x))
+
+#define APBC_VIRT_BASE		(APB_VIRT_BASE + 0x015000)
+#define APBC_REG(x)		(APBC_VIRT_BASE + (x))
+
+#define MPMU_VIRT_BASE		(APB_VIRT_BASE + 0x50000)
+#define MPMU_REG(x)		(MPMU_VIRT_BASE + (x))
+
+#define CIU_VIRT_BASE		(AXI_VIRT_BASE + 0x82c00)
+#define CIU_REG(x)		(CIU_VIRT_BASE + (x))
+
 #endif /* __ASM_MACH_ADDR_MAP_H */
diff --git a/arch/arm/mach-mmp/include/mach/regs-apbc.h b/arch/arm/mach-mmp/include/mach/regs-apbc.h
index 8a37fb0..68b0c93 100644
--- a/arch/arm/mach-mmp/include/mach/regs-apbc.h
+++ b/arch/arm/mach-mmp/include/mach/regs-apbc.h
@@ -13,9 +13,6 @@
 
 #include <mach/addr-map.h>
 
-#define APBC_VIRT_BASE	(APB_VIRT_BASE + 0x015000)
-#define APBC_REG(x)	(APBC_VIRT_BASE + (x))
-
 /*
  * APB clock register offsets for PXA168
  */
diff --git a/arch/arm/mach-mmp/include/mach/regs-apmu.h b/arch/arm/mach-mmp/include/mach/regs-apmu.h
index 8447ac6..7af8deb 100644
--- a/arch/arm/mach-mmp/include/mach/regs-apmu.h
+++ b/arch/arm/mach-mmp/include/mach/regs-apmu.h
@@ -13,9 +13,6 @@
 
 #include <mach/addr-map.h>
 
-#define APMU_VIRT_BASE	(AXI_VIRT_BASE + 0x82800)
-#define APMU_REG(x)	(APMU_VIRT_BASE + (x))
-
 /* Clock Reset Control */
 #define APMU_IRE	APMU_REG(0x048)
 #define APMU_LCD	APMU_REG(0x04c)
-- 
1.7.0.4
