From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 12 Dec 2012 15:43:08 -0600
Subject: [RFC 5/5] ARM: OMAP4: Add AMBA APB Clock
In-Reply-To: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1355348588-22318-6-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For OMAP4 devices, ARM AMBA peripherals such as program trace module
(PTM) or cross trigger interface (CTI) require that the DEBUG Sub-system
power and clock domain is turned on. Normally, the OMAP device and HMWOD
frameworks would be used to enable the power and clock domains, but
currently these frameworks only support platform devices and not AMBA
devices. Therefore, add a clock alias for the AMBA APB clock for OMAP4
devices to turn on the DEBUGSS power and clock domain.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/cclock44xx_data.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index aa56c3e..1ac3dc5 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -1940,6 +1940,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("4903c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK("4903e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
+	CLK(NULL,	"apb_pclk",		&trace_clk_div_ck,	CK_443X),
 };
 
 static const char *enable_init_clks[] = {
-- 
1.7.10.4
