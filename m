From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 28 May 2014 14:56:04 +0530
Subject: [PATCH 1/2] ARM: ux500: Staticize local symbols in cpu-db8500.c
Message-ID: <1401269165-2996-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Symbols local to this file are made static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index fa308f07fae5..6f63954c8bde 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -33,11 +33,11 @@
 #include "db8500-regs.h"
 #include "id.h"
 
-struct ab8500_platform_data ab8500_platdata = {
+static struct ab8500_platform_data ab8500_platdata = {
 	.regulator	= &ab8500_regulator_plat_data,
 };
 
-struct prcmu_pdata db8500_prcmu_pdata = {
+static struct prcmu_pdata db8500_prcmu_pdata = {
 	.ab_platdata	= &ab8500_platdata,
 	.version_offset	= DB8500_PRCMU_FW_VERSION_OFFSET,
 	.legacy_offset	= DB8500_PRCMU_LEGACY_OFFSET,
@@ -82,7 +82,7 @@ static struct map_desc u9540_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_PRCMU_TCDM_BASE, SZ_4K + SZ_8K),
 };
 
-void __init u8500_map_io(void)
+static void __init u8500_map_io(void)
 {
 	/*
 	 * Map the UARTs early so that the DEBUG_LL stuff continues to work.
@@ -119,7 +119,7 @@ static irqreturn_t db8500_pmu_handler(int irq, void *dev, irq_handler_t handler)
 	return ret;
 }
 
-struct arm_pmu_platdata db8500_pmu_platdata = {
+static struct arm_pmu_platdata db8500_pmu_platdata = {
 	.handle_irq		= db8500_pmu_handler,
 };
 
-- 
1.7.9.5
