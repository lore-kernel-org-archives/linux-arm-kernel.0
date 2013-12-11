From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed, 11 Dec 2013 17:29:53 +0530
Subject: [PATCH] ARM: EXYNOS5: Add PMU settings for exynos5420
Message-ID: <1386763193-8573-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add intial PMU settings for exynos5420. This is required for
future S2R and Switching support.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos/include/mach/regs-pmu.h |   82 ++++++++++++++++++++
 arch/arm/mach-exynos/pmu.c                   |  106 ++++++++++++++++++++++++++
 2 files changed, 188 insertions(+)

diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h b/arch/arm/mach-exynos/include/mach/regs-pmu.h
index 2cdb63e..d5d5386 100644
--- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
+++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
@@ -53,6 +53,8 @@
 #define S5P_INFORM6				S5P_PMUREG(0x0818)
 #define S5P_INFORM7				S5P_PMUREG(0x081C)
 
+#define S5P_PMU_SPARE3				S5P_PMUREG(0x090C)
+
 #define S5P_ARM_CORE0_LOWPWR			S5P_PMUREG(0x1000)
 #define S5P_DIS_IRQ_CORE0			S5P_PMUREG(0x1004)
 #define S5P_DIS_IRQ_CENTRAL0			S5P_PMUREG(0x1008)
@@ -365,4 +367,84 @@
 
 #define EXYNOS5_OPTION_USE_RETENTION				(1 << 4)
 
