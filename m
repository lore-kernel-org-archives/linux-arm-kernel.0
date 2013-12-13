From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 13 Dec 2013 09:30:09 +0000
Subject: [PATCHv6 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <20131128212510.GC14689@mithrandir>
References: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
 <1384220218-12716-2-git-send-email-Li.Xiubo@freescale.com>
 <20131128212510.GC14689@mithrandir>
Message-ID: <e2fc53d0ff1d4a0a962500be6dc6e019@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +	struct fsl_pwm_chip *fpc;
> > +
> > +	fpc = to_fsl_chip(chip);
> > +
> > +	period_cycles = fsl_rate_to_cycles(fpc, period_ns);
> > +	if (period_cycles > 0xFFFF) {
> > +		dev_err(chip->dev, "required PWM period cycles(%lu) overflow "
> > +				"16-bits counter!\n", period_cycles);
> > +		return -EINVAL;
> > +	}
> > +
> > +	duty_cycles = fsl_rate_to_cycles(fpc, duty_ns);
> > +	if (duty_cycles >= 0xFFFF) {
> > +		dev_err(chip->dev, "required PWM duty cycles(%lu) overflow "
> > +				"16-bits counter!\n", duty_cycles);
> > +		return -EINVAL;
> > +	}
> 
> I'm not sure the error messages are all that useful. A -EINVAL error code
> should make it pretty clear what the problem is.
> 

Yes, it is.

But for the pwm leds, there hasn't any check about the return values, if
there is something wrong, we cannot get any information about this.

So I think this error messages are useful for this case.


--
Xiubo
