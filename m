From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 3 Jan 2014 15:08:26 -0800
Subject: [PATCHv8 RFC] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <f9527d65aa234f40af2830d9fb139bbb@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1388726661-3391-1-git-send-email-Li.Xiubo@freescale.com>
 <20140103074511.GA10680@core.coreip.homeip.net>
 <f9527d65aa234f40af2830d9fb139bbb@BY2PR03MB505.namprd03.prod.outlook.com>
Message-ID: <20140103230826.GB13489@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 09:16:06AM +0000, Li.Xiubo at freescale.com wrote:
> Hi Dmitry,
> 
> > Subject: Re: [PATCHv8 RFC] pwm: Add Freescale FTM PWM driver support
> > 
> > Hi Xiubo,
> > 
> > On Fri, Jan 03, 2014 at 01:24:21PM +0800, Xiubo Li wrote:
> > > +
> > > +static inline int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc,
> > > +					       enum fsl_pwm_clk index)
> > > +{
> > 
> > Why do you declare this (and other module-local) function as inline?
> > It is usually better let compiler decide if given function should be
> > inlined or not.
> > 
> 
> Could the compiler know when the given function should be inlined by
> not declare it?

Yes.

> And when will be inlined ?

When it makes sense to do so from compiler's point of view: i.e. it is
smallish or with single call site and there are enough registers, etc,
etc.

Thanks.

-- 
Dmitry
