From: baruch@tkos.co.il (Baruch Siach)
Date: Wed,  9 Jun 2010 14:07:00 +0300
Subject: [PATCH 1/3] mx25: add watchdog clock
In-Reply-To: <cover.1276081393.git.baruch@tkos.co.il>
References: <cover.1276081393.git.baruch@tkos.co.il>
Message-ID: <bc8385e0c903851918839a66f9e582a507434e93.1276081393.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-mx25/clock.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index 1550149..f9662d9 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -191,6 +191,7 @@ DEFINE_CLOCK(i2c_clk,	 0, CCM_CGCR0,  6, get_rate_i2c, NULL, NULL);
 DEFINE_CLOCK(fec_clk,	 0, CCM_CGCR1, 15, get_rate_ipg, NULL, &fec_ahb_clk);
 DEFINE_CLOCK(dryice_clk, 0, CCM_CGCR1,  8, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(lcdc_clk,	 0, CCM_CGCR1, 29, get_rate_lcdc, NULL, &lcdc_per_clk);
+DEFINE_CLOCK(wdt_clk,    0, CCM_CGCR1, 19, get_rate_ipg, NULL,  NULL);
 
 #define _REGISTER_CLOCK(d, n, c)	\
 	{				\
@@ -225,6 +226,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK("imxdi_rtc.0", NULL, dryice_clk)
 	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
+	_REGISTER_CLOCK("imx-wdt.0", NULL, wdt_clk)
 };
 
 int __init mx25_clocks_init(void)
-- 
1.7.1
