From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 7 Dec 2010 19:50:02 +0100
Subject: [PATCH v2] watchdog: imx: use clk_get to acquire the watchdogclock
In-Reply-To: <4CFE6BDF.9030706@freescale.com>
References: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com>
	<20101207164905.GD6017@pengutronix.de>
	<4CFE6BDF.9030706@freescale.com>
Message-ID: <20101207185002.GE6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 03:16:15PM -0200, Fabio Estevam wrote:
> Hi Sascha,
>
> On 12/7/2010 2:49 PM, Sascha Hauer wrote:
> ...
>> I should have seen this happen. This breaks i.MX1 reset which uses
>> imx-wdt.0.
>
> I think it doesn?t break current mx1 reset mechanism. Please see the  
> code below (arcm/arm/plat-mxc/system.c):
>
> 	if (cpu_is_mx1()) {
> 		wcr_enable = (1 << 0);
> 	} else {
> 		struct clk *clk;
>
> 		clk = clk_get_sys("imx2-wdt.0", NULL);
> 		if (!IS_ERR(clk))
> 			clk_enable(clk);
> 		wcr_enable = (1 << 2);
> 	}
>
> For mx1 the clk_get_sys function is not called.

Oh, you are right. In this case your patch is ok.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
