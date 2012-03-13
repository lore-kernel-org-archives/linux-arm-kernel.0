From: lost.distance@yahoo.com (Paul Parsons)
Date: Tue, 13 Mar 2012 13:11:30 +0000 (GMT)
Subject: [PATCH] pxa/hx4700: Remove unwanted request for GPIO105
Message-ID: <1331644290.41945.YahooMailClassic@web29009.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO105 (nIR_ON) is requested twice: first in gpio_request_array(), then in
pxa_irda_probe(). Consequently the second request fails with EBUSY:

pxa2xx-ir: probe of pxa2xx-ir failed with error -16

This patch removes the first request, allowing pxa_irda_probe() to succeed.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---

--- clean-3.3-rc7/arch/arm/mach-pxa/hx4700.c	2012-03-10 21:49:52.000000000 +0000
+++ linux-3.3-rc7/arch/arm/mach-pxa/hx4700.c	2012-03-13 12:55:41.258719320 +0000
@@ -830,7 +830,6 @@ static struct gpio global_gpios[] = {
 	{ GPIO32_HX4700_RS232_ON,         GPIOF_OUT_INIT_HIGH, "RS232_ON" },
 	{ GPIO71_HX4700_ASIC3_nRESET,     GPIOF_OUT_INIT_HIGH, "ASIC3_nRESET" },
 	{ GPIO82_HX4700_EUART_RESET,      GPIOF_OUT_INIT_HIGH, "EUART_RESET" },
-	{ GPIO105_HX4700_nIR_ON,          GPIOF_OUT_INIT_HIGH, "nIR_EN" },
 };
 
 static void __init hx4700_init(void)
