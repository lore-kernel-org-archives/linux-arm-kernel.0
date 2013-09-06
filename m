From: marex@denx.de (Marek Vasut)
Date: Fri, 6 Sep 2013 14:58:25 +0200
Subject: [PATCH 4/5] Staging/iio/adc/touchscreen/MXS: add interrupt driven
 touch detection
In-Reply-To: <201309061430.50736.jbe@pengutronix.de>
References: <1378462123-4830-1-git-send-email-jbe@pengutronix.de>
 <20130906122611.GT6329@mwanda> <201309061430.50736.jbe@pengutronix.de>
Message-ID: <201309061458.25841.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear J?rgen Beisert,

> On Friday 06 September 2013 14:26:11 Dan Carpenter wrote:
> > On Fri, Sep 06, 2013 at 12:08:42PM +0200, Juergen Beisert wrote:
> > > +static int mxs_lradc_read_ts_channel(struct mxs_lradc *lradc)
> > > +{
> > > +	u32 reg;
> > > +	int val;
> > > +
> > > +	reg = readl(lradc->base + LRADC_CTRL1);
> > > +
> > > +	/* only channels 3 to 5 are of interest here */
> > > +	if (reg & LRADC_CTRL1_LRADC_IRQ(TS_CH_YP)) {
> > > +		pr_devel("!3");
> > 
> > Gar.  I meant to comment on this the first time this patch was sent.
> > 
> > Please remove the pr_devel() calls.  They are nonsense.
> 
> They are very helpful for development to monitor the statemachine... :) But
> you are right, I will remove them.

You can put them into a separate patch which can be NAK'd separatelly :)

Best regards,
Marek Vasut