+/* Only for EXYNOS5420 */
+#define EXYNOS5420_LPI_MASK					S5P_PMUREG(0x0004)
+#define EXYNOS5420_LPI_MASK1					S5P_PMUREG(0x0008)
+#define EXYNOS5420_ARM_INTR_SPREAD_ENABLE			S5P_PMUREG(0x0100)
+#define EXYNOS5420_ARM_INTR_SPREAD_USE_STANDBYWFI		S5P_PMUREG(0x0104)
+#define EXYNOS5420_UP_SCHEDULER					S5P_PMUREG(0x0120)
+#define EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG		S5P_PMUREG(0x1490)
+#define EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG			S5P_PMUREG(0x1494)
+#define EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG			S5P_PMUREG(0x1498)
+#define EXYNOS5420_CMU_CLKSTOP_MSC_SYS_PWR_REG			S5P_PMUREG(0x149C)
+#define EXYNOS5420_CMU_CLKSTOP_FSYS_SYS_PWR_REG			S5P_PMUREG(0x14A0)
+#define EXYNOS5420_CMU_CLKSTOP_FSYS2_SYS_PWR_REG		S5P_PMUREG(0x14A4)
+#define EXYNOS5420_CMU_CLKSTOP_PSGEN_SYS_PWR_REG		S5P_PMUREG(0x14A8)
+#define EXYNOS5420_CMU_CLKSTOP_PERIC_SYS_PWR_REG		S5P_PMUREG(0x14AC)
+#define EXYNOS5420_CMU_CLKSTOP_WCORE_SYS_PWR_REG		S5P_PMUREG(0x14B0)
+#define EXYNOS5420_CMU_SYSCLK_TOPPWR_SYS_PWR_REG		S5P_PMUREG(0x14BC)
+#define EXYNOS5420_CMU_SYSCLK_DISP1_SYS_PWR_REG			S5P_PMUREG(0x14D0)
+#define EXYNOS5420_CMU_SYSCLK_MAU_SYS_PWR_REG			S5P_PMUREG(0x14D4)
+#define EXYNOS5420_CMU_SYSCLK_G2D_SYS_PWR_REG			S5P_PMUREG(0x14D8)
+#define EXYNOS5420_CMU_SYSCLK_MSC_SYS_PWR_REG			S5P_PMUREG(0x14DC)
+#define EXYNOS5420_CMU_SYSCLK_FSYS_SYS_PWR_REG			S5P_PMUREG(0x14E0)
+#define EXYNOS5420_CMU_SYSCLK_FSYS2_SYS_PWR_REG			S5P_PMUREG(0x14E4)
+#define EXYNOS5420_CMU_SYSCLK_PSGEN_SYS_PWR_REG			S5P_PMUREG(0x14E8)
+#define EXYNOS5420_CMU_SYSCLK_PERIC_SYS_PWR_REG			S5P_PMUREG(0x14EC)
+#define EXYNOS5420_CMU_SYSCLK_WCORE_SYS_PWR_REG			S5P_PMUREG(0x14F0)
+#define EXYNOS5420_CMU_SYSCLK_SYSMEM_TOPPWR_SYS_PWR_REG		S5P_PMUREG(0x14F4)
+#define EXYNOS5420_CMU_RESET_FSYS2_SYS_PWR_REG			S5P_PMUREG(0x1570)
+#define EXYNOS5420_CMU_RESET_PSGEN_SYS_PWR_REG			S5P_PMUREG(0x1574)
+#define EXYNOS5420_CMU_RESET_PERIC_SYS_PWR_REG			S5P_PMUREG(0x1578)
+#define EXYNOS5420_CMU_RESET_WCORE_SYS_PWR_REG			S5P_PMUREG(0x157C)
+#define EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG			S5P_PMUREG(0x1590)
+#define EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG			S5P_PMUREG(0x1594)
+#define EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG			S5P_PMUREG(0x1598)
+#define EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG			S5P_PMUREG(0x159C)
+#define EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG			S5P_PMUREG(0x15A0)
+#define EXYNOS5420_ARM_COMMON_STATUS				S5P_PMUREG(0x2504)
+#define EXYNOS5420_ARM_COMMON_OPTION				S5P_PMUREG(0x2508)
+#define EXYNOS5420_KFC_COMMON_STATUS				S5P_PMUREG(0x2584)
+#define EXYNOS5420_KFC_COMMON_OPTION				S5P_PMUREG(0x2588)
+#define EXYNOS5420_ARM_L2_OPTION				S5P_PMUREG(0x2608)
+#define EXYNOS5420_KFC_L2_OPTION				S5P_PMUREG(0x2688)
+#define EXYNOS5420_LOGIC_RESET_DURATION3			S5P_PMUREG(0x2D1C)
+
+#define EXYNOS5_XXTI_DURATION3					S5P_PMUREG(0x343C)
+
+/* For EXYNOS_CENTRAL_SEQ_OPTION */
+#define EXYNOS5420_ARM_USE_STANDBY_WFI0				(1 << 4)
+#define EXYNOS5420_ARM_USE_STANDBY_WFI1				(1 << 5)
+#define EXYNOS5420_ARM_USE_STANDBY_WFI2				(1 << 6)
+#define EXYNOS5420_ARM_USE_STANDBY_WFI3				(1 << 7)
+#define EXYNOS5420_KFC_USE_STANDBY_WFI0				(1 << 8)
+#define EXYNOS5420_KFC_USE_STANDBY_WFI1				(1 << 9)
+#define EXYNOS5420_KFC_USE_STANDBY_WFI2				(1 << 10)
+#define EXYNOS5420_KFC_USE_STANDBY_WFI3				(1 << 11)
+#define EXYNOS5420_ARM_USE_STANDBY_WFE0				(1 << 16)
+#define EXYNOS5420_ARM_USE_STANDBY_WFE1				(1 << 17)
+#define EXYNOS5420_ARM_USE_STANDBY_WFE2				(1 << 18)
+#define EXYNOS5420_ARM_USE_STANDBY_WFE3				(1 << 19)
+#define EXYNOS5420_KFC_USE_STANDBY_WFE0				(1 << 20)
+#define EXYNOS5420_KFC_USE_STANDBY_WFE1				(1 << 21)
+#define EXYNOS5420_KFC_USE_STANDBY_WFE2				(1 << 22)
+#define EXYNOS5420_KFC_USE_STANDBY_WFE3				(1 << 23)
+
+#define EXYNOS5420_USE_STANDBY_WFI_ALL				(EXYNOS5420_ARM_USE_STANDBY_WFI0   \
+								| EXYNOS5420_ARM_USE_STANDBY_WFI1  \
+								| EXYNOS5420_ARM_USE_STANDBY_WFI2  \
+								| EXYNOS5420_ARM_USE_STANDBY_WFI3  \
+								| EXYNOS5420_KFC_USE_STANDBY_WFI0  \
+								| EXYNOS5420_KFC_USE_STANDBY_WFI1  \
+								| EXYNOS5420_KFC_USE_STANDBY_WFI2  \
+								| EXYNOS5420_KFC_USE_STANDBY_WFI3)
+
+#define EXYNOS5420_ATB_KFC					(1 << 13)
+#define EXYNOS5420_ATB_ISP_ARM					(1 << 19)
+
+#define DUR_WAIT_RESET						0xF
+#define SPREAD_ENABLE						0xF
+#define SPREAD_USE_STANDWFI					0xF
+#define EXYNOS5420_SWRESET_KFC_SEL				0x3
+
 #endif /* __ASM_ARCH_REGS_PMU_H */
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 97d6885..2dd21bc 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -14,6 +14,7 @@
 #include <linux/bug.h>
 
 #include <mach/regs-clock.h>
+#include <mach/regs-pmu.h>
 
 #include "common.h"
 
@@ -337,6 +338,46 @@ static void __iomem *exynos5_list_diable_wfi_wfe[] = {
 	EXYNOS5_ISP_ARM_OPTION,
 };
 
