From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 4 Jul 2011 18:26:59 +0800
Subject: [PATCH 1/2] serial/imx: get rid of the uses of cpu_is_mx1()
In-Reply-To: <20110704092805.GH4338@pengutronix.de>
References: <1309679760-22796-1-git-send-email-shawn.guo@linaro.org>
	<1309679760-22796-2-git-send-email-shawn.guo@linaro.org>
	<20110703211007.GB13742@ponder.secretlab.ca>
	<20110704021923.GA10245@S2100-06.ap.freescale.net>
	<20110704073320.GB4338@pengutronix.de>
	<20110704084324.GE10245@S2100-06.ap.freescale.net>
	<20110704092805.GH4338@pengutronix.de>
Message-ID: <20110704102657.GI10245@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 11:28:05AM +0200, Uwe Kleine-K?nig wrote:
> Hello Shawn,
> 
> On Mon, Jul 04, 2011 at 04:43:25PM +0800, Shawn Guo wrote:
> > On Mon, Jul 04, 2011 at 09:33:20AM +0200, Uwe Kleine-K?nig wrote:
> > > On Mon, Jul 04, 2011 at 10:19:25AM +0800, Shawn Guo wrote:
> > > > > > +static struct platform_device_id imx_uart_devtype[] = {
> > > > > > +	{
> > > > > > +		.name = "imx1-uart",
> > > > > > +		.driver_data = IMX1_UART,
> > > > > > +	}, {
> > > > > > +		.name = "imx-uart",
> > > > > > +		.driver_data = IMX2_UART,
> > > It feels strange to introduce IMX2 today meaning
> > > i.MX{21,25,27,31,35,50,51,53}. I didn't check the changes in detail, but
> > > if the only relevant change is that the UTS register is at a different
> > 
> > No, it's not the only relevant change.  The patch also changes a couple of
> > 'if (!cpu_is_imx1())' to 'if (IS_IMX2_UART())'.
> > 
> > The 'IMX2' in 'IMX2_UART' does not necessarily mean i.MX{21,25,27,
> > 31,35,50,51,53}.  It actually means i.MX{21,25,27,31,35,50,51,53} all
> > have the same UART block which was firstly introduced on IMX2.
> This is ugly. IMHO something like imx_uart_v2 would be much better.

I will be very careful to define version number for IP block while
hardware people do not.  When some day they do, we will probably have
the version number we defined today conflicting with the one they
will define.

> For a driver that supports all i.MX generations
> 
> 	if (IS_IMX2_UART())
> 
> is simply misleading. Even if you had documented at the definition
> of imx_uart_type (and/or IS_IMX2_UART) that IMX2_UART means everything
> currently known but MX1, just looking at the if condition yields wrong
> expectations.
> 
To address your concern, I will rename IMX2_UART to IMX_UART.

-- 
Regards,
Shawn
