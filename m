From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 25 Jan 2017 21:34:51 +0200
Subject: [PATCH 1/2] soc: samsung: pmu: Remove unused and duplicated defines
Message-ID: <20170125193452.31768-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos-regs-pmu.h was never a complete list of PMU registers.  It
contained a lot of holes for registers which are not used.  However, a
lot of unused defines came with porting the code from vendor kernel.

Few of defines were also duplicated.

Remove them so the file will be slightly smaller.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/linux/soc/samsung/exynos-regs-pmu.h | 72 +++--------------------------
 1 file changed, 7 insertions(+), 65 deletions(-)

diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index d30186e2b609..9793502a6a57 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -7,7 +7,13 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
-*/
+ *
+ *
+ * Notice:
+ * This is not a list of all Exynos Power Management Unit SFRs.
+ * There are too many of them, not mentioning subtle differences
+ * between SoCs. For now, put here only the used registers.
+ */
 
 #ifndef __LINUX_SOC_EXYNOS_REGS_PMU_H
 #define __LINUX_SOC_EXYNOS_REGS_PMU_H __FILE__
@@ -38,7 +44,6 @@
 #define EXYNOS_CORE_PO_RESET(n)			((1 << 4) << n)
 #define EXYNOS_WAKEUP_FROM_LOWPWR		(1 << 28)
 #define EXYNOS_SWRESET				0x0400
-#define EXYNOS5440_SWRESET			0x00C4
 
 #define S5P_WAKEUP_STAT				0x0600
 #define S5P_EINT_WAKEUP_MASK			0x0604
@@ -136,12 +141,6 @@
 #define EXYNOS_COMMON_OPTION(_nr)		\
 			(EXYNOS_COMMON_CONFIGURATION(_nr) + 0x8)
 
-#define EXYNOS_CORE_LOCAL_PWR_EN		0x3
-
-#define EXYNOS_ARM_COMMON_STATUS		0x2504
-#define EXYNOS_COMMON_OPTION(_nr)		\
-			(EXYNOS_COMMON_CONFIGURATION(_nr) + 0x8)
-
 #define EXYNOS_ARM_L2_CONFIGURATION		0x2600
 #define EXYNOS_L2_CONFIGURATION(_nr)		\
 			(EXYNOS_ARM_L2_CONFIGURATION + ((_nr) * 0x80))
@@ -149,18 +148,10 @@
 			(EXYNOS_L2_CONFIGURATION(_nr) + 0x4)
 #define EXYNOS_L2_OPTION(_nr)			\
 			(EXYNOS_L2_CONFIGURATION(_nr) + 0x8)
-#define EXYNOS_L2_COMMON_PWR_EN			0x3
-
-#define EXYNOS_ARM_CORE_X_STATUS_OFFSET		0x4
-
-#define EXYNOS5_APLL_SYSCLK_CONFIGURATION	0x2A00
-#define EXYNOS5_APLL_SYSCLK_STATUS		0x2A04
 
 #define EXYNOS5_ARM_L2_OPTION			0x2608
 #define EXYNOS5_USE_RETENTION			BIT(4)
 
-#define EXYNOS5_L2RSTDISABLE_VALUE		BIT(3)
-
 #define S5P_PAD_RET_MAUDIO_OPTION		0x3028
 #define S5P_PAD_RET_MMC2_OPTION			0x30c8
 #define S5P_PAD_RET_GPIO_OPTION			0x3108
@@ -411,7 +402,6 @@
 #define EXYNOS5_SATA_MEM_SYS_PWR_REG				0x11FC
 #define EXYNOS5_PAD_RETENTION_DRAM_SYS_PWR_REG			0x1200
 #define EXYNOS5_PAD_RETENTION_MAU_SYS_PWR_REG			0x1204
-#define EXYNOS5_PAD_RETENTION_EFNAND_SYS_PWR_REG		0x1208
 #define EXYNOS5_PAD_RETENTION_GPIO_SYS_PWR_REG			0x1220
 #define EXYNOS5_PAD_RETENTION_UART_SYS_PWR_REG			0x1224
 #define EXYNOS5_PAD_RETENTION_MMCA_SYS_PWR_REG			0x1228
@@ -485,7 +475,6 @@
 #define EXYNOS5420_SWRESET_KFC_SEL				0x3
 
 /* Only for EXYNOS5420 */
-#define EXYNOS5420_ISP_ARM_OPTION				0x2488
 #define EXYNOS5420_L2RSTDISABLE_VALUE				BIT(3)
 
 #define EXYNOS5420_LPI_MASK					0x0004
@@ -494,9 +483,6 @@
 #define EXYNOS5420_ATB_KFC					BIT(13)
 #define EXYNOS5420_ATB_ISP_ARM					BIT(19)
 #define EXYNOS5420_EMULATION					BIT(31)
-#define ATB_ISP_ARM						BIT(12)
-#define ATB_KFC							BIT(13)
-#define ATB_NOC							BIT(14)
 
 #define EXYNOS5420_ARM_INTR_SPREAD_ENABLE			0x0100
 #define EXYNOS5420_ARM_INTR_SPREAD_USE_STANDBYWFI		0x0104
@@ -510,11 +496,6 @@
 #define EXYNOS5420_KFC_CORE_RESET(_nr)				\
 	((EXYNOS5420_KFC_CORE_RESET0 | EXYNOS5420_KFC_ETM_RESET0) << (_nr))
 
