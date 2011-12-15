From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 15 Dec 2011 13:51:17 +0100
Subject: [PATCH 4/5] ux500: update register files
Message-ID: <1323953477-27156-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

A few new addresses for newly supported peripherals and SRAM base
offsets.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/include/mach/db5500-regs.h |    4 ++++
 arch/arm/mach-ux500/include/mach/db8500-regs.h |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/include/mach/db5500-regs.h b/arch/arm/mach-ux500/include/mach/db5500-regs.h
index 994b5fe..8e714bc 100644
--- a/arch/arm/mach-ux500/include/mach/db5500-regs.h
+++ b/arch/arm/mach-ux500/include/mach/db5500-regs.h
@@ -65,8 +65,11 @@
 #define U5500_PRCMU_TIMER_4_BASE (U5500_PER4_BASE + 0x07450)
 #define U5500_MSP1_BASE		(U5500_PER4_BASE + 0x9000)
 #define U5500_GPIO2_BASE	(U5500_PER4_BASE + 0xA000)
+#define U5500_MTIMER_BASE	(U5500_PER4_BASE + 0xC000)
 #define U5500_CDETECT_BASE	(U5500_PER4_BASE + 0xF000)
 #define U5500_PRCMU_TCDM_BASE	(U5500_PER4_BASE + 0x18000)
+#define U5500_PRCMU_TCPM_BASE	(U5500_PER4_BASE + 0x10000)
+#define U5500_TPIU_BASE		(U5500_PER4_BASE + 0x50000)
 
 #define U5500_SPI0_BASE		(U5500_PER5_BASE + 0x0000)
 #define U5500_SPI1_BASE		(U5500_PER5_BASE + 0x1000)
@@ -125,6 +128,7 @@
 #define U5500_ACCCON_BASE		(0xBFFF1000)
 #define U5500_ACCCON_CPUVEC_RESET_ADDR_OFFSET (0x00000020)
 #define U5500_ACCCON_ACC_CPU_CTRL_OFFSET (0x000000BC)
+#define U5500_INTCON_MBOX1_INT_RESET_ADDR	(0xBFFD31A4)
 
 #define U5500_ESRAM_BASE	        0x40000000
 #define U5500_ESRAM_DMA_LCPA_OFFSET	0x10000
diff --git a/arch/arm/mach-ux500/include/mach/db8500-regs.h b/arch/arm/mach-ux500/include/mach/db8500-regs.h
index 751b0e6..8decf18 100644
--- a/arch/arm/mach-ux500/include/mach/db8500-regs.h
+++ b/arch/arm/mach-ux500/include/mach/db8500-regs.h
@@ -24,6 +24,9 @@
 #define U8500_DMA_LCPA_BASE    (U8500_ESRAM_BANK0 + U8500_ESRAM_DMA_LCPA_OFFSET)
 #define U8500_DMA_LCPA_BASE_ED	(U8500_ESRAM_BANK4 + 0x4000)
 
+/* This address fulfills the 256k alignment requirement of the lcla base */
+#define U8500_DMA_LCLA_BASE	U8500_ESRAM_BANK4
+
 #define U8500_PER3_BASE		0x80000000
 #define U8500_STM_BASE		0x80100000
 #define U8500_STM_REG_BASE	(U8500_STM_BASE + 0xF000)
@@ -40,6 +43,7 @@
 #define U8500_ASIC_ID_BASE	0x9001D000
 
 #define U8500_PER6_BASE		0xa03c0000
+#define U8500_PER7_BASE		0xa03d0000
 #define U8500_PER5_BASE		0xa03e0000
 #define U8500_PER7_BASE_ED	0xa03d0000
 
-- 
1.7.3.2
