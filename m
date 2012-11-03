From: lee.jones@linaro.org (Lee Jones)
Date: Sat,  3 Nov 2012 23:02:22 +0100
Subject: [PATCH 1/9] ARM: integrator: Remove unused icst_params lclk_params
 structure
In-Reply-To: <1351980150-24145-1-git-send-email-lee.jones@linaro.org>
References: <1351980150-24145-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1351980150-24145-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was introduced way back before 2005 and has remained unused for
over 7 years. Let's remove it.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-integrator/cpu.c |   12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-integrator/cpu.c b/arch/arm/mach-integrator/cpu.c
index 590c192..4e0a689 100644
--- a/arch/arm/mach-integrator/cpu.c
+++ b/arch/arm/mach-integrator/cpu.c
@@ -30,18 +30,6 @@ static struct cpufreq_driver integrator_driver;
 #define CM_STAT __io_address(INTEGRATOR_HDR_STAT)
 #define CM_LOCK __io_address(INTEGRATOR_HDR_LOCK)
 
-static const struct icst_params lclk_params = {
-	.ref		= 24000000,
-	.vco_max	= ICST525_VCO_MAX_5V,
-	.vco_min	= ICST525_VCO_MIN,
-	.vd_min		= 8,
-	.vd_max		= 132,
-	.rd_min		= 24,
-	.rd_max		= 24,
-	.s2div		= icst525_s2div,
-	.idx2s		= icst525_idx2s,
-};
-
 static const struct icst_params cclk_params = {
 	.ref		= 24000000,
 	.vco_max	= ICST525_VCO_MAX_5V,
-- 
1.7.9.5
