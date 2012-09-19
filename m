From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 19 Sep 2012 09:32:49 +0800
Subject: [PATCH v2 RESEND] USB: chipidea: convert to use devm_request_irq
In-Reply-To: <201209190330.41648.marex@denx.de>
References: <1348017626-6570-1-git-send-email-richard.zhao@freescale.com>
 <201209190330.41648.marex@denx.de>
Message-ID: <20120919013248.GG13530@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 03:30:41AM +0200, Marek Vasut wrote:
> Dear Richard Zhao,
> 
> You know, commit message would be nice to have.
Yes, but for this one, the title shows obviously what it changed,
doesn't it?

Thanks
Richard
> 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> 
> Otherwise
> 
> Reviewed-by: Marek Vasut <marex@denx.de>
> 
> > ---
> >  drivers/usb/chipidea/core.c |    5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> > index 307651b..0942b9b 100644
> > --- a/drivers/usb/chipidea/core.c
> > +++ b/drivers/usb/chipidea/core.c
> > @@ -486,8 +486,8 @@ static int __devinit ci_hdrc_probe(struct
> > platform_device *pdev) }
> > 
> >  	platform_set_drvdata(pdev, ci);
> > -	ret = request_irq(ci->irq, ci_irq, IRQF_SHARED, ci->platdata->name,
> > -			  ci);
> > +	ret = devm_request_irq(dev, ci->irq, ci_irq, IRQF_SHARED,
> > +				ci->platdata->name, ci);
> >  	if (ret)
> >  		goto stop;
> > 
> > @@ -518,7 +518,6 @@ static int __devexit ci_hdrc_remove(struct
> > platform_device *pdev) flush_workqueue(ci->wq);
> >  	destroy_workqueue(ci->wq);
> >  	device_remove_file(ci->dev, &dev_attr_role);
> > -	free_irq(ci->irq, ci);
> >  	ci_role_stop(ci);
> > 
> >  	return 0;
> 
> Best regards,
> Marek Vasut
> 
