From: anilkumar@ti.com (AnilKumar Ch)
Date: Thu, 20 Sep 2012 02:49:28 +0530
Subject: [PATCH RESEND 3/5] ARM: OMAP2+: AM33XX: Add clock entries to omap_clk
 data
In-Reply-To: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
References: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
Message-ID: <1348089570-16161-4-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add AM335x cpu0 clock entry to the corresponding clock data
file. This is useful in getting the correct mpu clock pointer
to change the cpu frequency in cpufreq driver.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/mach-omap2/clock33xx_data.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
index a4006b2..4933993 100644
--- a/arch/arm/mach-omap2/clock33xx_data.c
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -1013,6 +1013,7 @@ static struct omap_clk am33xx_clks[] = {
 	CLK(NULL,	"dpll_core_m5_ck",	&dpll_core_m5_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_core_m6_ck",	&dpll_core_m6_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_mpu_ck",		&dpll_mpu_ck,	CK_AM33XX),
+	CLK("cpu0",	NULL,			&dpll_mpu_ck,		CK_AM33XX),
 	CLK(NULL,	"dpll_mpu_m2_ck",	&dpll_mpu_m2_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_ddr_ck",		&dpll_ddr_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_ddr_m2_ck",	&dpll_ddr_m2_ck,	CK_AM33XX),
-- 
1.7.9.5
