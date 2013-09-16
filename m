From: marex@denx.de (Marek Vasut)
Date: Mon, 16 Sep 2013 16:19:55 +0200
Subject: [PATCH 4/6] Staging/iio/adc/touchscreen/MXS: add i.MX23 support
 to the LRADC touchscreen driver
In-Reply-To: <201309161014.27482.jbe@pengutronix.de>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de>
 <523590E1.6030309@kernel.org> <201309161014.27482.jbe@pengutronix.de>
Message-ID: <201309161619.55333.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear J?rgen Beisert,

> Hi Jonathan,
> 
> On Sunday 15 September 2013 12:50:09 Jonathan Cameron wrote:
> > On 09/11/13 09:18, Juergen Beisert wrote:
> > > Distinguish i.MX23 and i.MX28 at runtime and do the same for both SoC
> > > at least for the 4 wire touchscreen.
> > > 
> > > Note: support for the remaining LRADC channels is not tested on an
> > > i.MX23 yet.
> > 
> > An ominous comment. Are you likely to test them soon?
> 
> Sorry, currently no i.MX28 hardware available. Someone out here with an
> i.MX28 based system with a touchscreen to test?

You mean 23, no? I can test both, I have the DENX EVK as well as both MX23EVK 
and MX28EVK. Just need to find some more time to do my maintainance rounds, but 
that should happen this week nonetheless. If I do forget, please ping me again.

> > Minor code layout comment inline but otherwise I'm just looking for an
> > ack from Marek.
> > 
> > > [...]
> > > 
> > >  static u32 mxs_lradc_drive_pressure(struct mxs_lradc *lradc)
> > >  {
> > > 
> > > +	if (lradc->soc == IMX23_LRADC)
> > > +		return LRADC_CTRL0_MX23_YP | LRADC_CTRL0_MX23_XM;
> > > 
> > >  	return LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW;
> > 
> > Whilst it obviously doesn't actually matter, having an else
> > in there would make the code more consistent so personally
> > I would prefer it to be there.
> 
> I can change it. Anyone here with objections against such a change?
> 
> Regards
> Juergen

Best regards,
Marek Vasut
