From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 14 Jan 2014 10:16:27 +0100
Subject: [PATCH V4 1/6] ARM: dts: imx6q: add common compatible name for
 reused modules
In-Reply-To: <20140114022609.GA1896@S2101-09.ap.freescale.net>
References: <1389614031-7253-1-git-send-email-b20788@freescale.com>
 <20140113121016.GJ16215@pengutronix.de>
 <20140113142249.GW23525@S2101-09.ap.freescale.net>
 <20140113151623.GL16215@pengutronix.de>
 <20140114022609.GA1896@S2101-09.ap.freescale.net>
Message-ID: <20140114091626.GM16215@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 10:26:11AM +0800, Shawn Guo wrote:
> 
> Since the assembly function imx6_suspend() needs to check the cpu_type,
> we have to keep it in imx6_cpu_pm_info.  So I assume you're suggesting
> we remove the field from imx6_pm_socdata and determine the cpu_type by
> comparing socdata pointer with particular imx6_pm_socdata like below?
> 
> 	if (socdata == &imx6q_pm_data)
> 		pm_info->cpu_type = MXC_CPU_IMX6Q;
> 	else if (socdata == &imx6dl_pm_data)
> 		pm_info->cpu_type = MXC_CPU_IMX6DL;
> 	else if (socdata == &imx6sl_pm_data)
> 		pm_info->cpu_type = MXC_CPU_IMX6SL;
> 
> Looking at these if-clauses, I do not think we win too much from doing
> thing in this way.

Indeed not. I thought the cpu_type field would be unused now, but this
is not the case.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
