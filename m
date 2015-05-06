From: tony@atomide.com (Tony Lindgren)
Date: Wed, 6 May 2015 08:36:56 -0700
Subject: [PATCH] gpio: omap: Fix regression for MPUIO interrupts
In-Reply-To: <CACRpkdZqSEgaVOV1gCQvCLc1-x7eU3WZwAM2QT2HT21xqCHZ2Q@mail.gmail.com>
References: <1429833257-28188-1-git-send-email-tony@atomide.com>
 <CACRpkdZqSEgaVOV1gCQvCLc1-x7eU3WZwAM2QT2HT21xqCHZ2Q@mail.gmail.com>
Message-ID: <20150506153656.GJ21061@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [150506 06:22]:
> On Fri, Apr 24, 2015 at 1:54 AM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > At some point with all the GPIO clean-up we've broken the
> > MPUIO interrupts. Those are just a little bit different from
> > the GPIO interrupts, so we can fix it up just by setting
> > different irqchip functions for it. And then we can just
> > remove all old code trying to do the same.
> >
> > Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Javier Martinez Canillas <javier@dowhile0.org>
> > Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: Santosh Shilimkar <ssantosh@kernel.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Patch applied for fixes with the ACKs etc,

Thanks. Yes this should go in during the -rc cycle as a regresion
fix. Sorry I could not exactly pinpoint where we've broken the
MPUIO interrupts with all the clean-up.

Also the omap1 SPARSE_IRQ changes I recently posted have a
dependency to this one so that's another reason to get this
one out of the way.

No rush with the other ones, those should be OK for v4.2.

Regards,

Tony
