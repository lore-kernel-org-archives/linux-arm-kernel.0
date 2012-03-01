From: lost.distance@yahoo.com (Paul Parsons)
Date: Thu, 1 Mar 2012 01:23:56 +0000 (GMT)
Subject: Linux 3.3-rc5 and pxa-gpio possible regression
In-Reply-To: <87wr75tghv.fsf@free.fr>
Message-ID: <1330565036.86950.YahooMailClassic@web29009.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I've tried the 3.3-rc5 kernel and my boot hangs (PXA270
> platform).

Same here. Your problem may be the same as this:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/084307.html

Does the patch below fix your problem?

diff -uprN clean-3.3-rc5/arch/arm/mach-pxa/pxa25x.c linux-3.3-rc5/arch/arm/mach-pxa/pxa25x.c
--- clean-3.3-rc5/arch/arm/mach-pxa/pxa25x.c	2012-02-25 20:18:16.000000000 +0000
+++ linux-3.3-rc5/arch/arm/mach-pxa/pxa25x.c	2012-02-26 04:21:58.754346549 +0000
@@ -209,6 +209,7 @@ static struct clk_lookup pxa25x_clkregs[
 	INIT_CLKREG(&clk_pxa25x_gpio11, NULL, "GPIO11_CLK"),
 	INIT_CLKREG(&clk_pxa25x_gpio12, NULL, "GPIO12_CLK"),
 	INIT_CLKREG(&clk_pxa25x_mem, "pxa2xx-pcmcia", NULL),
+	INIT_CLKREG(&clk_dummy, "pxa-gpio", NULL),
 };
 
 static struct clk_lookup pxa25x_hwuart_clkreg =
diff -uprN clean-3.3-rc5/arch/arm/mach-pxa/pxa27x.c linux-3.3-rc5/arch/arm/mach-pxa/pxa27x.c
--- clean-3.3-rc5/arch/arm/mach-pxa/pxa27x.c	2012-02-25 20:18:16.000000000 +0000
+++ linux-3.3-rc5/arch/arm/mach-pxa/pxa27x.c	2012-02-26 04:21:58.754346549 +0000
@@ -230,6 +230,7 @@ static struct clk_lookup pxa27x_clkregs[
 	INIT_CLKREG(&clk_pxa27x_im, NULL, "IMCLK"),
 	INIT_CLKREG(&clk_pxa27x_memc, NULL, "MEMCLK"),
 	INIT_CLKREG(&clk_pxa27x_mem, "pxa2xx-pcmcia", NULL),
+	INIT_CLKREG(&clk_dummy, "pxa-gpio", NULL),
 };
 
 #ifdef CONFIG_PM