+void __iomem *exynos5420_list_disable_pmu_reg[] = {
+	EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,
+	EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,
+	EXYNOS5_CMU_CLKSTOP_MFC_SYS_PWR_REG,
+	EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,
+	EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG,
+	EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG,
+	EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG,
+	EXYNOS5420_CMU_CLKSTOP_MSC_SYS_PWR_REG,
+	EXYNOS5420_CMU_CLKSTOP_FSYS_SYS_PWR_REG,
+	EXYNOS5420_CMU_CLKSTOP_PSGEN_SYS_PWR_REG,
+	EXYNOS5420_CMU_CLKSTOP_PERIC_SYS_PWR_REG,
+	EXYNOS5420_CMU_CLKSTOP_WCORE_SYS_PWR_REG,
+	EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,
+	EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,
+	EXYNOS5_CMU_SYSCLK_MFC_SYS_PWR_REG,
+	EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_DISP1_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_MAU_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_G2D_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_MSC_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_FSYS_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_FSYS2_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_PSGEN_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_PERIC_SYS_PWR_REG,
+	EXYNOS5420_CMU_SYSCLK_WCORE_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_FSYS2_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_PSGEN_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_PERIC_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_WCORE_SYS_PWR_REG,
+	EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,
+	EXYNOS5_CMU_RESET_ISP_SYS_PWR_REG,
+	EXYNOS5_CMU_RESET_MFC_SYS_PWR_REG,
+	EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG,
+	EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,
+};
 static void exynos5_init_pmu(void)
 {
 	unsigned int i;
@@ -391,6 +432,7 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 static int __init exynos_pmu_init(void)
 {
 	unsigned int value;
+	unsigned int i;
 
 	exynos_pmu_config = exynos4210_pmu_config;
 
@@ -415,6 +457,70 @@ static int __init exynos_pmu_init(void)
 
 		exynos_pmu_config = exynos5250_pmu_config;
 		pr_info("EXYNOS5250 PMU Initialize\n");
+	} else if (soc_is_exynos5420()) {
+		/*
+		 * Set the CMU_RESET, CMU_SYSCLK and CMU_CLKSTOP registers
+		 * for local power blocks to Low initially as per Table 8-4:
+		 * "System-Level Power-Down Configuration Registers".
+		 */
+		for (i = 0; i < ARRAY_SIZE(exynos5420_list_disable_pmu_reg); i++)
+			__raw_writel(0x0, exynos5420_list_disable_pmu_reg[i]);
+
+		/* Time taken to stabilized XXTI clock */
+		__raw_writel(0x005dc, EXYNOS5_XXTI_DURATION3);
+
+		/* Enable USE_STANDBY_WFI for all CORE */
+		__raw_writel(EXYNOS5420_USE_STANDBY_WFI_ALL,
+				S5P_CENTRAL_SEQ_OPTION);
+
+		value = __raw_readl(EXYNOS5420_ARM_L2_OPTION);
+		value &= ~EXYNOS5_OPTION_USE_RETENTION;
+		__raw_writel(value, EXYNOS5420_ARM_L2_OPTION);
+
+		value = __raw_readl(EXYNOS5420_KFC_L2_OPTION);
+		value &= ~EXYNOS5_OPTION_USE_RETENTION;
+		__raw_writel(value, EXYNOS5420_KFC_L2_OPTION);
+
+		/*
+		 * If L2_COMMON is turned off, clocks related to ATB async
+		 * bridge are gated. Thus, when ISP power is gated, LPI
+		 * may get stuck.
+		 */
+		value = __raw_readl(EXYNOS5420_LPI_MASK);
+		value |= EXYNOS5420_ATB_ISP_ARM;
+		__raw_writel(value, EXYNOS5420_LPI_MASK);
+		value = __raw_readl(EXYNOS5420_LPI_MASK1);
+		value |= EXYNOS5420_ATB_KFC;
+		__raw_writel(value, EXYNOS5420_LPI_MASK1);
+
+		/* Prevent issue of new bus request from L2 memory */
+		value = __raw_readl(EXYNOS5420_ARM_COMMON_OPTION);
+		value |= EXYNOS5_SKIP_DEACTIVATE_ACEACP_IN_PWDN;
+		value &= ~EXYNOS5_USE_SC_COUNTER;
+		value |= EXYNOS5_USE_SC_FEEDBACK;
+		__raw_writel(value, EXYNOS5420_ARM_COMMON_OPTION);
+
+		value = __raw_readl(EXYNOS5420_KFC_COMMON_OPTION);
+		value |= EXYNOS5_SKIP_DEACTIVATE_ACEACP_IN_PWDN;
+		value &= ~EXYNOS5_USE_SC_COUNTER;
+		value |= EXYNOS5_USE_SC_FEEDBACK;
+		__raw_writel(value, EXYNOS5420_KFC_COMMON_OPTION);
+
+		/* Increase stability of KFC Reset */
+		__raw_writel(EXYNOS5420_SWRESET_KFC_SEL, S5P_PMU_SPARE3);
+
+		/*
+		 * This setting is to reduce suspend/resume time.
+		 */
+		__raw_writel(DUR_WAIT_RESET, EXYNOS5420_LOGIC_RESET_DURATION3);
+
+		/* Serialized CPU wakeup of Eagle */
+		__raw_writel(SPREAD_ENABLE, EXYNOS5420_ARM_INTR_SPREAD_ENABLE);
+		__raw_writel(SPREAD_USE_STANDWFI,
+			EXYNOS5420_ARM_INTR_SPREAD_USE_STANDBYWFI);
+		__raw_writel(0x1, EXYNOS5420_UP_SCHEDULER);
+
+		pr_info("EXYNOS5420 PMU Initialized\n");
 	} else {
 		pr_info("EXYNOS: PMU not supported\n");
 	}
-- 
1.7.9.5
