From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 10 Jun 2010 12:32:15 +0300
Subject: [PATCH] mx25: add watchdog clock
In-Reply-To: <20100610081042.GB5333@pengutronix.de>
References: <20100610081042.GB5333@pengutronix.de>
Message-ID: <943ad2932e83e0734e445d0258dd1efa4a60f44b.1276162295.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-mx25/clock.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index 1550149..6342840 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -191,6 +191,7 @@ DEFINE_CLOCK(i2c_clk,	 0, CCM_CGCR0,  6, get_rate_i2c, NULL, NULL);
 DEFINE_CLOCK(fec_clk,	 0, CCM_CGCR1, 15, get_rate_ipg, NULL, &fec_ahb_clk);
 DEFINE_CLOCK(dryice_clk, 0, CCM_CGCR1,  8, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(lcdc_clk,	 0, CCM_CGCR1, 29, get_rate_lcdc, NULL, &lcdc_per_clk);
+DEFINE_CLOCK(wdt_clk,    0, CCM_CGCR2, 19, get_rate_ipg, NULL,  NULL);
 
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
