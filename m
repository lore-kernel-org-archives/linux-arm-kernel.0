From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 Mar 2015 12:08:39 +0100
Subject: [PATCH v4 1/3] ARM: EXYNOS: Add missing static to file-scope
 declarations
Message-ID: <1426072121-6822-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'pm_data', 'exynos_release_ret_regs', 'exynos3250_release_ret_regs'
and 'exynos5420_release_ret_regs' are not exported nor used outside of
suspend.c file. Make them static.

This fixes following sparse warnings:
arch/arm/mach-exynos/suspend.c:83:23: warning: symbol 'pm_data' was not declared. Should it be static?
arch/arm/mach-exynos/suspend.c:106:14: warning: symbol 'exynos_release_ret_regs' was not declared. Should it be static?
arch/arm/mach-exynos/suspend.c:117:14: warning: symbol 'exynos5420_release_ret_regs' was not declared. Should it be static?

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---

Notes:
    Changes since v3:
    1. Add Pankaj's reviewed-by.
    
    Changes since v2:
    None
    
    Changes since v1:
    1. Add static to 'exynos3250_release_ret_regs' (suggested by Kukjin).

 arch/arm/mach-exynos/suspend.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 318d127df147..2fefb7073083 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -75,7 +75,7 @@ struct exynos_pm_data {
 	int (*cpu_suspend)(unsigned long);
 };
 
-struct exynos_pm_data *pm_data;
+static struct exynos_pm_data *pm_data;
 
 static int exynos5420_cpu_state;
 static unsigned int exynos_pmu_spare3;
@@ -104,7 +104,7 @@ static const struct exynos_wkup_irq exynos5250_wkup_irq[] = {
 	{ /* sentinel */ },
 };
 
-unsigned int exynos_release_ret_regs[] = {
+static unsigned int exynos_release_ret_regs[] = {
 	S5P_PAD_RET_MAUDIO_OPTION,
 	S5P_PAD_RET_GPIO_OPTION,
 	S5P_PAD_RET_UART_OPTION,
@@ -115,7 +115,7 @@ unsigned int exynos_release_ret_regs[] = {
 	REG_TABLE_END,
 };
 
-unsigned int exynos3250_release_ret_regs[] = {
+static unsigned int exynos3250_release_ret_regs[] = {
 	S5P_PAD_RET_MAUDIO_OPTION,
 	S5P_PAD_RET_GPIO_OPTION,
 	S5P_PAD_RET_UART_OPTION,
@@ -128,7 +128,7 @@ unsigned int exynos3250_release_ret_regs[] = {
 	REG_TABLE_END,
 };
 
-unsigned int exynos5420_release_ret_regs[] = {
+static unsigned int exynos5420_release_ret_regs[] = {
 	EXYNOS_PAD_RET_DRAM_OPTION,
 	EXYNOS_PAD_RET_MAUDIO_OPTION,
 	EXYNOS_PAD_RET_JTAG_OPTION,
-- 
1.9.1
