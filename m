From: jiri.prchal@aksignal.cz (=?UTF-8?B?UHJjaGFsIEppxZnDrQ==?=)
Date: Wed, 20 Jun 2012 10:36:47 +0200
Subject: [PATCH]  clock: at91: fix PLLA overclocked warning
Message-ID: <4FE18B9F.1060409@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix false warning "PLLA overclocked". Maximum frequency for sam9260 is 210MHz as stated in atmel's datasheet. 
Originally there was plus 4.5%, so add this 4.5% to new value too.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---

--- linux/linux-3.5-rc3/arch/arm/mach-at91/clock.c.orig	2012-06-17 02:25:17.000000000 +0200
+++ linux/linux-3.5-rc3/arch/arm/mach-at91/clock.c	2012-06-20 10:26:34.076174379 +0200
@@ -707,7 +707,7 @@ static int __init at91_pmc_init(unsigned
  		if (plla.rate_hz > 800000000)
  			pll_overclock = true;
  	} else {
-		if (plla.rate_hz > 209000000)
+		if (plla.rate_hz > 219000000)
  			pll_overclock = true;
  	}
  	if (pll_overclock)
