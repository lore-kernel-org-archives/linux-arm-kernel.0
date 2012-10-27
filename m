From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 27 Oct 2012 13:57:56 +0200
Subject: [GIT PULL] i.MX fixes for -rc
In-Reply-To: <201210262101.44700.arnd@arndb.de>
References: <20121024075656.GW27665@pengutronix.de>
 <201210262101.44700.arnd@arndb.de>
Message-ID: <20121027115756.GC1641@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 09:01:44PM +0000, Arnd Bergmann wrote:
> On Wednesday 24 October 2012, Sascha Hauer wrote:
> >       ARM i.MX25: Fix PWM per clock lookups
> 
> This patch is now causing build errors in imx_v4_v5_defconfig:
> 
> arch/arm/mach-imx/clk-imx25.c: In function 'mx25_clocks_init':
> arch/arm/mach-imx/clk-imx25.c:206:26: error: 'pwm_ipg_per' undeclared (first use in this function)
> arch/arm/mach-imx/clk-imx25.c:206:26: note: each undeclared identifier is reported only once for each function it appears in
> 
> Any idea what went wrong? The symbol doesn't seem to exist anywhere in
> v3.7-rc2. Should I revert this patch for now?

Yes, please revert it for now.

There are several gates missing in clk-imx25.c. I have a patch which
adds support for them and I seem to have missed that the above depends
on it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
