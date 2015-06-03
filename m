From: vigneshr@ti.com (Vignesh R)
Date: Wed, 3 Jun 2015 17:21:20 +0530
Subject: [PATCH v2 1/5] ARM: OMAP2+: DRA7: clockdomain: change
 l4per2_7xx_clkdm to SW_WKUP
In-Reply-To: <1433332284-10766-1-git-send-email-vigneshr@ti.com>
References: <1433332284-10766-1-git-send-email-vigneshr@ti.com>
Message-ID: <1433332284-10766-2-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Legacy IPs like PWMSS, present under l4per2_7xx_clkdm, cannot support
smart-idle when its clock domain is in HW_AUTO on DRA7 SoCs. Hence,
program clock domain to SW_WKUP.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/mach-omap2/clockdomains7xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-omap2/clockdomains7xx_data.c
index 57d5df0c1fbd..7581e036bda6 100644
--- a/arch/arm/mach-omap2/clockdomains7xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
@@ -331,7 +331,7 @@ static struct clockdomain l4per2_7xx_clkdm = {
 	.dep_bit	  = DRA7XX_L4PER2_STATDEP_SHIFT,
 	.wkdep_srcs	  = l4per2_wkup_sleep_deps,
 	.sleepdep_srcs	  = l4per2_wkup_sleep_deps,
-	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  = CLKDM_CAN_SWSUP,
 };
 
 static struct clockdomain mpu0_7xx_clkdm = {
-- 
2.4.1
