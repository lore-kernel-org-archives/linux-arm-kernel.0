From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 07 Aug 2013 21:49:33 +0200
Subject: [PATCH v6 13/20] pwm: Add new pwm-samsung driver
In-Reply-To: <CAL1qeaF1Mxs_Q6QnLznW3SoXBoNhBb+gCYMESMgx6g+bUFVCmQ@mail.gmail.com>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
 <1374623475.SoL01ZHzWk@flatron>
 <CAL1qeaF1Mxs_Q6QnLznW3SoXBoNhBb+gCYMESMgx6g+bUFVCmQ@mail.gmail.com>
Message-ID: <4144776.HcbubHMX0J@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 of August 2013 12:35:42 Andrew Bresticker wrote:
> Hi Tomasz,
> 
> > +#ifndef CONFIG_CLKSRC_SAMSUNG_PWM
> > +/*
> > + * PWM block is shared between pwm-samsung and samsung_pwm_timer
> > drivers + * and some registers need access synchronization. If both
> > drivers are + * compiled in, the spinlock is defined in the
> > clocksource driver, + * otherwise following definition is used.
> > + *
> > + * Currently we do not need any more complex synchronization method
> > + * because all the supported SoCs contain only one instance of the
> > PWM
> > + * IP. Should this change, both drivers will need to be modified to
> > + * properly synchronize accesses to particular instances.
> > + */
> > +static DEFINE_SPINLOCK(samsung_pwm_lock);
> 
> Shouldn't this not be static?

It should be static, when the clocksource driver is not used, but...

> It's declared in
> clocksource/samsung_pwm.h whether or not the samsung_pwm_timer is
> compiled in or not.

..it should not be defined as non-static in this case (= an ifdef is 
needed in this header). I believe I had this already fixed, not sure what 
happened with the fix...

Best regards,
Tomasz
