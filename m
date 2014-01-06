From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Mon, 6 Jan 2014 05:25:32 +0000
Subject: [PATCHv8 RFC] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <20140103230826.GB13489@core.coreip.homeip.net>
References: <1388726661-3391-1-git-send-email-Li.Xiubo@freescale.com>
 <20140103074511.GA10680@core.coreip.homeip.net>
 <f9527d65aa234f40af2830d9fb139bbb@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140103230826.GB13489@core.coreip.homeip.net>
Message-ID: <0773adbc0c0f4406ab6df6480d4aef51@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > +static inline int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc,
> > > > +					       enum fsl_pwm_clk index)
> > > > +{
> > >
> > > Why do you declare this (and other module-local) function as inline?
> > > It is usually better let compiler decide if given function should be
> > > inlined or not.
> > >
> >
> > Could the compiler know when the given function should be inlined by
> > not declare it?
> 
> Yes.
> 
> > And when will be inlined ?
> 
> When it makes sense to do so from compiler's point of view: i.e. it is
> smallish or with single call site and there are enough registers, etc,
> etc.
>

Well, the inline is not very useful here, I will revise this.


Thanks,

--
Best Regards,
Xiubo
