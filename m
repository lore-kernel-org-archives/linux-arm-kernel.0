From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 14:27:16 +0200
Subject: [PATCH v4 03/17] arm: mach-mv78xx0: use plus instead of or for
 address definitions
In-Reply-To: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1347366450-26644-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we are going to use IOMEM() to define many base virtual
addresses, we can no longer use binary or to define the individual
register addresses ("binary or" arithmetic on pointers is not
allowed). Instead, use the more conventional plus operator to do so.

The binary or operators were actually not useful because the low-order
bits of the base address were always zero, so the usage of the binary
or operators was effectively identical to a plus operator.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h |   12 ++--
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h     |   82 +++++++++++-----------
 2 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h b/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
index eb187e0..5f03484 100644
--- a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
+++ b/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
@@ -11,18 +11,18 @@
 
 #include <mach/mv78xx0.h>
 
-#define CPU_CONTROL		(BRIDGE_VIRT_BASE | 0x0104)
+#define CPU_CONTROL		(BRIDGE_VIRT_BASE + 0x0104)
 #define L2_WRITETHROUGH		0x00020000
 
-#define RSTOUTn_MASK		(BRIDGE_VIRT_BASE | 0x0108)
+#define RSTOUTn_MASK		(BRIDGE_VIRT_BASE + 0x0108)
 #define SOFT_RESET_OUT_EN	0x00000004
 
-#define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE | 0x010c)
+#define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE + 0x010c)
 #define SOFT_RESET		0x00000001
 
 #define BRIDGE_INT_TIMER1_CLR	(~0x0004)
 
-#define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0200)
+#define IRQ_VIRT_BASE		(BRIDGE_VIRT_BASE + 0x0200)
 #define IRQ_CAUSE_ERR_OFF	0x0000
 #define IRQ_CAUSE_LOW_OFF	0x0004
 #define IRQ_CAUSE_HIGH_OFF	0x0008
@@ -30,7 +30,7 @@
 #define IRQ_MASK_LOW_OFF	0x0010
 #define IRQ_MASK_HIGH_OFF	0x0014
 
-#define TIMER_VIRT_BASE		(BRIDGE_VIRT_BASE | 0x0300)
-#define TIMER_PHYS_BASE		(BRIDGE_PHYS_BASE | 0x0300)
+#define TIMER_VIRT_BASE		(BRIDGE_VIRT_BASE + 0x0300)
+#define TIMER_PHYS_BASE		(BRIDGE_PHYS_BASE + 0x0300)
 
 #endif
diff --git a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h b/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
index e807c4c..a86e79e 100644
--- a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
+++ b/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
@@ -65,47 +65,47 @@
 /*
  * Register Map
  */
