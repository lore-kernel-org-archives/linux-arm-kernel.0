From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Fri, 10 Sep 2010 12:04:33 +0200
Subject: [PATCH 2/6] i.MX5/clock: add eCSPI and CSPI clock definitions
In-Reply-To: <20100910094714.GF30558@pengutronix.de>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-3-git-send-email-jason77.wang@gmail.com>
	<20100902150112.GM14214@pengutronix.de>
	<4C809410.9090602@gmail.com>
	<20100910094714.GF30558@pengutronix.de>
Message-ID: <19594.689.326396.859751@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Uwe Kleine-K?nig writes:
> >>> +static struct clk ecspi2_ipg_clk = {
> >>> +	.parent = &ipg_clk,
> >>> +	.secondary = &aips_tz2_clk,
> >>> +	.enable_reg = MXC_CCM_CCGR4,
> >>> +	.enable_shift = MXC_CCM_CCGRx_CG11_OFFSET,
> >>> +	.enable = _clk_ccgr_enable_inrun,
> >>> +	.disable = _clk_ccgr_disable,
> >>> +};
> aips_tz2_clk is wrong here, no?  Sascha used spba_clk here, too.  I
> didn't found out yet how to read that out of the reference manual.
> 
The Freescale BSP used aips_tz2_clk (and spba for cspi1). They should
know what's right. Maybe a copy/paste error from Sascha?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