-#define EXYNOS5420_BB_CON1					0x0784
-#define EXYNOS5420_BB_SEL_EN					BIT(31)
-#define EXYNOS5420_BB_PMOS_EN					BIT(7)
-#define EXYNOS5420_BB_1300X					0XF
-
 #define EXYNOS5420_ARM_CORE2_SYS_PWR_REG			0x1020
 #define EXYNOS5420_DIS_IRQ_ARM_CORE2_LOCAL_SYS_PWR_REG		0x1024
 #define EXYNOS5420_DIS_IRQ_ARM_CORE2_CENTRAL_SYS_PWR_REG	0x1028
@@ -546,15 +527,6 @@
 #define EXYNOS5420_SPLL_SYSCLK_SYS_PWR_REG                      0x1178
 #define EXYNOS5420_INTRAM_MEM_SYS_PWR_REG                       0x11B8
 #define EXYNOS5420_INTROM_MEM_SYS_PWR_REG                       0x11BC
-#define EXYNOS5420_ONENANDXL_MEM_SYS_PWR			0x11C0
-#define EXYNOS5420_USBDEV_MEM_SYS_PWR				0x11CC
-#define EXYNOS5420_USBDEV1_MEM_SYS_PWR				0x11D0
-#define EXYNOS5420_SDMMC_MEM_SYS_PWR				0x11D4
-#define EXYNOS5420_CSSYS_MEM_SYS_PWR				0x11D8
-#define EXYNOS5420_SECSS_MEM_SYS_PWR				0x11DC
-#define EXYNOS5420_ROTATOR_MEM_SYS_PWR				0x11E0
-#define EXYNOS5420_INTRAM_MEM_SYS_PWR				0x11E4
-#define EXYNOS5420_INTROM_MEM_SYS_PWR				0x11E8
 #define EXYNOS5420_PAD_RETENTION_JTAG_SYS_PWR_REG		0x1208
 #define EXYNOS5420_PAD_RETENTION_DRAM_SYS_PWR_REG		0x1210
 #define EXYNOS5420_PAD_RETENTION_UART_SYS_PWR_REG		0x1214
@@ -605,13 +577,7 @@
 #define EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG			0x159C
 #define EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG			0x15A0
 #define EXYNOS5420_SFR_AXI_CGDIS1				0x15E4
-#define EXYNOS_ARM_CORE2_CONFIGURATION				0x2100
-#define EXYNOS5420_ARM_CORE2_OPTION				0x2108
-#define EXYNOS_ARM_CORE3_CONFIGURATION				0x2180
-#define EXYNOS5420_ARM_CORE3_OPTION				0x2188
-#define EXYNOS5420_ARM_COMMON_STATUS				0x2504
 #define EXYNOS5420_ARM_COMMON_OPTION				0x2508
-#define EXYNOS5420_KFC_COMMON_STATUS				0x2584
 #define EXYNOS5420_KFC_COMMON_OPTION				0x2588
 #define EXYNOS5420_LOGIC_RESET_DURATION3			0x2D1C
 
@@ -626,33 +592,9 @@
 #define EXYNOS_PAD_RET_DRAM_OPTION				0x3008
 #define EXYNOS_PAD_RET_MAUDIO_OPTION				0x3028
 #define EXYNOS_PAD_RET_JTAG_OPTION				0x3048
-#define EXYNOS_PAD_RET_GPIO_OPTION				0x3108
-#define EXYNOS_PAD_RET_UART_OPTION				0x3128
-#define EXYNOS_PAD_RET_MMCA_OPTION				0x3148
-#define EXYNOS_PAD_RET_MMCB_OPTION				0x3168
 #define EXYNOS_PAD_RET_EBIA_OPTION				0x3188
 #define EXYNOS_PAD_RET_EBIB_OPTION				0x31A8
 
-#define EXYNOS_PS_HOLD_CONTROL					0x330C
-
-/* For SYS_PWR_REG */
-#define EXYNOS_SYS_PWR_CFG					BIT(0)
-
-#define EXYNOS5420_MFC_CONFIGURATION				0x4060
-#define EXYNOS5420_MFC_STATUS					0x4064
-#define EXYNOS5420_MFC_OPTION					0x4068
-#define EXYNOS5420_G3D_CONFIGURATION				0x4080
-#define EXYNOS5420_G3D_STATUS					0x4084
-#define EXYNOS5420_G3D_OPTION					0x4088
-#define EXYNOS5420_DISP0_CONFIGURATION				0x40A0
-#define EXYNOS5420_DISP0_STATUS					0x40A4
-#define EXYNOS5420_DISP0_OPTION					0x40A8
-#define EXYNOS5420_DISP1_CONFIGURATION				0x40C0
-#define EXYNOS5420_DISP1_STATUS					0x40C4
-#define EXYNOS5420_DISP1_OPTION					0x40C8
-#define EXYNOS5420_MAU_CONFIGURATION				0x40E0
-#define EXYNOS5420_MAU_STATUS					0x40E4
-#define EXYNOS5420_MAU_OPTION					0x40E8
 #define EXYNOS5420_FSYS2_OPTION					0x4168
 #define EXYNOS5420_PSGEN_OPTION					0x4188
 
-- 
2.9.3
