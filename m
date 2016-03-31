From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 31 Mar 2016 09:57:49 +0200
Subject: [PATCH v5 05/46] pwm: introduce the pwm_args concept
In-Reply-To: <20160330215510.GS18567@codeaurora.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-6-git-send-email-boris.brezillon@free-electrons.com>
 <20160330215510.GS18567@codeaurora.org>
Message-ID: <20160331095749.4be1e76b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Mar 2016 14:55:10 -0700
Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 03/30, Boris Brezillon wrote:
> > @@ -74,6 +74,23 @@ enum pwm_polarity {
> >  	PWM_POLARITY_INVERSED,
> >  };
> >  
> > +/**
> > + * struct pwm_args - PWM arguments
> > + * @period: reference period
> > + * @polarity: reference polarity
> > + *
> > + * This structure describe board-dependent arguments attached to a PWM
> 
> s/describe/describes/
> 
> > + * device. Those arguments are usually retrieved from the PWM lookup table or
> > + * DT definition.
> > + * This should not be confused with the PWM state: PWM args not representing
> 
> s/not representing/don't represent/ ?

Yes, I meant "are not representing", but "don't represent" is fine.

> 
> > + * the current PWM state, but the configuration the PWM user plan to use
> 
> s/plan/plans/
> 
> > + * on this PWM device.
> > + */
> > +struct pwm_args {
> > +	unsigned int period;
> > +	enum pwm_polarity polarity;
> > +};
> > +
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
