From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 3 Feb 2011 12:04:03 +0100
Subject: [PATCH] OMAP4: clockdomain: Fix the CPUx domain name
Message-ID: <mailman.136.1296737494.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The register naming convention for module control inside clock domain is: OMAPXXXX_<partition>_<clock_domain>_<module>_CDOFFS

Both CPU0 and CPU1 use MPU as module name instead of CPU0 and CPU1.

Change the name to stick to the convention.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomains44xx_data.c |    4 ++--
 arch/arm/mach-omap2/prcm_mpu44xx.h          |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 51920fc..db1f442 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -152,7 +152,7 @@ static struct clockdomain mpu0_44xx_clkdm = {
 	.pwrdm		  = { .name = "cpu0_pwrdm" },
 	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
 	.cm_inst	  = OMAP4430_PRCM_MPU_CPU0_INST,
-	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU0_MPU_CDOFFS,
+	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU0_CPU0_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -162,7 +162,7 @@ static struct clockdomain mpu1_44xx_clkdm = {
 	.pwrdm		  = { .name = "cpu1_pwrdm" },
 	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
 	.cm_inst	  = OMAP4430_PRCM_MPU_CPU1_INST,
-	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU1_MPU_CDOFFS,
+	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU1_CPU1_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.h b/arch/arm/mach-omap2/prcm_mpu44xx.h
index 3300ff6..d22d1b4 100644
--- a/arch/arm/mach-omap2/prcm_mpu44xx.h
+++ b/arch/arm/mach-omap2/prcm_mpu44xx.h
@@ -38,8 +38,8 @@
 #define OMAP4430_PRCM_MPU_CPU1_INST		0x0800
 
 /* PRCM_MPU clockdomain register offsets (from instance start) */
-#define OMAP4430_PRCM_MPU_CPU0_MPU_CDOFFS	0x0018
-#define OMAP4430_PRCM_MPU_CPU1_MPU_CDOFFS	0x0018
+#define OMAP4430_PRCM_MPU_CPU0_CPU0_CDOFFS	0x0018
+#define OMAP4430_PRCM_MPU_CPU1_CPU1_CDOFFS	0x0018
 
 
 /*
-- 
1.7.0.4
