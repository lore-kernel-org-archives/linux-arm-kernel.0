From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 29 Mar 2011 19:56:47 +0200
Subject: [PATCH 1/4] arm: lpc32xx: add tsc-device
In-Reply-To: <20110329170219.GA6762@pengutronix.de>
References: <1301328090-25994-1-git-send-email-w.sang@pengutronix.de>
	<083DF309106F364B939360100EC290F811ECEDC208@eu1rdcrdc1wx030.exi.nxp.com>
	<20110329170219.GA6762@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F811ECEDC221@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Subject: Re: [PATCH 1/4] arm: lpc32xx: add tsc-device
> 
> On Tue, Mar 29, 2011 at 06:43:45PM +0200, Kevin Wells wrote:
> > Hi Wolfram,
> >
> > Thanks for submitting these. These all look good!
> >
> > > +/* TSC (Touch Screen Controller) */
> > > +
> > > +static struct resource lpc32xx_tsc_resources[] = {
> > > +	{
> > > +		.start = LPC32XX_ADC_BASE,
> > > +		.end = LPC32XX_ADC_BASE + SZ_16K - 1,
> >
> > The LPC32xx user's guide spaces peripheral register sets 16K apart,
> > but internally the register blocks are 4K or smaller. I'm not sure
> > why these need to be setup as 16K instead of 4K. Hmm, maybe I'm
> > missing something here?
> 
> Probably not. I just took the user's guide as a reference. If you know
> this is
> wrong, I can respin the series. ADC is also 4K?

Yes, WDT/ADC/RTC are all 4K register blocks.

> 
> Thanks,
> 
>    Wolfram
> 
> --
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
