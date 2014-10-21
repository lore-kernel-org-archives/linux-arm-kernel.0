From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 21 Oct 2014 01:25:07 +0000
Subject: [PATCH 2/3] i2c/at91: add support for system PM
In-Reply-To: <7h8ukafvzm.fsf@deeprootsystems.com>
References: <1413776535-10123-1-git-send-email-wenyou.yang@atmel.com>
 <1413776535-10123-3-git-send-email-wenyou.yang@atmel.com>
 <7h8ukafvzm.fsf@deeprootsystems.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641BF596753@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at kernel.org]
> Sent: Tuesday, October 21, 2014 2:16 AM
> To: Yang, Wenyou
> Cc: wsa at the-dreams.de; Desroches, Ludovic; linux-i2c at vger.kernel.org; linux-
> kernel at vger.kernel.org; Ferre, Nicolas; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 2/3] i2c/at91: add support for system PM
> 
> Wenyou Yang <wenyou.yang@atmel.com> writes:
> 
> Add a changelog here describing what you're doing, and why.
> 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> >  drivers/i2c/busses/i2c-at91.c |   30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/drivers/i2c/busses/i2c-at91.c
> > b/drivers/i2c/busses/i2c-at91.c index 03b9f48..8f408f8 100644
> > --- a/drivers/i2c/busses/i2c-at91.c
> > +++ b/drivers/i2c/busses/i2c-at91.c
> > @@ -845,6 +845,35 @@ static int at91_twi_remove(struct platform_device
> > *pdev)  }
> >
> >  #ifdef CONFIG_PM
> > +#ifdef CONFIG_PM_SLEEP
> > +static int at91_twi_suspend(struct device *dev) {
> > +	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
> > +
> > +	if (!pm_runtime_suspended(dev))
> > +		clk_disable_unprepare(twi_dev->clk);
> 
> I would just call at91_twi_runtime_suspend() here.
> 
> Then, if you need to add additional steps, you only have to add them in once
> place.  This also makes it obvious that ->suspend and
> ->runtime_suspend are doing the exact same thing.
> 
> NOTE: you'll need to wrap the runtime_suspend|resume functions in just
> CONFIG_PM instead of CONFIG_PM_RUNTIME for this to work.
Thanks a lot, I will modify it.

> 
> Kevin

Best Regards,
Wenyou Yang
