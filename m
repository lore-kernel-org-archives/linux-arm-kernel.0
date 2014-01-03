From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 3 Jan 2014 09:16:06 +0000
Subject: [PATCHv8 RFC] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <20140103074511.GA10680@core.coreip.homeip.net>
References: <1388726661-3391-1-git-send-email-Li.Xiubo@freescale.com>
 <20140103074511.GA10680@core.coreip.homeip.net>
Message-ID: <f9527d65aa234f40af2830d9fb139bbb@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

> Subject: Re: [PATCHv8 RFC] pwm: Add Freescale FTM PWM driver support
> 
> Hi Xiubo,
> 
> On Fri, Jan 03, 2014 at 01:24:21PM +0800, Xiubo Li wrote:
> > +
> > +static inline int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc,
> > +					       enum fsl_pwm_clk index)
> > +{
> 
> Why do you declare this (and other module-local) function as inline?
> It is usually better let compiler decide if given function should be
> inlined or not.
> 

Could the compiler know when the given function should be inlined by not declare it?
And when will be inlined ?

> [...]
> 
> > +
> > +static int fsl_pwm_remove(struct platform_device *pdev)
> > +{
> > +	struct fsl_pwm_chip *fpc = platform_get_drvdata(pdev);
> > +
> > +	mutex_destroy(&fpc->lock);
> > +
> > +	return pwmchip_remove(&fpc->chip);
> 
> fpc->lock will be used while pwmchip_remove() is running so you should
> not be destroying it before calling pwmchip_remove(). It should probbaly
> go into free() method or just drop it altogether.
> 

Yes, I think I should drop it here as Thierry has already pointed out.


Thanks very much.

--
Best Regards,
Xiubo