-#define DDR_VIRT_BASE		(MV78XX0_REGS_VIRT_BASE | 0x00000)
-#define  DDR_WINDOW_CPU0_BASE	(DDR_VIRT_BASE | 0x1500)
-#define  DDR_WINDOW_CPU1_BASE	(DDR_VIRT_BASE | 0x1570)
-
-#define DEV_BUS_PHYS_BASE	(MV78XX0_REGS_PHYS_BASE | 0x10000)
-#define DEV_BUS_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE | 0x10000)
-#define  SAMPLE_AT_RESET_LOW	(DEV_BUS_VIRT_BASE | 0x0030)
-#define  SAMPLE_AT_RESET_HIGH	(DEV_BUS_VIRT_BASE | 0x0034)
-#define  GPIO_VIRT_BASE		(DEV_BUS_VIRT_BASE | 0x0100)
-#define  I2C_0_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x1000)
-#define  I2C_1_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x1100)
-#define  UART0_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x2000)
-#define  UART0_VIRT_BASE	(DEV_BUS_VIRT_BASE | 0x2000)
-#define  UART1_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x2100)
-#define  UART1_VIRT_BASE	(DEV_BUS_VIRT_BASE | 0x2100)
-#define  UART2_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x2200)
-#define  UART2_VIRT_BASE	(DEV_BUS_VIRT_BASE | 0x2200)
-#define  UART3_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x2300)
-#define  UART3_VIRT_BASE	(DEV_BUS_VIRT_BASE | 0x2300)
-
-#define GE10_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE | 0x30000)
-#define GE11_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE | 0x34000)
-
-#define PCIE00_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE | 0x40000)
-#define PCIE01_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE | 0x44000)
-#define PCIE02_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE | 0x48000)
-#define PCIE03_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE | 0x4c000)
-
-#define USB0_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE | 0x50000)
-#define USB1_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE | 0x51000)
-#define USB2_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE | 0x52000)
-
-#define GE00_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE | 0x70000)
-#define GE01_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE | 0x74000)
-
-#define PCIE10_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE | 0x80000)
-#define PCIE11_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE | 0x84000)
-#define PCIE12_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE | 0x88000)
-#define PCIE13_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE | 0x8c000)
-
-#define SATA_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE | 0xa0000)
+#define DDR_VIRT_BASE		(MV78XX0_REGS_VIRT_BASE + 0x00000)
+#define  DDR_WINDOW_CPU0_BASE	(DDR_VIRT_BASE + 0x1500)
+#define  DDR_WINDOW_CPU1_BASE	(DDR_VIRT_BASE + 0x1570)
+
+#define DEV_BUS_PHYS_BASE	(MV78XX0_REGS_PHYS_BASE + 0x10000)
+#define DEV_BUS_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE + 0x10000)
+#define  SAMPLE_AT_RESET_LOW	(DEV_BUS_VIRT_BASE + 0x0030)
+#define  SAMPLE_AT_RESET_HIGH	(DEV_BUS_VIRT_BASE + 0x0034)
+#define  GPIO_VIRT_BASE		(DEV_BUS_VIRT_BASE + 0x0100)
+#define  I2C_0_PHYS_BASE	(DEV_BUS_PHYS_BASE + 0x1000)
+#define  I2C_1_PHYS_BASE	(DEV_BUS_PHYS_BASE + 0x1100)
+#define  UART0_PHYS_BASE	(DEV_BUS_PHYS_BASE + 0x2000)
+#define  UART0_VIRT_BASE	(DEV_BUS_VIRT_BASE + 0x2000)
+#define  UART1_PHYS_BASE	(DEV_BUS_PHYS_BASE + 0x2100)
+#define  UART1_VIRT_BASE	(DEV_BUS_VIRT_BASE + 0x2100)
+#define  UART2_PHYS_BASE	(DEV_BUS_PHYS_BASE + 0x2200)
+#define  UART2_VIRT_BASE	(DEV_BUS_VIRT_BASE + 0x2200)
+#define  UART3_PHYS_BASE	(DEV_BUS_PHYS_BASE + 0x2300)
+#define  UART3_VIRT_BASE	(DEV_BUS_VIRT_BASE + 0x2300)
+
+#define GE10_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE + 0x30000)
+#define GE11_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE + 0x34000)
+
+#define PCIE00_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE + 0x40000)
+#define PCIE01_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE + 0x44000)
+#define PCIE02_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE + 0x48000)
+#define PCIE03_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE + 0x4c000)
+
+#define USB0_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE + 0x50000)
+#define USB1_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE + 0x51000)
+#define USB2_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE + 0x52000)
+
+#define GE00_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE + 0x70000)
+#define GE01_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE + 0x74000)
+
+#define PCIE10_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE + 0x80000)
+#define PCIE11_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE + 0x84000)
+#define PCIE12_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE + 0x88000)
+#define PCIE13_VIRT_BASE	(MV78XX0_REGS_VIRT_BASE + 0x8c000)
+
+#define SATA_PHYS_BASE		(MV78XX0_REGS_PHYS_BASE + 0xa0000)
 
 /*
  * Supported devices and revisions.
-- 
1.7.9.5
