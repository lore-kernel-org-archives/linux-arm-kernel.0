From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 22 Jan 2010 08:46:13 +0100
Subject: [PATCH 1/2] i.MX25: Allow secondary clocks in DEFINE_CLOCK
Message-ID: <mailman.160.1264147130.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx25/clock.c |   41 +++++++++++++++++++++--------------------
 1 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index 6e838b8..fbe42d2 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -144,7 +144,7 @@ static void clk_cgcr_disable(struct clk *clk)
 	__raw_writel(reg, clk->enable_reg);
 }
 
-#define DEFINE_CLOCK(name, i, er, es, gr, sr)		\
+#define DEFINE_CLOCK(name, i, er, es, gr, sr, s)	\
 	static struct clk name = {			\
 		.id		= i,			\
 		.enable_reg	= CRM_BASE + er,	\
@@ -153,27 +153,28 @@ static void clk_cgcr_disable(struct clk *clk)
 		.set_rate	= sr,			\
 		.enable		= clk_cgcr_enable,	\
 		.disable	= clk_cgcr_disable,	\
+		.secondary	= s,			\
 	}
 
-DEFINE_CLOCK(gpt_clk,    0, CCM_CGCR0,  5, get_rate_ipg, NULL);
-DEFINE_CLOCK(cspi1_clk,  0, CCM_CGCR1,  5, get_rate_ipg, NULL);
-DEFINE_CLOCK(cspi2_clk,  0, CCM_CGCR1,  6, get_rate_ipg, NULL);
-DEFINE_CLOCK(cspi3_clk,  0, CCM_CGCR1,  7, get_rate_ipg, NULL);
-DEFINE_CLOCK(uart1_clk,  0, CCM_CGCR2, 14, get_rate_uart, NULL);
-DEFINE_CLOCK(uart2_clk,  0, CCM_CGCR2, 15, get_rate_uart, NULL);
-DEFINE_CLOCK(uart3_clk,  0, CCM_CGCR2, 16, get_rate_uart, NULL);
-DEFINE_CLOCK(uart4_clk,  0, CCM_CGCR2, 17, get_rate_uart, NULL);
-DEFINE_CLOCK(uart5_clk,  0, CCM_CGCR2, 18, get_rate_uart, NULL);
-DEFINE_CLOCK(nfc_clk,    0, CCM_CGCR0,  8, get_rate_nfc, NULL);
-DEFINE_CLOCK(usbotg_clk, 0, CCM_CGCR0, 28, get_rate_otg, NULL);
-DEFINE_CLOCK(pwm1_clk,	 0, CCM_CGCR1, 31, get_rate_ipg, NULL);
-DEFINE_CLOCK(pwm2_clk,	 0, CCM_CGCR2,  0, get_rate_ipg, NULL);
-DEFINE_CLOCK(pwm3_clk,	 0, CCM_CGCR2,  1, get_rate_ipg, NULL);
-DEFINE_CLOCK(pwm4_clk,	 0, CCM_CGCR2,  2, get_rate_ipg, NULL);
-DEFINE_CLOCK(kpp_clk,	 0, CCM_CGCR1, 28, get_rate_ipg, NULL);
-DEFINE_CLOCK(tsc_clk,	 0, CCM_CGCR2, 13, get_rate_ipg, NULL);
-DEFINE_CLOCK(i2c_clk,	 0, CCM_CGCR0,  6, get_rate_i2c, NULL);
-DEFINE_CLOCK(fec_clk,	 0, CCM_CGCR0, 23, get_rate_ipg, NULL);
+DEFINE_CLOCK(gpt_clk,    0, CCM_CGCR0,  5, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(cspi1_clk,  0, CCM_CGCR1,  5, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(cspi2_clk,  0, CCM_CGCR1,  6, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(cspi3_clk,  0, CCM_CGCR1,  7, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(uart1_clk,  0, CCM_CGCR2, 14, get_rate_uart, NULL, NULL);
+DEFINE_CLOCK(uart2_clk,  0, CCM_CGCR2, 15, get_rate_uart, NULL, NULL);
+DEFINE_CLOCK(uart3_clk,  0, CCM_CGCR2, 16, get_rate_uart, NULL, NULL);
+DEFINE_CLOCK(uart4_clk,  0, CCM_CGCR2, 17, get_rate_uart, NULL, NULL);
+DEFINE_CLOCK(uart5_clk,  0, CCM_CGCR2, 18, get_rate_uart, NULL, NULL);
+DEFINE_CLOCK(nfc_clk,    0, CCM_CGCR0,  8, get_rate_nfc, NULL, NULL);
+DEFINE_CLOCK(usbotg_clk, 0, CCM_CGCR0, 28, get_rate_otg, NULL, NULL);
+DEFINE_CLOCK(pwm1_clk,	 0, CCM_CGCR1, 31, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(pwm2_clk,	 0, CCM_CGCR2,  0, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(pwm3_clk,	 0, CCM_CGCR2,  1, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(pwm4_clk,	 0, CCM_CGCR2,  2, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(kpp_clk,	 0, CCM_CGCR1, 28, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(tsc_clk,	 0, CCM_CGCR2, 13, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(i2c_clk,	 0, CCM_CGCR0,  6, get_rate_i2c, NULL, NULL);
+DEFINE_CLOCK(fec_clk,	 0, CCM_CGCR0, 23, get_rate_ipg, NULL, NULL);
 
 #define _REGISTER_CLOCK(d, n, c)	\
 	{				\
-- 
1.6.6

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
